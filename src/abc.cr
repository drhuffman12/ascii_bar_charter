require "option_parser"
require "./ascii_bar_charter"

module Abc
  def self.run
    min = 0.0
    max = 1.0
    precision = 1.0 # 1i8

    bar_chars = AsciiBarCharter::BAR_CHARS
    bar_colors = AsciiBarCharter::BAR_COLORS
    bkgd_color = AsciiBarCharter::BKGD_COLOR

    in_bw = false
    inverted_chars = false
    inverted_colors = false

    prefixed = false

    data = [min,max]

    user_data = Array(Float64).new
    user_data_given = false

    show_examples = false
    examples_with_params = false

    OptionParser.parse do |parser|
      parser.banner = "Ascii Bar Charter CLI\n  Usage: abc [arguments]"

      parser.on("-m MIN", "--min=MIN", "Specifies the data to plot") { |m| min = m.to_f }
      parser.on("-M MAX", "--max=MAX", "Specifies the data to plot") { |m| max = m.to_f }

      parser.on("-e", "--examples", "Will show various examples/permutations") { show_examples = true }
      parser.on("-E", "--examples_with_params", "Will show various examples/permutations with params used") { examples_with_params = true }

      parser.on("-d DATA", "--data=DATA", "Specifies the data to plot") do |d|
        user_data = d.split(",").map{|v| v.to_f}
        user_data_given = true
      end

      parser.on("-p PRECISION", "--precision=PRECISION", "Sets the precision of the values when using option '-v'; must be positive integer for rounding to powers of ten") { |p| precision = p.to_f ; precision = 1.0 if precision < 0.0 } # to_i8 }
      parser.on("-b", "--bw", "Turns off color (i.e.: black and white mode, well, technically gray-scale)") { |b| in_bw = true }
      parser.on("-v", "--values", "Show last values prefixed before the bars") { prefixed = true }

      parser.on("-h", "--help", "Show this help") { puts parser }
    end

    case
    when examples_with_params
      AsciiBarCharter.show_examples_with_params

      # puts 
      # permutations = AsciiBarCharter.permutations
      # permutations.each do |group,examples|
      #   puts group
      #   examples.each do |params,chart|
      #     puts "Using the following params:"
      #     puts params.pretty_inspect
      #     puts "  .. will generate the following: #{chart}"
      #     puts
      #   end  
      # end  
    when show_examples
      AsciiBarCharter.show_examples
      # puts "\npermutations: "
      # permutations = AsciiBarCharter.permutations
      # permutations[:param_combos_without_prefix].each { |_params, string| puts string }
      # permutations[:param_combos_with_prefix].each { |_params, string| puts string }

      # puts "\npermutations(alt): "
      # permutations = AsciiBarCharter.permutations(bar_chars: AsciiBarCharter::BAR_CHARS_ALT, bar_colors: AsciiBarCharter::BAR_COLORS_ALT)
      # permutations[:param_combos_without_prefix].each { |_params, string| puts string }
      # permutations[:param_combos_with_prefix].each { |_params, string| puts string }
    else
      # Use given data else generate example data
      data = case
      when user_data_given
        user_data
      else
        delta = (max - min) / (10**precision)
        step_min = 0
        step_max = (10**precision).round.to_i
        data_steps = (step_min...step_max+1)

        puts "Try 'abc -e' or 'abc -E' for various examples."
        print "Here is one simple example: "
        data_steps.to_a.map { |s| (min + s * delta).round(precision) }
      end

      charter = AsciiBarCharter.new(
        min: min,
        max: max,
        precision: precision.round.to_i8,

        bar_chars: bar_chars,
        bar_colors: bar_colors,
        bkgd_color: bkgd_color,
        
        in_bw: in_bw,
        inverted_chars: inverted_chars,
        inverted_colors: inverted_colors
      )
      puts charter.plot(data, prefixed)
    end
  end
end
Abc.run
