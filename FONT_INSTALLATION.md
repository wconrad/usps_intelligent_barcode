# Installing USPS Intelligent Mail Barcode Fonts

## Bundled Fonts (Recommended)

The USPS fonts are bundled with this gem - no installation required!

The PDF generation example automatically uses the bundled fonts:

```bash
gem install prawn
ruby examples/generate_pdf.rb
```

The bundled fonts are located in the gem's `fonts/` directory and are
licensed by USPS for royalty-free use (see `fonts/LICENSE`).

The example embeds the bundled font into the generated PDF, so the PDF will
display correctly on any system without requiring font installation. If you
create your own PDF that does not embed the font, you will need to install
the font system-wide to view the generated PDF.

## System Installation (Optional)

If you prefer to install the fonts system-wide for use in other applications,
follow these instructions.

### Download the Font

Official USPS Source (Free):

1. Visit https://postalpro.usps.com/onecodesolution
2. Download `uspsFontsNonAFP-1.4.0.zip` (TrueType format)
3. Extract and navigate to `fonts/scalable/trueType/` folder

## Installation on Linux

```
cd ~/Downloads
mkdir uspsFontsNonAFP-1.4.0.zip.d
cd uspsFontsNonAFP-1.4.0.zip.d
unzip ../uspsFontsNonAFP-1.4.0.zip
cd fonts/scalable/trueType/
sudo mkdir -p /usr/share/fonts/truetype/usps
sudo cp *.ttf /usr/share/fonts/truetype/usps/
sudo fc-cache -f
fc-list | grep -i usps
```

## Available Fonts

The package includes several fonts:

- USPSIMBStandard.ttf (recommended, used in examples)
- USPSIMBCompact.ttf (alternative)
- USPSIMB.ttf (same as Standard)
