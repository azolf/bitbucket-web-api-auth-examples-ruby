def process_refresh_token(request, response)
    result = RubyOuath::ProviderClient.update_token(request.query['refresh_token'])

    render_json(result.to_json, response)
end
