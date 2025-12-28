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

# Generate a PDF with a USPS Intelligent Mail Barcode
#
# The barcode consists of 65 bars with varying heights:
# - Ascender (A): Tall bar extending up
# - Descender (D): Tall bar extending down
# - Tracker (T): Short bar in the middle
# - Full (F): Very tall bar extending both up and down

class BarcodeToPDF
  BAR_WIDTH = 1.44
  BAR_SPACING = 0.78
  TRACKER_HEIGHT = 4.32
  ASCENDER_HEIGHT = 6.35
  DESCENDER_HEIGHT = 6.35
  FULL_HEIGHT = ASCENDER_HEIGHT + TRACKER_HEIGHT + DESCENDER_HEIGHT

  def initialize(barcode)
    @barcode = barcode
    @letters = barcode.barcode_letters
  end

  def generate(filename)
    Prawn::Document.generate(filename, page_size: 'LETTER') do |pdf|
      pdf.text "USPS Intelligent Mail Barcode", size: 16, style: :bold
      pdf.move_down 10

      pdf.text "Barcode ID: #{@barcode.barcode_id}"
      pdf.text "Service Type: #{@barcode.service_type}"
      pdf.text "Mailer ID: #{@barcode.mailer_id}"
      pdf.text "Serial Number: #{@barcode.serial_number}"
      pdf.text "Routing Code: #{@barcode.routing_code}"
      pdf.move_down 20

      draw_barcode(pdf, 50, pdf.cursor)

      pdf.move_down FULL_HEIGHT + 10
      pdf.text "Barcode string: #{@letters}", size: 8
    end
  end

  private

  def draw_barcode(pdf, x, y)
    current_x = x
    @letters.each_char do |letter|
      bar_y, height = case letter
      when 'T'
        [y - ASCENDER_HEIGHT - TRACKER_HEIGHT, TRACKER_HEIGHT]
      when 'A'
        [y - ASCENDER_HEIGHT - TRACKER_HEIGHT, ASCENDER_HEIGHT + TRACKER_HEIGHT]
      when 'D'
        [y - ASCENDER_HEIGHT - TRACKER_HEIGHT - DESCENDER_HEIGHT, TRACKER_HEIGHT + DESCENDER_HEIGHT]
      when 'F'
        [y - FULL_HEIGHT, FULL_HEIGHT]
      end

      pdf.fill_color '000000'
      pdf.fill_rectangle [current_x, bar_y + height], BAR_WIDTH, height

      current_x += BAR_WIDTH + BAR_SPACING
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

pdf_generator = BarcodeToPDF.new(barcode)
pdf_generator.generate('barcode.pdf')
puts "Generated barcode.pdf"
puts "Barcode string: #{barcode.barcode_letters}"
