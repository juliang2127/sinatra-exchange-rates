require "sinatra"
require "sinatra/reloader"
require "json"
require "http"

api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"

get("/") do
  api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"

  # use HTTP.get to retrieve the API information
  raw_data = HTTP.get(api_url)

  # convert the raw request to a string
  raw_data_string = raw_data.to_s

  # convert the string to JSON
  @parsed_data = JSON.parse(raw_data_string)

  @currency_parsed = @parsed_data.fetch("currencies")

  @currency_parsed_keys = @currency_parsed.keys

  # Here, get the currency symbols from the JSON, I recommend starting by 
  # making it an instance variable (@parsed_data), then showing that 
  # instance variable in the `views/homepage.erb` view template that you 
  # are rendering below (use <%= %> ERB tags to render it in that view template).

  # render a view template where I show the symbols
  erb(:homepage)
end

get("/:from_currency") do
  @original_currency = params.fetch("from_currency")

  api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"

  raw_data = HTTP.get(api_url)

  # convert the raw request to a string
  raw_data_string = raw_data.to_s

  # convert the string to JSON
  @parsed_data = JSON.parse(raw_data_string)

  @currency_parsed = @parsed_data.fetch("currencies")

  @currency_parsed_keys = @currency_parsed.keys
  
  # some more code to parse the URL and render a view template
  # (HINT: this code is identical to the first route, you just
  # render a different view template at the end.)
  erb(:flexible)
end

get("/:from_currency/:to_currency") do
  @original_currency = params.fetch("from_currency")
  @destination_currency = params.fetch("to_currency")

  api_url = "https://api.exchangerate.host/convert?access_key=#{ENV["EXCHANGE_RATE_KEY"]}&from=#{@original_currency}&to=#{@destination_currency}&amount=1"

  raw_data = HTTP.get(api_url)

  # convert the raw request to a string
  raw_data_string = raw_data.to_s

  # convert the string to JSON
  @parsed_data = JSON.parse(raw_data_string)

  @parsed_data_info = @parsed_data.fetch("result")

  # some more code to parse the URL and render a view template
  erb(:flexible2)
end
