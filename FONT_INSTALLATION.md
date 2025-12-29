# Installing USPS Intelligent Mail Barcode Fonts

The font-based barcode examples require a USPS Intelligent Mail Barcode font
to be installed on your system.

## Download the Font

Official USPS Source (Free):

1. Visit https://postalpro.usps.com/onecodesolution
2. Download `uspsFontsNonAFP-1.4.0.zip` (TrueType format)
3. Extract and navigate to `fonts/scalable/trueType/` folder

## Installation on Linux

### System-wide Installation (Recommended)

For reliable application access (requires sudo):

```bash
# Download and extract (replace with your download location)
cd ~/Downloads
unzip uspsFontsNonAFP-1.4.0.zip
cd uspsFontsNonAFP-1.4.0/fonts/scalable/trueType/

# Install to system fonts directory
sudo mkdir -p /usr/share/fonts/truetype/usps
sudo cp *.ttf /usr/share/fonts/truetype/usps/

# Refresh font cache
sudo fc-cache -fv

# Verify installation
fc-list | grep -i usps
```

### User Installation (Alternative)

For user-only access:

```bash
# Create user fonts directory if it doesn't exist
mkdir -p ~/.fonts

# Copy fonts (assumes already downloaded and extracted)
cp *.ttf ~/.fonts/

# Refresh font cache
fc-cache -fv
```

**Note:** Some applications (like Prawn) work more reliably with system-wide
installed fonts.

## Available Fonts

The package includes several fonts. The examples use:

- USPSIMBStandard.ttf (recommended, used in examples)
- USPSIMBCompact.ttf (alternative)
- USPSIMB.ttf (same as Standard)

## Installation on macOS

```bash
# Download and extract the fonts
cd ~/Downloads
unzip uspsFontsNonAFP-1.4.0.zip
cd uspsFontsNonAFP-1.4.0/fonts/scalable/trueType/

# Open Font Book and install, or:
cp *.ttf ~/Library/Fonts/
```

## Installation on Windows

1. Download and extract the ZIP file
2. Navigate to `fonts/scalable/trueType/`
3. Right-click each `.ttf` file and select "Install"
4. Or copy `.ttf` files to `C:\Windows\Fonts\`

## Verify Installation

After installing, verify the font is available:

Linux/macOS:
```bash
fc-list | grep -i "USPSIMB"
```

Expected output:
```
/home/user/.fonts/USPSIMBStandard.ttf: USPSIMBStandard:style=Regular
```

Windows:
Open Font Viewer or check the Fonts control panel for "USPSIMBStandard"

## Test with Examples

Once installed, run the font-based examples:

```bash
ruby examples/barcode_to_svg_font.rb
ruby examples/barcode_to_pdf_font.rb
```

## Additional Resources

- [PostalPro Encoder Software and Fonts](https://postalpro.usps.com/mailing/encoder-software-and-fonts)
- [USPS One Code Solution](https://postalpro.usps.com/onecodesolution)

## Commercial Alternatives

Commercial font packages with additional tools and support:

- [IDAutomation USPS IMb Fonts](http://www.idautomation.com/barcode-fonts/usps-intelligent-mail/)
- Includes encoder tools, macros, and plugins
- Supports multiple formats (TrueType, PostScript, OpenType, PCL)
