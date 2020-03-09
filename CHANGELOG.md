# Changelog

## v1.1.0

* Changed constructor params:
  * NOTE: Includes BREAKING CHANGES!
  * `inverted` is now `inverted_colors` and is now a property, so you can flip it without having to create a separate AsciiBarCharter instance
  * `inverted_chars` was added; like `inverted_colors`, but flips given chars
  * You can now specify custom `bar_chars` and/or `bar_colors`, which will default to BAR_CHARS and BAR_COLORS.
  * BAR_CHARS and BAR_COLORS changed
  * BAR_CHARS_ALT and BAR_COLORS_ALT added
  * If the sizes of the `bar_chars` and `bar_colors` don't match, you'll get an AsciiBarError (unless you're in bw mode)

* Added `#permutations` method to easy previewing combinations of given params

## v1.0.3

* Color-range hard-coded to blue, green, light_green, yellow, light_red, and red (some twice)
* CI enabled for Travis
* CI disabled for CircleCI (till I figure out how to enable color terminals)
