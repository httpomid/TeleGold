local BASE_URL = "http://api.openweathermap.org/data/2.5/weather"
local function get_weather(location)
  print("Finding weather in ", location)
  local url = BASE_URL
  url = url..'?q='..location..'&APPID=eedbc05ba060c787ab0614cad1f2e12b'
  url = url..'&units=metric'
  local b, c, h = http.request(url)
  if c ~= 200 then return nil end
  local weather = json:decode(b)
  local city = weather.name
  local country = weather.sys.country
  local temp = 'دمای شهر '..city..'\n دمای کنونی هوا : '..weather.main.temp..' C\nفشار هوا :'..weather.main.pressure..'\nرطوبت هوا : '..weather.main.humidity..'%\nحداقل دمای امروز : '..weather.main.temp_min..'\nحداکثر دمای امروز : '..weather.main.temp_min..'\nسرعت باد : '..weather.wind.speed..'\n درجه وزش باد : '..weather.wind.deg..'\nطول جغرافیایی : '..weather.coord.lon..'\nعرض جغرافیایی : '..weather.coord.lat
  local conditions = 'شرایط فعلی آب و هوا : '
  if weather.weather[1].main == 'Clear' then
    conditions = conditions .. 'آفتابی ☀'
  elseif weather.weather[1].main == 'Clouds' then
    conditions = conditions .. 'ابری ☁☁'
  elseif weather.weather[1].main == 'Rain' then
    conditions = conditions .. 'بارانی ☔'
  elseif weather.weather[1].main == 'Thunderstorm' then
    conditions = conditions .. 'طوفانی 🌪'
  elseif weather.weather[1].main == 'Mist' then
    conditions = conditions .. 'مه 🌫'
  end
  return temp .. '\n\n' .. conditions..'\n\n @TeleGold_Team '
end
local function run(msg, matches) 
    city = matches[1]
  local wtext = get_weather(city)
  if not wtext then
    wtext = 'مکان وارد شده صحیح نیست'
  end
  return wtext
end
return {
  patterns = {"^[wW]eather (.*)$",},
  run = run
}
