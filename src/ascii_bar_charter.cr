# TODO: Write documentation for `AsciiBarCharter`
require "colorize"

class AsciiBarCharter
  class AsciiBarError < Exception end
  VERSION = "1.0.3"

  BAR_CHARS    = ['_', '\u2581', '\u2582', '\u2583', '\u2584', '\u2585', '\u2586', '\u2587', '\u2588', '\u2589', '\u258A']
  # BAR_STEP_QTY = BAR_CHARS.size - 1 # first char is a 'floor', not a 'step'
  BAR_COLORS   = [:blue, :green, :green, :light_green, :light_green, :yellow, :yellow, :light_red, :light_red, :red, :red]

  getter min, max, min_max_delta : Float64, precision
  getter in_bw # if true, don't colorize
  getter inverted
  getter bar_chars
  getter bar_colors # : Array(Symbol | Colorize::ColorRGB)
  getter bar_step_qty : Int32

  def initialize(
    @min : Float64, @max : Float64, @precision : Int8,
    @in_bw = false, @inverted = false,
    @bar_chars = BAR_CHARS, @bar_colors = BAR_COLORS
  )    
    @min_max_delta = 1.0 * (max - min)    
    # @bar_colors = @bar_colors.reverse if !in_bw && @inverted
    @bar_step_qty = @bar_chars.size
    validate!
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
    # i = bar_step_qty - 1 if i >= bar_step_qty
    bar = @bar_chars[i].to_s
    bar = bar.colorize.fore(@bar_colors[inverted ? (@bar_step_qty - i - 1) : i]).back(:light_gray).to_s unless in_bw
    as_bar ? bar : (single_data.round(precision).to_s + bar.to_s)
  end

  def bar_prefixed_with_number(single_data)
    bar(single_data, as_bar = false)
  end
end
