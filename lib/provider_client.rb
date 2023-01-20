module RubyOuath
  class ProviderClient
    def self.basic_authorization
      "Basic #{Base64.strict_encode64(RubyOuath.configuration.client_id + ':' + RubyOuath.configuration.client_secret)}"
    end

    def self.redirect_uri(state)
      params = {
        response_type: 'code',
        client_id: RubyOuath.configuration.client_id
      }
      uri = URI('https://bitbucket.org/site/oauth2/authorize')
      uri.query = URI.encode_www_form(params)

      uri
    end

    def self.get_token_by_code(code)
      data = {
        code: code,
        grant_type: 'authorization_code'
      }

      res = RestClient.post(
        'https://bitbucket.org/site/oauth2/access_token',
        data,
        {
          Authorization: self.basic_authorization
        }
      )

      result = JSON.parse(res.body)
    end

    def self.update_token(refresh_token)
      url = 'https://bitbucket.org/site/oauth2/access_token'
      data = {
        refresh_token: refresh_token,
        grant_type: 'refresh_token',
      }
      res = RestClient.post(url,
        data,
        {
          Authorization: self.basic_authorization

        })
      JSON.parse(res.body)
    end
  end
end