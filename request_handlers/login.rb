# frozen_string_literal: true

def process_login(_, response)
  uri = RubyOuath::ProviderClient.redirect_uri(random_string)

  redirect_to(uri.to_s, response)
end
