# Migration Guide

## Gem Rename: USPS-intelligent-barcode → usps_intelligent_barcode

### Background

In June 2015 (version 0.3.0), this gem was renamed from `USPS-intelligent-barcode` to `usps_intelligent_barcode` to follow Ruby gem naming conventions.

### What Changed

**Old name (deprecated):**
```ruby
gem 'USPS-intelligent-barcode'
```

**New name (current):**
```ruby
gem 'usps_intelligent_barcode'
```

### Migration Steps

1. Update your `Gemfile`:
   ```ruby
   # Replace this:
   gem 'USPS-intelligent-barcode'

   # With this:
   gem 'usps_intelligent_barcode'
   ```

2. Run `bundle update`

3. No code changes required - the API remains identical

### Compatibility Period

For backward compatibility, both gem names were published simultaneously:

- `USPS-intelligent-barcode` (v0.2.7) - Deprecated, with post-install warning
- `usps_intelligent_barcode` (v0.3.0+) - Current version

The deprecated `USPS-intelligent-barcode` gem was maintained through 2015-2016 to allow users time to migrate.

### Current Status

As of 2025, only `usps_intelligent_barcode` is actively maintained. The old `USPS-intelligent-barcode` gem name should not be used for new projects.
