# frozen_string_literal: true

module Jekyll
  module Related
    TEMPLATE = Liquid::Template.parse(File.read(File.join(__dir__, "related.html")))
    class Tag < Liquid::Tag
      def render(context)
        TEMPLATE.render(context)
      end
    end
  end
end

Liquid::Template.register_tag("related", Jekyll::Related::Tag)
