#!/usr/bin/env ruby

lib_dir = File.expand_path('../lib', __dir__)
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)
require 'usps_intelligent_barcode'

begin
  require 'prawn'
rescue LoadError
  puts "This example requires the 'prawn' gem."
  puts "Install it with: gem install prawn"
  exit 1
end

# Generate a PDF using a USPS Intelligent Mail Barcode font
#
# Requires one of the USPS IMB fonts to be installed.
# See FONT_INSTALLATION.md for installation instructions.
#
# Font options:
# - USPSIMBCompact
# - USPSIMBStandard
# - USPSIMB (same as Standard)

class BarcodeToPDFFont
  OUTPUT_DIR = '/tmp'
  OUTPUT_FILENAME = 'barcode_font.pdf'
  OUTPUT_PATH = File.join(OUTPUT_DIR, OUTPUT_FILENAME)
  FONT_NAME = 'USPSIMBStandard'
  FONT_FILE = '/usr/share/fonts/truetype/usps/USPSIMBStandard.ttf'
  FONT_SIZE = 16 # points (USPS recommended size for standard fonts)

  def initialize(barcode)
    @barcode = barcode
    @letters = barcode.barcode_letters
  end

  def generate(filename)
    Prawn::Document.generate(filename, page_size: 'LETTER') do |pdf|
      pdf.text "USPS Intelligent Mail Barcode (Font-Based)", size: 16, style: :bold
      pdf.move_down 10
      pdf.text "Barcode ID: #{@barcode.barcode_id}"
      pdf.text "Service Type: #{@barcode.service_type}"
      pdf.text "Mailer ID: #{@barcode.mailer_id}"
      pdf.text "Serial Number: #{@barcode.serial_number}"
      pdf.text "Routing Code: #{@barcode.routing_code}"
      pdf.move_down 20
      render_barcode(pdf)
      pdf.move_down 10
      pdf.text "Barcode string: #{@letters}", size: 8
      pdf.move_down 20
      pdf.text "Note: Requires USPS IMB font to be installed.", size: 10
      pdf.text "See FONT_INSTALLATION.md for installation instructions.", size: 10
    end
  end

  private

  def render_barcode(pdf)
    unless File.exist?(FONT_FILE)
      $stderr.puts "ERROR: Font file not found: #{FONT_FILE}"
      $stderr.puts "See FONT_INSTALLATION.md for installation instructions."
      exit 1
    end
    pdf.font_families.update(FONT_NAME => { normal: FONT_FILE })
    pdf.font(FONT_NAME) do
      pdf.text @letters, size: FONT_SIZE
    end
  end
end

# Example usage
barcode = Imb::Barcode.new(
  '01',           # barcode_id
  '234',          # service_type
  '567094',       # mailer_id
  '987654321',    # serial_number
  '01234567891'   # routing_code
)

pdf_generator = BarcodeToPDFFont.new(barcode)
pdf_generator.generate(BarcodeToPDFFont::OUTPUT_PATH)
puts "Generated #{BarcodeToPDFFont::OUTPUT_PATH}"
puts "Barcode string: #{barcode.barcode_letters}"
puts ""
puts "Note: Requires USPS IMB font to be installed."
puts "See FONT_INSTALLATION.md for installation instructions."
