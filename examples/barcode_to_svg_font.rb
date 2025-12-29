#!/usr/bin/env ruby
lib_dir = File.expand_path('../lib', __dir__)
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)
require 'usps_intelligent_barcode'

# Generate an SVG using a USPS Intelligent Mail Barcode font
#
# Requires one of the USPS IMB fonts to be installed:
# https://ribbs.usps.gov/onecodesolution/download.cfm
#
# Font options:
# - USPSIMBCompact
# - USPSIMBStandard
# - USPSIMB (same as Standard)

class BarcodeToSVGFont
  OUTPUT_DIR = '/tmp'
  OUTPUT_FILENAME = 'barcode_font.svg'
  OUTPUT_PATH = File.join(OUTPUT_DIR, OUTPUT_FILENAME)
  FONT_FAMILY = 'USPSIMBStandard'
  FONT_SIZE = 16 # points (USPS recommended size for standard fonts)

  def initialize(barcode)
    @barcode = barcode
    @letters = barcode.barcode_letters
  end

  def generate
    width = estimate_width
    height = FONT_SIZE * 2
    svg = []
    svg << '<?xml version="1.0" encoding="UTF-8"?>'
    svg << %Q{<svg xmlns="http://www.w3.org/2000/svg" width="#{width}" height="#{height}" viewBox="0 0 #{width} #{height}">}
    svg << %Q{  <rect width="#{width}" height="#{height}" fill="white"/>}
    svg << %Q{  <text x="10" y="#{FONT_SIZE * 1.5}" font-family="#{FONT_FAMILY}" font-size="#{FONT_SIZE}" fill="black">#{@letters}</text>}
    svg << '</svg>'
    svg.join("\n")
  end

  private

  def estimate_width
    @letters.length * FONT_SIZE * 0.6 + 20
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

svg = BarcodeToSVGFont.new(barcode).generate
File.write(BarcodeToSVGFont::OUTPUT_PATH, svg)
puts "Generated #{BarcodeToSVGFont::OUTPUT_PATH}"
puts "Barcode string: #{barcode.barcode_letters}"
puts ""
puts "Note: Requires USPS IMB font installed from:"
puts "https://ribbs.usps.gov/onecodesolution/download.cfm"
