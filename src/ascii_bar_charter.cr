# TODO: Write documentation for `AsciiBarCharter`
require "colorize"

class AsciiBarCharter
  class AsciiBarError < Exception
  end

  VERSION = "2.0.0pre"

  BAR_CHARS = [
    '\u25BF',
    '_', '\u2581', '\u2582',
    '\u2583', '\u2584', '\u2585',
    '\u2586', '\u2587', '\u2588',
    '\u25B4',
  ]
  BAR_CHARS_ALT = [
    '\u25A0',
    '\u25A1', '\u25AB', '\u263E',
    '\u25F5', '\u25C9', '\u25F7',
    '\u263D', '\u25B9', '\u25B7',
    '\u25B6',
  ]

  BAR_COLORS = [
    :blue,
    :light_blue, :cyan, :light_cyan,
    :green, :light_green, :yellow,
    :light_magenta, :magenta, :light_red,
    :red,
  ]
  BAR_COLORS_ALT = [
    :magenta,
    :red, :light_red, :light_yellow,
    :yellow, :black, :cyan,
    :light_cyan, :light_green, :green,
    :blue,
  ]
  
  BKGD_COLOR = :white

  getter min, max, min_max_delta : Float64, precision
  getter in_bw             # if true, don't colorize
  property inverted_colors # flips bar_chars
  property inverted_bars   # flips bar_colors
  getter bar_chars

  # TODO: allow usage of colors like `Colorize::ColorRGB.new(0, 255, 255)`
  # i.e.: `getter bar_colors : Array(Symbol | Colorize::ColorRGB)`
  getter bar_colors

  getter bar_step_qty : Int32
  property bkgd_color : Symbol

  def initialize(
    @min : Float64, @max : Float64, @precision : Int8,
    @in_bw = false, @inverted_bars = false, @inverted_colors = false,
    @bar_chars = BAR_CHARS, @bar_colors = BAR_COLORS, @bkgd_color = BGKD_COLOR
  )
    @min_max_delta = 1.0 * (max - min)
    @bar_step_qty = @bar_chars.size
    validate!
  end

  def plot(data, prefixed = false)
    data.map do |single_data|
      prefixed ? bar_prefixed_with_number(single_data) : bar(single_data)
    end.join
  end

  def bar(single_data, as_bar = true)
    f = (1.0 * (single_data - min) / min_max_delta)
    f = 0.0 if f < 0.0
    f = 1.0 if f > 1.0
    i = (f * (bar_step_qty - 1)).round.to_i
    adjusted_char_index = inverted_bars ? (@bar_step_qty - i - 1) : i
    adjusted_color_index = inverted_colors ? (@bar_step_qty - i - 1) : i
    bar = @bar_chars[adjusted_char_index].to_s
    bar = bar.colorize.fore(@bar_colors[adjusted_color_index]).back(@bkgd_color).to_s unless in_bw
    as_bar ? bar : (single_data.round(precision).to_s + bar.to_s)
  end

  def bar_prefixed_with_number(single_data)
    bar(single_data, as_bar = false)
  end

  def validate!
    raise AsciiBarError.new("Mismatch in sizes of bar_chars and bar_colors") if !in_bw && (bar_chars.size != bar_colors.size)
  end

  def toggle_bw
    @in_bw = !in_bw
    validate!
  end

  def reset_bars(new_bar_chars = BAR_CHARS, new_bar_colors = BAR_COLORS)
    @bar_chars = new_bar_chars
    @bar_colors = new_bar_colors
    validate!
  end

  def reset_bar_chars(new_bar_chars = BAR_CHARS)
    @bar_chars = new_bar_chars
    validate!
  end

  def reset_bar_colors(new_bar_colors = BAR_COLORS)
    @bar_colors = new_bar_colors
    validate!
  end
end
