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
# Requires one of the USPS IMB fonts to be installed:
# https://ribbs.usps.gov/onecodesolution/download.cfm
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
  FONT_SIZE = 24 # points

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
      pdf.text "Note: Requires USPS IMB font installed from:", size: 10
      pdf.text "https://ribbs.usps.gov/onecodesolution/download.cfm", size: 10
    end
  end

  private

  def render_barcode(pdf)
    pdf.font(FONT_NAME) do
      pdf.text @letters, size: FONT_SIZE
    end
  rescue Prawn::Errors::UnknownFont
    pdf.text "ERROR: Font '#{FONT_NAME}' not found", size: 12, style: :bold
    pdf.text "Please install USPS IMB fonts from:", size: 10
    pdf.text "https://ribbs.usps.gov/onecodesolution/download.cfm", size: 10
    pdf.move_down 10
    pdf.text "Barcode letters (install font to render): #{@letters}", size: 8
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
puts "Note: Requires USPS IMB font installed from:"
puts "https://ribbs.usps.gov/onecodesolution/download.cfm"
