# frozen_string_literal: true

require_relative 'test_helper'

class IconStylesTagTest < Minitest::Test
  def render_tag(config)
    template = Liquid::Template.parse('{% al_icons_styles %}')
    site = Struct.new(:config).new(config)
    template.render({}, registers: { site: site })
  end

  def test_renders_all_icon_links_with_integrity
    output = render_tag(
      'third_party_libraries' => {
        'fontawesome' => {
          'url' => { 'css' => 'https://cdn.example/fontawesome.css' },
          'integrity' => { 'css' => 'sha-fa' }
        },
        'academicons' => {
          'url' => { 'css' => 'https://cdn.example/academicons.css' },
          'integrity' => { 'css' => 'sha-ai' }
        },
        'scholar-icons' => {
          'url' => { 'css' => 'https://cdn.example/scholar-icons.css' },
          'integrity' => { 'css' => 'sha-si' }
        }
      }
    )

    assert_includes output, 'fontawesome.css'
    assert_includes output, 'academicons.css'
    assert_includes output, 'scholar-icons.css'
    assert_includes output, 'integrity="sha-fa"'
    assert_includes output, 'integrity="sha-ai"'
    assert_includes output, 'integrity="sha-si"'
    assert_includes output, 'crossorigin="anonymous"'
  end

  def test_renders_without_integrity_when_not_configured
    output = render_tag(
      'third_party_libraries' => {
        'fontawesome' => {
          'url' => { 'css' => 'https://cdn.example/fontawesome.css' }
        }
      }
    )

    assert_includes output, 'fontawesome.css'
    refute_includes output, 'integrity='
    refute_includes output, 'crossorigin='
  end

  def test_returns_empty_when_missing_libraries
    output = render_tag({ 'third_party_libraries' => {} })
    assert_equal '', output
  end

  def test_skips_library_when_css_url_missing
    output = render_tag(
      'third_party_libraries' => {
        'fontawesome' => {
          'url' => {}
        }
      }
    )

    assert_equal '', output
  end

  def test_gem_does_not_package_local_icon_assets
    gemspec = Gem::Specification.load(File.expand_path('../al_icons.gemspec', __dir__))
    packaged_assets = gemspec.files.grep(%r{\Aassets/})

    assert_equal [], packaged_assets
  end
end
