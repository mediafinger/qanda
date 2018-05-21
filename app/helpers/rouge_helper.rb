# frozen_string_literal: true

module RougeHelper
  require "redcarpet"
  require "rouge"
  require "rouge/plugins/redcarpet"

  class HTMLRenderWithCodeHighlighting < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end
end
