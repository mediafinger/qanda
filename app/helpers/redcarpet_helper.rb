# frozen_string_literal: true

# Documentation: https://github.com/vmg/redcarpet
module RedcarpetHelper
  def render_as_markdown(string)
    markdown.render(string).html_safe
  end

  def markdown
    @markdown ||= Redcarpet::Markdown.new(renderer, {
      autolink: true,
      disable_indented_code_blocks: true,
      fenced_code_blocks: true,
      highlight: true,
      no_intra_emphasis: true,
      space_after_headers: true,
      strikethrough: true,
    })
  end

  def renderer
    @renderer ||= RougeHelper::HTMLRenderWithCodeHighlighting.new(
      {
        escape_html: true,
        prettify: true,
        safe_links_only: true,
      }
    )
  end
end
