# frozen_string_literal: true

def process_(_, response)
  template = File.read('templates/index.html.erb')
  result = ERB.new(template).result

  render_html(result, response)
end
