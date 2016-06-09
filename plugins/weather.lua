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
  local temp = '🔱 دمای شهر '..city..'\n\n🔱 دمای کنونی هوا : '..weather.main.temp..' C\n\n🔱 فشار هوا :'..weather.main.pressure..'\n🔱 رطوبت هوا : '..weather.main.humidity..' %\n\n🔱 حداقل دمای امروز : '..weather.main.temp_min..'\n🔱 حداکثر دمای امروز : '..weather.main.temp_min..'\n\n🔱  🔱سرعت باد : '..weather.wind.speed..'\n🔱 درجه وزش باد : '..weather.wind.deg..'\n\n🔱 طول جغرافیایی : '..weather.coord.lon..'\n🔱 عرض جغرافیایی : '..weather.coord.lat
  local conditions = '🔱 شرایط فعلی آب و هوا : '

  if weather.weather[1].main == 'Clear' then
    conditions = conditions .. '🔱 آفتابی '
  elseif weather.weather[1].main == 'Clouds' then
    conditions = conditions .. '🔱 ابری '
  elseif weather.weather[1].main == 'Rain' then
    conditions = conditions .. '🔱 بارانی '
  elseif weather.weather[1].main == 'Thunderstorm' then
    conditions = conditions .. '🔱 طوفانی'
  elseif weather.weather[1].main == 'Mist' then
    conditions = conditions .. '🔱 مه '
  end

  return temp .. '\n\n' .. conditions..'\n\n🔱 TeleGold_Team 🔱\n‌'
end
local function run(msg, matches) 
    city = matches[1]
  local wtext = get_weather(city)
  if not wtext then
    wtext = '🔱 مکان وارد شده صحیح نیست. 🔱'
  end
  return wtext
end

return {

  patterns = {
   "^[/#!]weather (.*)$",
    },
  run = run
}
