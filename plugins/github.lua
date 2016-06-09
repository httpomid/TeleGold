local function run(msg, matches)
  local eq = URL.escape(matches[1])
     url = "https://api.github.com/users/"..eq
     jstr, res = https.request(url)
     jdat = JSON.decode(jstr)
  if jdat.message then
  return jdat.message
  else
     text = jdat.login..'\nفالورها: '..jdat.followers..'\nفالوینگ: '..jdat.following..'\nرپو: '..jdat.public_repos..'\nلینک پروفایل: '..jdat.html_url..'\n🔱 @TeleGold_Team'
  local file = download_to_file(jdat.avatar_url,'Sbss.webp')
  send_document('chat#id'..msg.to.id,file,ok_cb,false)
  return text
end
end
return {
  🔱 به این گونه عمل کنید = "github search", 
  usage = {
"!git <gituser> : github search",
},
  patterns = {
    "^[!#/][gG]it (.*)",
  "^[!#/][gG]it[hH]ub (.*)",
"^گیت (.*)",
  },
  run = run
}
