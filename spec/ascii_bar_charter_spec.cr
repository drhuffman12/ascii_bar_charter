require "./spec_helper"

describe AsciiBarCharter do
  describe "#initialize" do
    # TODO
  end

  describe "#plot" do
    bar_chars_custom = AsciiBarCharter::BAR_CHARS_ALT
    # TODO: test for usage of colors like `Colorize::ColorRGB.new(0, 255, 255)`
    bar_colors_custom = AsciiBarCharter::BAR_COLORS_ALT

    min = -1.0
    max = 1.0
    dist = max - min
    precision = 3.to_i8
    step_max = bar_chars_custom.size - 1
    data = (0..step_max).to_a.map { |i| (dist * i / step_max + min).round(precision) }

    params_main = {
      min:       min,
      max:       max,
      precision: precision,

      in_bw:           false,
      inverted_bars:   false,
      inverted_colors: false,

      bar_chars:  AsciiBarCharter::BAR_CHARS,
      bar_colors: AsciiBarCharter::BAR_COLORS,
      bkgd_color: AsciiBarCharter::BKGD_COLOR,
    }

    expected_graph_chars_per_params_without_prefix = {
      params_main.merge({in_bw: true}) => "▿_▁▂▃▄▄▅▆▇█▴",
      params_main.merge({in_bw: true, inverted_bars: true}) => "1",
      params_main => "2",
      params_main.merge({inverted_colors: true, inverted_bars: true}) => "3b",
      params_main.merge({inverted_colors: true}) => "3",
      params_main.merge({inverted_bars: true}) => "4",
      params_main.merge({bar_colors: bar_colors_custom}) => "5",
      params_main.merge({bar_colors: bar_colors_custom, inverted_bars: true, inverted_colors: true}) => "8",
      params_main.merge({bar_colors: bar_colors_custom, inverted_colors: true}) => "7",
      params_main.merge({bar_colors: bar_colors_custom, inverted_bars: true}) => "6",
      params_main.merge({bar_chars: bar_chars_custom, bar_colors: bar_colors_custom, in_bw: true}) => "■□▫☾◵◉◉◷☽▹▷▶",
      params_main.merge({bar_chars: bar_chars_custom, bar_colors: bar_colors_custom, in_bw: true, inverted_bars: true}) => "■□▫☾◵◉◉◷☽▹▷▶",
      params_main.merge({bar_chars: bar_chars_custom}) => "9",
      params_main.merge({bar_chars: bar_chars_custom, bar_colors: bar_colors_custom}) => "10",
      params_main.merge({bar_chars: bar_chars_custom, bar_colors: bar_colors_custom, inverted_bars: true}) => "11",
      params_main.merge({bar_chars: bar_chars_custom, bar_colors: bar_colors_custom, inverted_colors: true}) => "12",
      params_main.merge({bar_chars: bar_chars_custom, bar_colors: bar_colors_custom, inverted_bars: true, inverted_colors: true}) => "13",
    }
    expected_graph_chars_per_params_with_prefix = {
      params_main.merge({in_bw: true}) => "-1.0▿-0.818_-0.636▁-0.455▂-0.273▃-0.091▄0.091▄0.273▅0.455▆0.636▇0.818█1.0▴",
      params_main.merge({in_bw: true, inverted_bars: true}) => "1",
      params_main => "2",
      params_main.merge({inverted_colors: true, inverted_bars: true}) => "3b",
      params_main.merge({inverted_colors: true}) => "3",
      params_main.merge({inverted_bars: true}) => "4",
      params_main.merge({bar_colors: bar_colors_custom}) => "5",
      params_main.merge({bar_colors: bar_colors_custom, inverted_bars: true, inverted_colors: true}) => "8",
      params_main.merge({bar_colors: bar_colors_custom, inverted_colors: true}) => "7",
      params_main.merge({bar_colors: bar_colors_custom, inverted_bars: true}) => "6",
      params_main.merge({bar_chars: bar_chars_custom, bar_colors: bar_colors_custom, in_bw: true}) => "xxx",
      params_main.merge({bar_chars: bar_chars_custom, bar_colors: bar_colors_custom, in_bw: true, inverted_bars: true}) => "xxx",
      params_main.merge({bar_chars: bar_chars_custom}) => "9",
      params_main.merge({bar_chars: bar_chars_custom, bar_colors: bar_colors_custom}) => "10",
      params_main.merge({bar_chars: bar_chars_custom, bar_colors: bar_colors_custom, inverted_bars: true}) => "11",
      params_main.merge({bar_chars: bar_chars_custom, bar_colors: bar_colors_custom, inverted_colors: true}) => "12",
      params_main.merge({bar_chars: bar_chars_custom, bar_colors: bar_colors_custom, inverted_bars: true, inverted_colors: true}) => "13",
    }

    context "when prefixed turned off" do
      prefixed = false
      expected_graph_chars_per_params_without_prefix.each do |params, expected_graph_chars|
        it "when initialized with params #{params}, it should generate expected (un)colorized bars: #{expected_graph_chars}" do
          charter = AsciiBarCharter.new(**params)
          plot = charter.plot(data, prefixed)
          puts plot + "\n"
          plot.should eq(expected_graph_chars)
        end
      end
    end

    context "when prefixed turned on" do
      prefixed = true
      expected_graph_chars_per_params_with_prefix.each do |params, expected_graph_chars|
        it "when initialized with params #{params}, it should generate expected (un)colorized bars: #{expected_graph_chars}" do
          charter = AsciiBarCharter.new(**params)
          plot = charter.plot(data, prefixed)
          puts plot + "\n"
          plot.should eq(expected_graph_chars)
        end
      end
    end
  end

  describe "#bar" do
    # TODO
  end

  describe "#bar_prefixed_with_number" do
    # TODO
  end

  describe "#validate!" do
    # TODO
  end

  describe "#toggle_bw" do
    # TODO
  end

  describe "#reset_bars" do
    # TODO
  end

  describe "#reset_bar_chars" do
    # TODO
  end

  describe "#reset_bar_colors" do
    # TODO
  end
end
