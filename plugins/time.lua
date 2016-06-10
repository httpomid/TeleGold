

function run(msg, matches)
local url , res = http.request('http://api.gpmod.ir/time/')
if res ~= 200 then return "🔱 ارتباط ما با سرور قطع شد. 🔱" end
local jdat = json:decode(url)
local text = '🔱 ساعت '..jdat.FAtime..' \n🔱 امروز '..jdat.FAdate..' میباشد.\n    ----\n🔱 '..jdat.ENtime..'\n🔱 '..jdat.ENdate.. '\n🔱 @TeleGold_Team 🔱\n‌‌‌'
return text
end
return {
  patterns = {
  "^[/!]([Tt][iI][Mm][Ee])$"
 "^(زمان)$",
  "^(ساعت)$",
   "^(تاریخ)$",
   "^(ساعت و تاریخ)$"
  }, 
run = run 
}

