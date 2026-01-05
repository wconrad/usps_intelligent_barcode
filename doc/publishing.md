# Publishing a New Release

## Checklist

* Bump the version in VERSION file:
   ```
   rake version:bump_patch   # For bug fixes (1.1.0 -> 1.1.1)
   rake version:bump_minor   # For new features (1.1.0 -> 1.2.0)
   rake version:bump_major   # For breaking changes (1.1.0 -> 2.0.0)
   ```

* Update CHANGELOG.md with version and date

* Update Gemfile.lock for the new version
  ```
  bundle install
  ```

* Run tests:
   ```
   rake
   ```

* Check code coverage (optional):
   ```
   open coverage/index.html
   ```

* Commit the version bump:
   ```
   git commit -am "Bump version to X.X.X"
   ```

* Release:
   ```
   rake release
   ```

* Verify at https://rubygems.org/gems/usps_intelligent_barcode

## Notes

Semantic Versioning: MAJOR.MINOR.PATCH (breaking.feature.bugfix)

What `rake release` does:
- Builds the gem
- Creates git tag vX.X.X
- Pushes tag to GitHub
- Publishes gem to rubygems.org

Dry run: `gem_push=no rake release` (tags but doesn't publish)

Test locally before releasing:
```
rake install
gem list usps_intelligent_barcode
```

## Troubleshooting

No RubyGems credentials: `gem signin`

Release failed mid-way:
```
git tag -d vX.X.X              # Delete local tag
git push origin :vX.X.X        # Delete remote tag
# Fix VERSION file if needed
rake release                   # Try again
```

Manual publish (if rake release fails):
```
gem build usps_intelligent_barcode.gemspec
gem push usps_intelligent_barcode-X.X.X.gem
```
