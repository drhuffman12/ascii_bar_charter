# TODO: Write documentation for `AsciiBarCharter`
require "colorize"

class AsciiBarCharter
  VERSION = "1.0.2"

  BAR_CHARS    = ['_', '\u2581', '\u2582', '\u2583', '\u2584', '\u2585', '\u2586', '\u2587', '\u2588', '\u2589', '\u258A']
  BAR_STEP_QTY = BAR_CHARS.size - 1 # first char is a 'floor', not a 'step'
  BAR_COLORS   = [:blue, :green, :green, :light_green, :light_green, :yellow, :yellow, :light_red, :light_red, :red, :red]

  getter min, max, min_max_delta : Float64, precision, in_bw, inverted

  def initialize(@min : Float64, @max : Float64, @precision : Int8, @in_bw = false, @inverted = false)
    @min_max_delta = 1.0 * (max - min)
    @bar_colors = !in_bw && @inverted ? BAR_COLORS.reverse : BAR_COLORS
  end

  def plot(data, prefixed = false)
    data.map do |single_data|
      prefixed ? bar_prefixed_with_number(single_data) : bar(single_data)
    end.join
  end

  def bar(single_data, as_bar = true)
    i = (BAR_STEP_QTY * (single_data - min) / min_max_delta).round.to_i
    i = 0 if i < 0
    i = BAR_STEP_QTY if i > BAR_STEP_QTY
    bar = BAR_CHARS[i].to_s
    bar = bar.colorize.fore(@bar_colors[i]).back(:light_gray).to_s unless in_bw
    as_bar ? bar : (single_data.round(precision).to_s + bar.to_s)
  end

  def bar_prefixed_with_number(single_data)
    bar(single_data, as_bar = false)
  end
end
