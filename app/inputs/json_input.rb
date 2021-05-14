#-*- encoding: utf-8; tab-width: 2 -*-

class JsonInput < Formtastic::Inputs::TextInput
  def to_html
    schema = options[:schema].to_json.html_safe
    editor_options = (options[:options] || {}).merge(schema: schema)
    current_value = @object.public_send method
    element_id = "jsoneditor-wrap-#{wrapper_dom_id}"

    html = %(<div id="#{element_id}" class="jsoneditor-wrap">)
    html << builder.text_area(method, input_html_options.merge(
                                        value: (current_value.respond_to?(:to_json) ? current_value.to_json : '')))
    html << '</div>'
    html << %(<script>document.addEventListener("DOMContentLoaded", () => activateJsonEditor("##{element_id}", #{editor_options.to_json.html_safe}))</script>)
    html << '<div style="clear: both"></div>'
    input_wrapping do
      label_html << html.html_safe
    end
  end
end
