require "./spec_helper"

describe AsciiBarCharter do
  describe "#initialize" do
    # TODO
  end

  describe "#plot" do
    # TODO
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

  describe "#permutations" do
    bar_chars = AsciiBarCharter::BAR_CHARS
    # TODO: test for usage of colors like `Colorize::ColorRGB.new(0, 255, 255)`
    bar_colors = AsciiBarCharter::BAR_COLORS

    min = -1.0
    max = 1.0
    dist = max - min
    precision = 3.to_i8
    step_max = bar_chars.size - 1
    data = (0..step_max).to_a.map { |i| (dist * i / step_max + min).round(precision) }

    params_main = {
      min:       min,
      max:       max,
      precision: precision,

      bar_chars:  bar_chars,
      bar_colors: bar_colors,
      bkgd_color: AsciiBarCharter::BKGD_COLOR,

      in_bw:           false,
      inverted_chars:  false,
      inverted_colors: false,
    }

    context "with all defaults" do
      expected_permutations = {
        param_combos_without_prefix: {
          params_main.merge({in_bw: true}) => "▿_▁▂▃▄▅▆▇█▴",
          params_main.merge({in_bw: true, inverted_chars: true}) => "▴█▇▆▅▄▃▂▁_▿",
          # Below are dups of above since in_bw is true
          # params_main.merge({in_bw: true, inverted_colors: true}) => "",
          # params_main.merge({in_bw: true, inverted_chars: true, inverted_colors: true}) => ""
          params_main => "\e[34;107m▿\e[0m\e[94;107m_\e[0m\e[36;107m▁\e[0m\e[96;107m▂\e[0m\e[32;107m▃\e[0m\e[92;107m▄\e[0m\e[33;107m▅\e[0m\e[95;107m▆\e[0m\e[35;107m▇\e[0m\e[91;107m█\e[0m\e[31;107m▴\e[0m",
          params_main.merge({inverted_chars: true}) => "\e[34;107m▴\e[0m\e[94;107m█\e[0m\e[36;107m▇\e[0m\e[96;107m▆\e[0m\e[32;107m▅\e[0m\e[92;107m▄\e[0m\e[33;107m▃\e[0m\e[95;107m▂\e[0m\e[35;107m▁\e[0m\e[91;107m_\e[0m\e[31;107m▿\e[0m",
          params_main.merge({inverted_colors: true}) => "\e[31;107m▿\e[0m\e[91;107m_\e[0m\e[35;107m▁\e[0m\e[95;107m▂\e[0m\e[33;107m▃\e[0m\e[92;107m▄\e[0m\e[32;107m▅\e[0m\e[96;107m▆\e[0m\e[36;107m▇\e[0m\e[94;107m█\e[0m\e[34;107m▴\e[0m",
          params_main.merge({inverted_chars: true, inverted_colors: true}) => "\e[31;107m▴\e[0m\e[91;107m█\e[0m\e[35;107m▇\e[0m\e[95;107m▆\e[0m\e[33;107m▅\e[0m\e[92;107m▄\e[0m\e[32;107m▃\e[0m\e[96;107m▂\e[0m\e[36;107m▁\e[0m\e[94;107m_\e[0m\e[34;107m▿\e[0m",
        },
        param_combos_with_prefix: {
          params_main.merge({in_bw: true}) => "-1.0▿-0.8_-0.6▁-0.4▂-0.2▃0.0▄0.2▅0.4▆0.6▇0.8█1.0▴",
          params_main.merge({in_bw: true, inverted_chars: true}) => "-1.0▴-0.8█-0.6▇-0.4▆-0.2▅0.0▄0.2▃0.4▂0.6▁0.8_1.0▿",
          # Below are dups of above since in_bw is true
          # params_main.merge({in_bw: true, inverted_colors: true}) => "",
          # params_main.merge({in_bw: true, inverted_chars: true, inverted_colors: true}) => ""
          params_main => "-1.0\e[34;107m▿\e[0m-0.8\e[94;107m_\e[0m-0.6\e[36;107m▁\e[0m-0.4\e[96;107m▂\e[0m-0.2\e[32;107m▃\e[0m0.0\e[92;107m▄\e[0m0.2\e[33;107m▅\e[0m0.4\e[95;107m▆\e[0m0.6\e[35;107m▇\e[0m0.8\e[91;107m█\e[0m1.0\e[31;107m▴\e[0m",
          params_main.merge({inverted_chars: true}) => "-1.0\e[34;107m▴\e[0m-0.8\e[94;107m█\e[0m-0.6\e[36;107m▇\e[0m-0.4\e[96;107m▆\e[0m-0.2\e[32;107m▅\e[0m0.0\e[92;107m▄\e[0m0.2\e[33;107m▃\e[0m0.4\e[95;107m▂\e[0m0.6\e[35;107m▁\e[0m0.8\e[91;107m_\e[0m1.0\e[31;107m▿\e[0m",
          params_main.merge({inverted_colors: true}) => "-1.0\e[31;107m▿\e[0m-0.8\e[91;107m_\e[0m-0.6\e[35;107m▁\e[0m-0.4\e[95;107m▂\e[0m-0.2\e[33;107m▃\e[0m0.0\e[92;107m▄\e[0m0.2\e[32;107m▅\e[0m0.4\e[96;107m▆\e[0m0.6\e[36;107m▇\e[0m0.8\e[94;107m█\e[0m1.0\e[34;107m▴\e[0m",
          params_main.merge({inverted_chars: true, inverted_colors: true}) => "-1.0\e[31;107m▴\e[0m-0.8\e[91;107m█\e[0m-0.6\e[35;107m▇\e[0m-0.4\e[95;107m▆\e[0m-0.2\e[33;107m▅\e[0m0.0\e[92;107m▄\e[0m0.2\e[32;107m▃\e[0m0.4\e[96;107m▂\e[0m0.6\e[36;107m▁\e[0m0.8\e[94;107m_\e[0m1.0\e[34;107m▿\e[0m",
        },
      }

      permutations = AsciiBarCharter.permutations

      context "without numeric prefix" do
        permutation_subset = permutations[:param_combos_without_prefix]
        expected_permutations[:param_combos_without_prefix].each do |params, expected_string|
          it "given params of #{params}, it returns expected permutations" do
            permutation_subset[params].should eq(expected_string)

            # permutations[:param_combos_without_prefix].each { |_params, string| puts string }
            # permutations[:param_combos_with_prefix].each { |_params, string| puts string }
          end
        end
      end

      context "with numeric prefix" do
        permutation_subset = permutations[:param_combos_with_prefix]
        expected_permutations[:param_combos_with_prefix].each do |params, expected_string|
          it "given params of #{params}, it returns expected permutations" do
            permutation_subset[params].should eq(expected_string)

            # permutations[:param_combos_without_prefix].each { |_params, string| puts string }
            # permutations[:param_combos_with_prefix].each { |_params, string| puts string }
          end
        end
      end
    end

    context "with alternative bar chars and colors" do
      bar_chars = AsciiBarCharter::BAR_CHARS_ALT
      bar_colors = AsciiBarCharter::BAR_COLORS_ALT
      params_main_alt = params_main.merge({
        bar_chars:  bar_chars,
        bar_colors: bar_colors,
      })
      expected_permutations = {
        param_combos_without_prefix: {
          params_main_alt.merge({in_bw: true}) => "■□▫☾◵◉◷☽▹▷▶",
          params_main_alt.merge({in_bw: true, inverted_chars: true}) => "▶▷▹☽◷◉◵☾▫□■",
          # Below are dups of above since in_bw is true
          # params_main_alt.merge({in_bw: true, inverted_colors: true}) => "",
          # params_main_alt.merge({in_bw: true, inverted_chars: true, inverted_colors: true}) => ""
          params_main_alt => "\e[35;107m■\e[0m\e[31;107m□\e[0m\e[91;107m▫\e[0m\e[93;107m☾\e[0m\e[33;107m◵\e[0m\e[30;107m◉\e[0m\e[36;107m◷\e[0m\e[96;107m☽\e[0m\e[92;107m▹\e[0m\e[32;107m▷\e[0m\e[34;107m▶\e[0m",
          params_main_alt.merge({inverted_chars: true}) => "\e[35;107m▶\e[0m\e[31;107m▷\e[0m\e[91;107m▹\e[0m\e[93;107m☽\e[0m\e[33;107m◷\e[0m\e[30;107m◉\e[0m\e[36;107m◵\e[0m\e[96;107m☾\e[0m\e[92;107m▫\e[0m\e[32;107m□\e[0m\e[34;107m■\e[0m",
          params_main_alt.merge({inverted_colors: true}) => "\e[34;107m■\e[0m\e[32;107m□\e[0m\e[92;107m▫\e[0m\e[96;107m☾\e[0m\e[36;107m◵\e[0m\e[30;107m◉\e[0m\e[33;107m◷\e[0m\e[93;107m☽\e[0m\e[91;107m▹\e[0m\e[31;107m▷\e[0m\e[35;107m▶\e[0m",
          params_main_alt.merge({inverted_chars: true, inverted_colors: true}) => "\e[34;107m▶\e[0m\e[32;107m▷\e[0m\e[92;107m▹\e[0m\e[96;107m☽\e[0m\e[36;107m◷\e[0m\e[30;107m◉\e[0m\e[33;107m◵\e[0m\e[93;107m☾\e[0m\e[91;107m▫\e[0m\e[31;107m□\e[0m\e[35;107m■\e[0m",
        },
        param_combos_with_prefix: {
          params_main_alt.merge({in_bw: true}) => "-1.0■-0.8□-0.6▫-0.4☾-0.2◵0.0◉0.2◷0.4☽0.6▹0.8▷1.0▶",
          params_main_alt.merge({in_bw: true, inverted_chars: true}) => "-1.0▶-0.8▷-0.6▹-0.4☽-0.2◷0.0◉0.2◵0.4☾0.6▫0.8□1.0■",
          # Below are dups of above since in_bw is true
          # params_main_alt.merge({in_bw: true, inverted_colors: true}) => "",
          # params_main_alt.merge({in_bw: true, inverted_chars: true, inverted_colors: true}) => ""
          params_main_alt => "-1.0\e[35;107m■\e[0m-0.8\e[31;107m□\e[0m-0.6\e[91;107m▫\e[0m-0.4\e[93;107m☾\e[0m-0.2\e[33;107m◵\e[0m0.0\e[30;107m◉\e[0m0.2\e[36;107m◷\e[0m0.4\e[96;107m☽\e[0m0.6\e[92;107m▹\e[0m0.8\e[32;107m▷\e[0m1.0\e[34;107m▶\e[0m",
          params_main_alt.merge({inverted_chars: true}) => "-1.0\e[35;107m▶\e[0m-0.8\e[31;107m▷\e[0m-0.6\e[91;107m▹\e[0m-0.4\e[93;107m☽\e[0m-0.2\e[33;107m◷\e[0m0.0\e[30;107m◉\e[0m0.2\e[36;107m◵\e[0m0.4\e[96;107m☾\e[0m0.6\e[92;107m▫\e[0m0.8\e[32;107m□\e[0m1.0\e[34;107m■\e[0m",
          params_main_alt.merge({inverted_colors: true}) => "-1.0\e[34;107m■\e[0m-0.8\e[32;107m□\e[0m-0.6\e[92;107m▫\e[0m-0.4\e[96;107m☾\e[0m-0.2\e[36;107m◵\e[0m0.0\e[30;107m◉\e[0m0.2\e[33;107m◷\e[0m0.4\e[93;107m☽\e[0m0.6\e[91;107m▹\e[0m0.8\e[31;107m▷\e[0m1.0\e[35;107m▶\e[0m",
          params_main_alt.merge({inverted_chars: true, inverted_colors: true}) => "-1.0\e[34;107m▶\e[0m-0.8\e[32;107m▷\e[0m-0.6\e[92;107m▹\e[0m-0.4\e[96;107m☽\e[0m-0.2\e[36;107m◷\e[0m0.0\e[30;107m◉\e[0m0.2\e[33;107m◵\e[0m0.4\e[93;107m☾\e[0m0.6\e[91;107m▫\e[0m0.8\e[31;107m□\e[0m1.0\e[35;107m■\e[0m",
        },
      }

      permutations = AsciiBarCharter.permutations(bar_chars: bar_chars, bar_colors: bar_colors)

      context "without numeric prefix" do
        permutation_subset = permutations[:param_combos_without_prefix]
        expected_permutations[:param_combos_without_prefix].each do |params, expected_string|
          it "given params of #{params}, it returns expected permutations" do
            permutation_subset[params].should eq(expected_string)

            # permutations[:param_combos_without_prefix].each { |_params, string| puts string }
            # permutations[:param_combos_with_prefix].each { |_params, string| puts string }
          end
        end
      end

      context "with numeric prefix" do
        permutation_subset = permutations[:param_combos_with_prefix]
        expected_permutations[:param_combos_with_prefix].each do |params, expected_string|
          it "given params of #{params}, it returns expected permutations" do
            permutation_subset[params].should eq(expected_string)

            # permutations[:param_combos_without_prefix].each { |_params, string| puts string }
            # permutations[:param_combos_with_prefix].each { |_params, string| puts string }
          end
        end
      end
    end
  end
end

puts "\npermutations: "
permutations = AsciiBarCharter.permutations
permutations[:param_combos_without_prefix].each { |_params, string| puts string }
permutations[:param_combos_with_prefix].each { |_params, string| puts string }

puts "\npermutations(alt): "
permutations = AsciiBarCharter.permutations(bar_chars: AsciiBarCharter::BAR_CHARS_ALT, bar_colors: AsciiBarCharter::BAR_COLORS_ALT)
permutations[:param_combos_without_prefix].each { |_params, string| puts string }
permutations[:param_combos_with_prefix].each { |_params, string| puts string }
