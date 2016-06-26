
function run(msg, matches)
local url , res = http.request('http://api.gpmod.ir/time/')
if res ~= 200 then return "ارتباط وصل نشد" end
local jdat = json:decode(url)
local text = 'ساعت '..jdat.FAtime..' \nامروز '..jdat.FAdate..' میباشد.\n………\n'..jdat.ENtime..'\n'..jdat.ENdate.. '\n@TeleGold_Team'
return text
end
return {
  patterns = {
  "^زمان$",
  "^[tT]ime$",
  }, 
run = run 
}

