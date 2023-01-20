def cookie(request, name)
  request.cookies.select { |c| c.name == name }.first
end