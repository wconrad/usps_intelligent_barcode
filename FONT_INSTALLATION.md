# Installing USPS Intelligent Mail Barcode Fonts

The font-based barcode examples require a USPS Intelligent Mail Barcode font
to be installed on your system.

## Download the Font

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
sudo fc-cache -fv
fc-list | grep -i usps
```

## Available Fonts

The package includes several fonts:

- USPSIMBStandard.ttf (recommended, used in examples)
- USPSIMBCompact.ttf (alternative)
- USPSIMB.ttf (same as Standard)
