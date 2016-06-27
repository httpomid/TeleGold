local function savefile(extra, success, result)
  local msg = extra.msg
  local name = extra.name
  local adress = extra.adress
  local receiver = get_receiver(msg)
  if success then
    local file = './'..adress..'/'..name..''
    print('File saving to:', result)
    os.rename(result, file)
    print('File moved to:', file)
  else
    print('Error downloading: '..msg.id)
    send_large_msg(receiver, 'انجام نشد', ok_cb, false)
  end
end
local function run(msg,matches)
    local receiver = get_receiver(msg)
    local group = msg.to.id
    if msg.reply_id then
    local adress = matches[2]
   local name = matches[3]
      if matches[1] == "file" and matches[2] and matches[3] and is_sudo(msg) then
load_document(msg.reply_id, savefile, {msg=msg,name=name,adress=adress})
        return ' فایل شما با نام: '..name..' ذخیره شد در: \n./'..adress
      end
      
         if not is_sudo(msg) then
           return "فقط سازندگان"
         end
end
end
return {
  patterns = {
 "^([Ff]ile) (.*) (.*)$",
"^([sS]ive) (.*) (.*)$",
  },
  run = run,
}
