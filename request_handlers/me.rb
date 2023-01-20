# frozen_string_literal: true

def process_me(_, response)
  template = File.read('templates/me.html.erb')
  result = ERB.new(template).result

  render_html(result, response)
end
