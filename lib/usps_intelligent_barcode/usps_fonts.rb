module Imb

  # Provides access to bundled USPS Intelligent Mail Barcode fonts
  class UspsFonts

    # USPS recommended font size in points (16pt for standard fonts per spec)
    STANDARD_FONT_SIZE = 16

    # Returns path to the standard USPS IMB font (recommended for most use)
    # USPSIMBStandard is the primary USPS Intelligent Mail Barcode font
    # @return [String] absolute path to USPSIMBStandard.ttf
    def self.standard_font_path
      font_path('USPSIMBStandard.ttf')
    end

    # Returns path to the compact USPS IMB font
    # USPSIMBCompact provides a more compact barcode rendering
    # @return [String] absolute path to USPSIMBCompact.ttf
    def self.compact_font_path
      font_path('USPSIMBCompact.ttf')
    end

    # Returns paths to all bundled USPS fonts
    # @return [Hash<Symbol, String>] font name symbols to file paths
    def self.all_font_paths
      {
        standard: standard_font_path,
        compact: compact_font_path
      }
    end

    # Returns the USPS-recommended font size
    # @return [Integer] font size in points (16pt)
    def self.font_size
      STANDARD_FONT_SIZE
    end

    private

    # Returns absolute path to a font file in the bundled fonts directory
    # @param filename [String] font filename
    # @return [String] absolute path to font file
    def self.font_path(filename)
      File.join(ProjectDirs.font_dir, filename)
    end

  end
end
