module Cmsify
  module Helpers
    def abc(opts={})
      if opts[:slug]
        abc_slug(opts)
      elsif opts[:object] && opts[:field]
        abc_object(opts)
      end
    end

    # private

    def can_update?
      Cmsify.configuration.can_update && Cmsify.configuration.can_update.call(request)
    end

    def abc_slug(opts)
      slug = opts[:slug]
      text_obj = ::Cmsify::Text.find_or_create_by(slug: slug) do |text|
        text.content = "Lorem ipsum dolor sit amet"
      end

      abc_object(object: text_obj, field: :content)
    end

    def abc_object(opts)
      object = opts[:object]
      field = opts[:field]

      if can_update?
        return "<div cmsify-text-edit text='#{object.try(field)}' object-model='#{object.class}' object-id='#{object.id}' field='#{field}'></div>".html_safe
      else
        return object.try(field)
      end
    end
  end
end