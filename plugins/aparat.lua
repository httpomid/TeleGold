local function run(msg, matches)
	if matches[1]:lower() == 'aparat' then
		local url = http.request('http://www.aparat.com/etc/api/videoBySearch/text/'..URL.escape(matches[2]))
		local jdat = json:decode(url)
		local items = jdat.videobysearch
		text = 'نتیجه جستجو در آپارات:\n'
		for i = 1, #items do
		text = text..'\n'..i..'- '..items[i].title..'  -تعداد بازدید:'..items[i].visit_cnt..'\nلینک: aparat.com/v/'..items[i].uid
		end
		text = text..'\n\n @TeleGold_Team '
		return text
	end
end
return {
   patterns = {
"^([aA]parat) (.*)$"},
   run = run
}
