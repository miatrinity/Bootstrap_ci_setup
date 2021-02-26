require 'application_system_test_case'

module RailsNewIo
  class BootstrapTest < ApplicationSystemTestCase
    BOOTSTRAP_TEXT_DANGER = 'rgb(239, 68, 68)'.freeze
    BOOTSTRAP_DISPLAY_4 = '2.25rem'.freeze

    test 'Bootstrap is Enabled' do
      visit verify_index_path

      assert_selector 'span', text: 'Hello, Bootstrap!'
      assert_equal computed_color, expected_bootstrap_color, 'Error: color not computed correctly'
      assert_equal computed_font_size, expected_bootstrap_font_size, 'Error: font size not computed correctly'
    end

    private

    def computed_color
      computed_style_for(selector: 'span', attribute: 'color')
    end

    def expected_bootstrap_color
      BOOTSTRAP_TEXT_DANGER
    end

    def computed_font_size
      computed_style_for(selector: 'span', attribute: 'font-size')
    end

    def expected_bootstrap_font_size
      font_size_in_pixels = (root_element_font_size.to_i * BOOTSTRAP_DISPLAY_4.to_f).to_i
      "#{font_size_in_pixels}px"
    end

    def root_element_font_size
      computed_style_for(selector: 'html', attribute: 'font-size')
    end

    def computed_style_for(selector:, attribute:)
      evaluate_script("window.getComputedStyle(document.querySelector('#{selector}'))['#{attribute}']")
    end
  end
end
