#!/usr/bin/env ruby
lib_dir = File.expand_path('../lib', __dir__)
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)
require 'usps_intelligent_barcode'

# Generate an SVG image of a USPS Intelligent Mail Barcode
#
# The barcode consists of 65 bars with varying heights:
# - Ascender (A): Tall bar extending up
# - Descender (D): Tall bar extending down
# - Tracker (T): Short bar in the middle
# - Full (F): Very tall bar extending both up and down

class BarcodeToSVG
  OUTPUT_DIR = '/tmp'
  OUTPUT_FILENAME = 'barcode.svg'
  OUTPUT_PATH = File.join(OUTPUT_DIR, OUTPUT_FILENAME)
  SCALE = 3
  # Dimensions from USPS-B-3200 spec (in points, scaled by SCALE for visibility)
  BAR_WIDTH = 1.44 * SCALE       # points
  BAR_SPACING = 0.78 * SCALE     # points
  TRACKER_HEIGHT = 4.32 * SCALE  # points
  ASCENDER_HEIGHT = 6.35 * SCALE # points
  DESCENDER_HEIGHT = 6.35 * SCALE # points
  FULL_HEIGHT = ASCENDER_HEIGHT + TRACKER_HEIGHT + DESCENDER_HEIGHT

  def initialize(barcode)
    @barcode = barcode
    @letters = barcode.barcode_letters
  end

  def generate
    width = @letters.length * (BAR_WIDTH + BAR_SPACING) + BAR_SPACING
    height = FULL_HEIGHT + 2 * SCALE
    svg = []
    svg << '<?xml version="1.0" encoding="UTF-8"?>'
    svg << %Q{<svg xmlns="http://www.w3.org/2000/svg" width="#{width}" height="#{height}" viewBox="0 0 #{width} #{height}">}
    svg << %Q{  <rect width="#{width}" height="#{height}" fill="white"/>}
    x = BAR_SPACING
    @letters.each_char do |letter|
      svg << draw_bar(x, letter)
      x += BAR_WIDTH + BAR_SPACING
    end
    svg << '</svg>'
    svg.join("\n")
  end

  private

  def draw_bar(x, letter)
    y, height = case letter
    when 'T'
      [ASCENDER_HEIGHT + SCALE, TRACKER_HEIGHT]
    when 'A'
      [SCALE, ASCENDER_HEIGHT + TRACKER_HEIGHT]
    when 'D'
      [ASCENDER_HEIGHT + SCALE, TRACKER_HEIGHT + DESCENDER_HEIGHT]
    when 'F'
      [SCALE, FULL_HEIGHT]
    end
    %Q{  <rect x="#{x}" y="#{y}" width="#{BAR_WIDTH}" height="#{height}" fill="black"/>}
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

svg = BarcodeToSVG.new(barcode).generate
File.write(BarcodeToSVG::OUTPUT_PATH, svg)
puts "Generated #{BarcodeToSVG::OUTPUT_PATH}"
puts "Barcode string: #{barcode.barcode_letters}"
