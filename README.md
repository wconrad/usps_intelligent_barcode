[![Gem Version](https://badge.fury.io/rb/usps_intelligent_barcode.png)](http://badge.fury.io/rb/usps_intelligent_barcode)
[![Dependency Status](https://gemnasium.com/wconrad/usps_intelligent_barcode.svg)](https://gemnasium.com/wconrad/usps_intelligent_barcode)
[![Build Status](https://travis-ci.org/wconrad/usps_intelligent_barcode.png)](https://travis-ci.org/wconrad/usps_intelligent_barcode)
[![Code Climate](https://codeclimate.com/github/wconrad/usps_intelligent_barcode.png)](https://codeclimate.com/github/wconrad/usps_intelligent_barcode)

usps_intelligent_barcode is a pure ruby gem to generate a USPS IMB
(Intelligent Mail Barcode).  More specifically, it generates the
string of characters you should print using one of the [USPS
Intelligent Barcode
fonts](https://ribbs.usps.gov/onecodesolution/download.cfm).

# Origin

This project was forked from Ryan Taylor's
https://github.com/rtlong/USPS-intelligent-barcode Long, in order to
add tests and refactor.  It is _not_ a drop-in replacement: I renamed
most methods and classes, and eliminated the #draw method.

# Install

    gem install usps_intelligent_barcode

Note: This gem was previously named `USPS-intelligent-barcode`. If
you're migrating from the old gem name, see
[MIGRATION.md](MIGRATION.md).

# Example

```ruby
#!/usr/bin/env ruby
lib_dir = File.expand_path('../lib', __dir__)
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)
require 'usps_intelligent_barcode'

barcode_id = '01'
service_type = '234'
mailer_id = '567094'
serial_number = '987654321'
routing_code = '01234567891'
barcode = Imb::Barcode.new(barcode_id,
                           service_type,
                           mailer_id,
                           serial_number,
                           routing_code)
p barcode.barcode_letters
# => "AADTFFDFTDADTAADAATFDTDDAAADDTDTTDAFADADDDTFFFDDTTTADFAAADFTDAADA"
```

# Generating Barcode PDFs

The gem includes bundled USPS Intelligent Mail Barcode fonts. To generate a
PDF with a barcode:

```ruby
gem install prawn
ruby examples/generate_pdf.rb
```

This creates `/tmp/barcode_to_pdf.pdf` with the barcode and its component
fields. The USPS fonts (USPSIMBStandard and USPSIMBCompact) are included
in the `fonts/` directory - no installation required.

# Standard

This gem is based upon standard
[USPS-B-3200H](https://ribbs.usps.gov/intelligentmail_mailpieces/documents/tech_guides/USPSB3200IntelligentMailBarcode4State.pdf),
which is linked to from [Intelligent Mail Barcode for
Mailpieces](https://ribbs.usps.gov/index.cfm?page=intellmailmailpieces)

# Supported Ruby Versions

This gem is tested and supported on:

* ruby-3.2
* ruby-3.3
* ruby-3.4
* ruby-4.0

# whoami

Wayne Conrad <kf7qga@gmail.com>

# Gem versioning

This library uses [Semantic Versioning](http://semver.org/).  It
promises not to make breaking changes to its API without bumping the
major version.

# Credits

Thanks to Ryan Taylor Long for his original work, without which I
would have been lost in the USPS specification.
