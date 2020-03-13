require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
ForecastIO.api_key = "1eca092840a61ca23b114d2fe4f66f49"

url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=d078b1b3a78b455daa5931c84b137fbc"
news = HTTParty.get(url).parsed_response.to_hash
# news is now a Hash you can pretty print (pp) and parse for your output
#pp news

get "/" do
  # show a view that asks for the location
  view "ask"
end

get "/news" do
  # do everything else

    results = Geocoder.search(params["input"])

    @lat_long = results.first.coordinates # [lat, long] array 

    @lat = @lat_long[0]
    @long = @lat_long[1]
  
    @forecast = ForecastIO.forecast(@lat,@long).to_hash
    
    #current temps and conditions
    @current_temp= @forecast ["currently"]["temperature"] #forecast is the first hash, access the hash within using [] and calling out variable you want in ""
    @current_conditions = @forecast["currently"] ["summary"]

    #temperatur forecasts for the next 3 days
    @forecast_temp1 = @forecast["daily"]["data"][1]["temperatureHigh"]
    @forecast_temp2 = @forecast["daily"]["data"][2]["temperatureHigh"]
    @forecast_temp3 = @forecast["daily"]["data"][3]["temperatureHigh"]

    #tomorrow's weather summary
    @forecast_conditions1 = @forecast["daily"]["data"][1]["summary"]

    #News headline assignment
    @headline_1 = news["articles"][0]["title"]
    @headline_1_url = news["articles"][0]["url"]
    @headline_1_photo = news["articles"][0]["urlToImage"]

    @headline_2 = news["articles"][1]["title"]
    @headline_2_url = news["articles"][1]["url"]
    @headline_2_photo = news["articles"][1]["urlToImage"]

    @headline_3 = news["articles"][2]["title"]
    @headline_3_url = news["articles"][2]["url"]
    @headline_3_photo = news["articles"][2]["urlToImage"]

    @headline_4 = news["articles"][3]["title"]
    @headline_4_url = news["articles"][3]["url"]
    @headline_4_photo = news["articles"][3]["urlToImage"]

    @headline_5 = news["articles"][4]["title"]
    @headline_5_url = news["articles"][4]["url"]
    @headline_5_photo = news["articles"][4]["urlToImage"]

    # @daily_temp = Array.new
    # @daily_summ = Array.new

    # i=0
    # for daily in @forecast["daily"]["data"]  #creates an array call daily
    #     @daily_temp[i] = @forecast["daily"]["data"][i+1]["temperatureHigh"]
    #     @daily_summ[i] = daily["summary"]
    #     i = i + 1
    # end

    # puts "daily temps are #{@daily_temp}"

    # for day in @forecast["daily"]["data"]
    # puts "A high temperature of #{day["temperatureHigh"]} and #{day["summary"]}."
    # end

    view "news"
   
end