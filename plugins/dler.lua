function run(msg, matches)
 
 if matches[1] == 'dler' then
 
  if matches[3] == '.zip' then
   link = matches[2]..'.zip'
   format = '.zip'
   s = 'z'
  elseif matches[3] == '.rar' then
   link = matches[2]..'.rar'
   format = '.rar'
   s = 'r'
  elseif matches[3] == '.jpg' then
   link = matches[2]..'.jpg'
   format = '.jpg'
   s = 'j'
  elseif matches[3] == '.png' then
   link = matches[2]..'.png'
   format = '.png'
   s = 'p'
  elseif matches[3] == '.gif' then
   link = matches[2]..'.gif'
   format = '.gif'
   s = 'g'
  elseif matches[3] == '.apk' then
   link = matches[2]..'.apk'
   format = '.apk'
   s = 'a'
  elseif matches[3] == '.mp3' then
   link = matches[2]..'.mp3'
   format = '.mp3'
   s = 'm'
  elseif matches[3] == '.ogg' then
   link = matches[2]..'.ogg'
   format = '.ogg'
   s = 'o'
  elseif matches[3] == '.txt' then
   link = matches[2]..'.txt'
   format = '.txt'
   s = 't'
  elseif matches[3] == '.aspx' then
   link = matches[2]..'.aspx'
   format = '.aspx'
   s = 'as'
  elseif matches[3] == '.html' then
   return '🔱 این یک لینک غیر مستقیم است، لطفا از لینک مستقیم استفاده کنید.🔱'
  end
 end
  
 local file = download_to_file(link, 'dler'..format)
 
  if s == 'j' or s == 'g' or s == 'as' then
send_photo('channel#id'..msg.to.id,file,ok_cb,false)

send_photo('chat#id'..msg.to.id,file,ok_cb,false)
  end

  if s == 'p' or s == 'a' or s == 't' or s == 'z' or s == 'r' then
send_document('channel#id'..msg.to.id,file,ok_cb,false)

send_document('chat#id'..msg.to.id,file,ok_cb,false)
  end
  
  if s == 'o' or s == 'm' then
send_audio('channel#id'..msg.to.id,file,ok_cb,false)

send_audio('chat#id'..msg.to.id,file,ok_cb,false)
  end
end
return {
 description = "🔱 دانلود و دریافت فایل با لینک! 🔱",
 usage = "!dler (link)",
 advan = {
 "🔱 @TeleGold_Team 🔱",
 },
 patterns = {
  "^[!#/](dler) (.*)(.zip)$",
  "^[!#/](dler) (.*)(.rar)$",
  "^[!#/](dler) (.*)(.jpg)$",
  "^[!#/](dler) (.*)(.png)$",
  "^[!#/](dler) (.*)(.gif)$",
  "^[!#/](dler) (.*)(.apk)$",
  "^[!#/](dler) (.*)(.mp3)$",
  "^[!#/](dler) (.*)(.ogg)$",
  "^[!#/](dler) (.*)(.txt)$",
  "^[!#/](dler) (.*)(.aspx)$",
  "^[!#/](dler) (.*)(.html)$",
  "^() (.*)(.zip)$",
  "^(دانلود) (.*)(.rar)$",
  "^(دانلود) (.*)(.jpg)$",
  "^(دانلود) (.*)(.png)$",
  "^(دانلود) (.*)(.gif)$",
  "^(دانلود) (.*)(.apk)$",
  "^(دانلود) (.*)(.mp3)$",
  "^(دانلود) (.*)(.ogg)$",
  "^(دانلود) (.*)(.txt)$",
  "^(دانلود) (.*)(.aspx)$",
  "^(دانلود) (.*)(.html)$",
  "^(دریافت) (.*)(.rar)$",
  "^(دریافت) (.*)(.jpg)$",
  "^(دریافت) (.*)(.png)$",
  "^(دریافت) (.*)(.gif)$",
  "^(دریافت) (.*)(.apk)$",
  "^(دریافت) (.*)(.mp3)$",
  "^(دریافت) (.*)(.ogg)$",
  "^(دریافت) (.*)(.txt)$",
  "^(دانلود) (.*)(.aspx)$",
  "^(دریافت) (.*)(.html)$"
 },
 run = run,
} 
