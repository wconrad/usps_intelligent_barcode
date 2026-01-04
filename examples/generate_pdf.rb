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
# Uses bundled USPS IMB fonts - no installation required.

class BarcodeToPDFFont
  OUTPUT_FILENAME = 'barcode_font.pdf'
  FONT_NAME = 'USPSIMBStandard'
  FONT_FILE = Imb::UspsFonts.standard_font_path
  FONT_SIZE = Imb::UspsFonts.font_size

  def initialize(barcode)
    @barcode = barcode
    @letters = barcode.barcode_letters
  end

  def generate(path)
    Prawn::Document.generate(path, page_size: 'LETTER') do |pdf|
      pdf.text "USPS Intelligent Mail Barcode (Font-Based)", size: 16, style: :bold
      pdf.move_down 10
      pdf.text "Barcode ID: #{@barcode.barcode_id.to_s}"
      pdf.text "Service Type: #{@barcode.service_type.to_s}"
      pdf.text "Mailer ID: #{@barcode.mailer_id.to_s}"
      pdf.text "Serial Number: #{@barcode.serial_number.to_s}"
      pdf.text "Routing Code: #{@barcode.routing_code.to_s}"
      pdf.text "\n"
      pdf.text "Barcode string: #{@letters}", size: 8
      pdf.text "\n"
      pdf.text "Barcode string printed with font #{FONT_NAME} #{FONT_SIZE}"
      render_barcode(pdf)
      pdf.move_down 10
    end
  end

  private

  def render_barcode(pdf)
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
path = "/tmp/barcode_to_pdf.pdf"
pdf_generator.generate(path)
puts "Generated #{path}"
