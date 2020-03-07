require "./spec_helper"

describe AsciiBarCharter do
  describe "#plot" do
    describe "given a range of 0.0 to 1.0 with precision of 2 and" do
      describe "color enabled" do
        describe "prefix enabled" do
          describe "and reverse disabled" do
            it "will return color-escaped bars from with prefix numbers ranging from 0.0 to 1.0 in green to red colors" do
              min = 0.0
              max = 1.0
              precision = 2.to_i8
              in_bw = false
              data = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
              prefixed = true
              reversed = false
              expected_graph_chars = "0.0\e[34;47m_\e[0m" +
                                     "0.1\e[32;47m▁\e[0m" +
                                     "0.2\e[32;47m▂\e[0m" +
                                     "0.3\e[92;47m▃\e[0m" +
                                     "0.4\e[92;47m▄\e[0m" +
                                     "0.5\e[33;47m▅\e[0m" +
                                     "0.6\e[33;47m▆\e[0m" +
                                     "0.7\e[91;47m▇\e[0m" +
                                     "0.8\e[91;47m█\e[0m" +
                                     "0.9\e[31;47m▉\e[0m"

              charter = AsciiBarCharter.new(min, max, precision, in_bw, reversed)
              plot = charter.plot(data, prefixed)

              puts plot + "\n"

              plot.should eq(expected_graph_chars)
            end

            context "with range of 0 to 8 and precision of 3" do
              it "will return color-escaped bars from with prefix numbers ranging from 0.0 to 8.0 in green to red colors and max precision of 3" do
                min = 0.0
                max = 1.0
                precision = 3.to_i8
                in_bw = false
                data = (0..8).to_a.map { |i| (i / 8.0).round(precision) }
                prefixed = true
                reversed = false
                expected_graph_chars = "0.0\e[34;47m_\e[0m" +
                                       "0.125\e[32;47m▁\e[0m" +
                                       "0.25\e[92;47m▃\e[0m" +
                                       "0.375\e[92;47m▄\e[0m" +
                                       "0.5\e[33;47m▅\e[0m" +
                                       "0.625\e[33;47m▆\e[0m" +
                                       "0.75\e[91;47m█\e[0m" +
                                       "0.875\e[31;47m▉\e[0m" +
                                       "1.0\e[31;47m▊\e[0m"

                charter = AsciiBarCharter.new(min, max, precision, in_bw, reversed)
                plot = charter.plot(data, prefixed)

                puts plot + "\n"

                plot.should eq(expected_graph_chars)
              end
            end
          end

          describe "and reverse enabled" do
            it "it will return color-escaped bars from with prefix numbers ranging from 0.0 to 1.0 in green to red colors" do
              min = 0.0
              max = 1.0
              precision = 2.to_i8
              in_bw = false
              data = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
              prefixed = true
              reversed = true
              expected_graph_chars = "0.0\e[31;47m_\e[0m" +
                                     "0.1\e[31;47m▁\e[0m" +
                                     "0.2\e[91;47m▂\e[0m" +
                                     "0.3\e[91;47m▃\e[0m" +
                                     "0.4\e[33;47m▄\e[0m" +
                                     "0.5\e[33;47m▅\e[0m" +
                                     "0.6\e[92;47m▆\e[0m" +
                                     "0.7\e[92;47m▇\e[0m" +
                                     "0.8\e[32;47m█\e[0m" +
                                     "0.9\e[32;47m▉\e[0m"

              charter = AsciiBarCharter.new(min, max, precision, in_bw, reversed)
              plot = charter.plot(data, prefixed)

              puts plot + "\n"

              plot.should eq(expected_graph_chars)
            end
          end
        end

        describe "prefix disabled" do
          describe "and reverse disabled" do
            it "will return color-escaped bars from without prefix numbers in green to red colors" do
              min = 0.0
              max = 1.0
              precision = 2.to_i8
              in_bw = false
              data = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
              prefixed = false
              reversed = false
              expected_graph_chars = "\e[34;47m_\e[0m" +
                                     "\e[32;47m▁\e[0m" +
                                     "\e[32;47m▂\e[0m" +
                                     "\e[92;47m▃\e[0m" +
                                     "\e[92;47m▄\e[0m" +
                                     "\e[33;47m▅\e[0m" +
                                     "\e[33;47m▆\e[0m" +
                                     "\e[91;47m▇\e[0m" +
                                     "\e[91;47m█\e[0m" +
                                     "\e[31;47m▉\e[0m"

              charter = AsciiBarCharter.new(min, max, precision, in_bw, reversed)
              plot = charter.plot(data, prefixed)

              puts plot + "\n"

              plot.should eq(expected_graph_chars)
            end
          end

          describe "and reverse enabled" do
            it "will return color-escaped bars from without prefix numbers in green to red colors" do
              min = 0.0
              max = 1.0
              precision = 2.to_i8
              in_bw = false
              data = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
              prefixed = false
              reversed = true
              expected_graph_chars = "\e[31;47m_\e[0m" +
                                     "\e[31;47m▁\e[0m" +
                                     "\e[91;47m▂\e[0m" +
                                     "\e[91;47m▃\e[0m" +
                                     "\e[33;47m▄\e[0m" +
                                     "\e[33;47m▅\e[0m" +
                                     "\e[92;47m▆\e[0m" +
                                     "\e[92;47m▇\e[0m" +
                                     "\e[32;47m█\e[0m" +
                                     "\e[32;47m▉\e[0m"

              charter = AsciiBarCharter.new(min, max, precision, in_bw, reversed)
              plot = charter.plot(data, prefixed)

              puts plot + "\n"

              plot.should eq(expected_graph_chars)
            end
          end
        end
      end

      describe "color disabled" do
        describe "prefix enabled" do
          describe "and reverse disabled" do
            it "will return color-escaped bars from with prefix numbers ranging from 0.0 to 1.0 in green to red colors" do
              min = 0.0
              max = 1.0
              precision = 2.to_i8
              in_bw = true
              data = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
              prefixed = true
              reversed = false
              expected_graph_chars = "0.0_0.1▁0.2▂0.3▃0.4▄0.5▅0.6▆0.7▇0.8█0.9▉"

              charter = AsciiBarCharter.new(min, max, precision, in_bw, reversed)
              plot = charter.plot(data, prefixed)

              puts plot + "\n"

              plot.should eq(expected_graph_chars)
            end
          end

          describe "and reverse enabled" do
            it "it will return color-escaped bars from with prefix numbers ranging from 0.0 to 1.0 in green to red colors" do
              min = 0.0
              max = 1.0
              precision = 2.to_i8
              in_bw = true
              data = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
              prefixed = true
              reversed = true
              expected_graph_chars = "0.0_0.1▁0.2▂0.3▃0.4▄0.5▅0.6▆0.7▇0.8█0.9▉"

              charter = AsciiBarCharter.new(min, max, precision, in_bw, reversed)
              plot = charter.plot(data, prefixed)

              puts plot + "\n"

              # Expected: "0.0\e[34;47m_\e[0m0.1\e[32;47m▁\e[0m0.2\e[32;47m▂\e[0m0.3\e[92;47m▃\e[0m0.4\e[92;47m▄\e[0m0.5\e[33;47m▅\e[0m0.6\e[33;47m▆\e[0m0.7\e[91;47m▇\e[0m0.8\e[91;47m█\e[0m0.9\e[31;47m▉\e[0m"
              # got: "0.0\e[31;47m_\e[0m0.1\e[31;47m▁\e[0m0.2\e[91;47m▂\e[0m0.3\e[91;47m▃\e[0m0.4\e[33;47m▄\e[0m0.5\e[33;47m▅\e[0m0.6\e[92;47m▆\e[0m0.7\e[92;47m▇\e[0m0.8\e[32;47m█\e[0m0.9\e[32;47m▉\e[0m"

              plot.should eq(expected_graph_chars)
            end
          end
        end

        describe "prefix disabled" do
          describe "and reverse disabled" do
            it "will return color-escaped bars from without prefix numbers in green to red colors" do
              min = 0.0
              max = 1.0
              precision = 2.to_i8
              in_bw = true
              data = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
              prefixed = false
              reversed = false
              expected_graph_chars = "_▁▂▃▄▅▆▇█▉"

              charter = AsciiBarCharter.new(min, max, precision, in_bw, reversed)
              plot = charter.plot(data, prefixed)

              puts plot + "\n"

              plot.should eq(expected_graph_chars)
            end
          end

          describe "and reverse enabled" do
            it "will return color-escaped bars from without prefix numbers in green to red colors" do
              min = 0.0
              max = 1.0
              precision = 2.to_i8
              in_bw = true
              data = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
              prefixed = false
              reversed = true
              expected_graph_chars = "_▁▂▃▄▅▆▇█▉"

              charter = AsciiBarCharter.new(min, max, precision, in_bw, reversed)
              plot = charter.plot(data, prefixed)

              puts plot + "\n"

              plot.should eq(expected_graph_chars)
            end
          end
        end
      end

      describe "custom chars and colors" do

        # @bar_chars = new_bar_chars
        # @bar_colors = new_bar_colors

        bar_chars_custom    = ['\'', '\u2591', '\u2592', '\u2593', '\u2588']
        # BAR_STEP_QTY = BAR_CHARS.size - 1 # first char is a 'floor', not a 'step'
        bar_colors_custom   = [:red, :green, :blue, :purple, :orange
          # Colorize::ColorRGB.new(0, 255, 255),
          # Colorize::ColorRGB.new(255, 0, 255),
          # Colorize::ColorRGB.new(255, 255, 0),
          # Colorize::ColorRGB.new(255, 0, 255),
          # Colorize::ColorRGB.new(0, 255, 255)
        ]


        describe "prefix enabled" do
          describe "and reverse disabled" do
            it "will return color-escaped bars from with prefix numbers ranging from 0.0 to 1.0 in green to red colors" do
              min = 0.0
              max = 1.0
              precision = 2.to_i8
              in_bw = true
              data = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
              prefixed = true
              reversed = false
              expected_graph_chars = "0.0'0.1'0.2░0.3░0.4▒0.5▒0.6▒0.7▓0.8▓0.9█"

              charter = AsciiBarCharter.new(min, max, precision, in_bw, reversed, bar_chars: bar_chars_custom, bar_colors: bar_colors_custom)
              plot = charter.plot(data, prefixed)

              puts plot + "\n"

              plot.should eq(expected_graph_chars)
            end
          end

          describe "and reverse enabled" do
            it "it will return color-escaped bars from with prefix numbers ranging from 0.0 to 1.0 in green to red colors" do
              min = 0.0
              max = 1.0
              precision = 2.to_i8
              in_bw = true
              data = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
              prefixed = true
              reversed = true
              expected_graph_chars = "0.0'0.1'0.2░0.3░0.4▒0.5▒0.6▒0.7▓0.8▓0.9█"

              charter = AsciiBarCharter.new(min, max, precision, in_bw, reversed, bar_chars: bar_chars_custom, bar_colors: bar_colors_custom)
              plot = charter.plot(data, prefixed)

              puts plot + "\n"

              # Expected: "0.0\e[34;47m_\e[0m0.1\e[32;47m▁\e[0m0.2\e[32;47m▂\e[0m0.3\e[92;47m▃\e[0m0.4\e[92;47m▄\e[0m0.5\e[33;47m▅\e[0m0.6\e[33;47m▆\e[0m0.7\e[91;47m▇\e[0m0.8\e[91;47m█\e[0m0.9\e[31;47m▉\e[0m"
              # got: "0.0\e[31;47m_\e[0m0.1\e[31;47m▁\e[0m0.2\e[91;47m▂\e[0m0.3\e[91;47m▃\e[0m0.4\e[33;47m▄\e[0m0.5\e[33;47m▅\e[0m0.6\e[92;47m▆\e[0m0.7\e[92;47m▇\e[0m0.8\e[32;47m█\e[0m0.9\e[32;47m▉\e[0m"

              plot.should eq(expected_graph_chars)
            end
          end
        end

        describe "prefix disabled" do
          describe "and reverse disabled" do
            it "will return color-escaped bars from without prefix numbers in green to red colors" do
              min = 0.0
              max = 1.0
              precision = 2.to_i8
              in_bw = true
              data = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
              prefixed = false
              reversed = false
              expected_graph_chars = "''░░▒▒▒▓▓█"

              charter = AsciiBarCharter.new(min, max, precision, in_bw, reversed, bar_chars: bar_chars_custom, bar_colors: bar_colors_custom)
              plot = charter.plot(data, prefixed)

              puts plot + "\n"

              plot.should eq(expected_graph_chars)
            end
          end

          describe "and reverse enabled" do
            it "will return color-escaped bars from without prefix numbers in green to red colors" do
              min = 0.0
              max = 1.0
              precision = 2.to_i8
              in_bw = true
              data = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
              prefixed = false
              reversed = true
              expected_graph_chars = "''░░▒▒▒▓▓█"

              charter = AsciiBarCharter.new(min, max, precision, in_bw, reversed, bar_chars: bar_chars_custom, bar_colors: bar_colors_custom)
              plot = charter.plot(data, prefixed)

              puts plot + "\n"

              plot.should eq(expected_graph_chars)
            end
          end
        end
      end
    end
  end
end
