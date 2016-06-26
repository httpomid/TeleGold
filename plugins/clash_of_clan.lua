local apikey ='eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6ImU5NmIyODBiLTkzOWUtNDdkYy1iMGUwLWFkNzc0MmFmMTZlZSIsImlhdCI6MTQ2MjI3MjkyNCwic3ViIjoiZGV2ZWxvcGVyL2IyMWNkYTZhLWUwMjMtMWIxYS02ZWFkLWRjYTk0ZGMzY2Y3ZiIsInNjb3BlcyI6WyJjbGFzaCJdLCJsaW1pdHMiOlt7InRpZXIiOiJkZXZlbG9wZXIvc2lsdmVyIiwidHlwZSI6InRocm90dGxpbmcifSx7ImNpZHJzIjpbIjEzOC4yMDEuNzguMTYxIl0sInR5cGUiOiJjbGllbnQifV19.DSJPvqL5E2at0jR5d-QoRnoJv_wR9nzvHs9fnezv8xcFgw5nKoXuF8QhXwkQtnBJz8NNTgteO9zDeDQ1dSUJeg'
local function run(msg, matches)
 if matches[1]:lower() == 'clan' or matches[1]:lower() == 'clash' or matches[1]:lower() == 'clantag' or matches[1]:lower() == 'tag' then
  local clantag = matches[2]
  if string.match(matches[2], '^#.+$') then
     clantag = string.gsub(matches[2], '#', '')
  end
  clantag = string.upper(clantag)
  local curl = 'curl -X GET --header "Accept: application/json" --header "authorization: Bearer '..apikey..'" "https://api.clashofclans.com/v1/clans/%23'..clantag..'"'
  cmd = io.popen(curl)
  
  local result = cmd:read('*all')
  local jdat = json:decode(result)
if jdat.reason then
      if jdat.reason == 'accessDenied' then return 'For the record API Key Go to site\ndeveloper.clashofclans.com' end
   return 'مشکل در اتصال\n'..jdat.reason
  end
  local text = 'تگ کلن: '.. jdat.tag
     text = text..'\nنام کلن: '.. jdat.name
     text = text..'\nتوضیحات: '.. jdat.description
     text = text..'\nتایپ: '.. jdat.type
     text = text..'\nزمان وار '.. jdat.warFrequency
     text = text..'\nلول کلن: '.. jdat.clanLevel
     text = text..'\nپیروزی ها در وار '.. jdat.warWins
     text = text..'\nنکتهای کلن: '.. jdat.clanPoints
     text = text..'\nغنائم ضروری: '.. jdat.requiredTrophies
     text = text..'\nتعداد اعضا '.. jdat.members
     text = text..'\n\n@TeleGold_Team'
     cmd:close()
  return text
 end
 if matches[1]:lower() == 'members' or matches[1]:lower() == 'clashmembers' or matches[1]:lower() == 'clanmembers' then
  local members = matches[2]
  if string.match(matches[2], '^#.+$') then
     members = string.gsub(matches[2], '#', '')
  end
  members = string.upper(members)
  local curl = 'curl -X GET --header "Accept: application/json" --header "authorization: Bearer '..apikey..'" "https://api.clashofclans.com/v1/clans/%23'..members..'/members"'
  cmd = io.popen(curl)
  local result = cmd:read('*all')
  local jdat = json:decode(result)
  if jdat.reason then
      if jdat.reason == 'accessDenied' then return 'For the record API Key Go to site\ndeveloper.clashofclans.com' end
   return 'مشکل در اتصال\n'..jdat.reason
  end
  local leader = ""
  local coleader = ""
  local items = jdat.items
  leader = 'مدیران کلن \n'
   for i = 1, #items do
   if items[i].role == "leader" then
   leader = leader.."\nلیدر: "..items[i].name.."\nلول کلن: "..items[i].expLevel
   end
   if items[i].role == "coleader" then
   coleader = coleader.."\nلیدر: "..items[i].name.."\nلول کلن: "..items[i].expLevel
   end
  end
text = leader.."\n"..coleader.."\n\nتعداد افراد "
  for i = 1, #items do
  text = text..'\n'..i..'- '..items[i].name..'\nلول کلن: '..items[i].expLevel.."\n"
  end
  text = text.."\n\n@TeleGold_Team"
   cmd:close()
  return text
 end
end
return {
   patterns = {"^([cC]lash) (.*)$","^([cC]lan) (.*)$","^([cC]lantag) (.*)$","^([tT]ag) (.*)$","^([cC]lashmembers) (.*)$","^([cC]lanmembers) (.*)$","^([mM]embers) (.*)$",},
   run = run
}
