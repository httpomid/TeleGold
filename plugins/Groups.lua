local function chat_list(msg)
    local data = load_data(_config.moderation.data)
        local groups = 'groups'
        if not data[tostring(groups)] then
                return '🔱 گروهی یافت نشد! 🔱'
        end
        local message = '🔱 لیست گروهای ربات تله گولد:\n🔱*برای جوین دادن اینگونه عمل کنید:\n #join شماره گروه\n🔱*و برای ارسال لینک گروه به این شکل:\n #link شماره گروه \n🔱 اعداد رو به لاتین وارد کنید.\n\n'
        for k,v in pairs(data[tostring(groups)]) do
                local settings = data[tostring(v)]['settings']
                for m,n in pairsByKeys(settings) do
                        if m == 'set_name' then
                                name = n
                        end
                end

                message = message .. '🔱گروه > '.. name .. ' (شماره گروه: ' .. v .. ')\n\n '
        end
        local file = io.open("./groups/lists/listed_groups.txt", "w")
        file:write(message)
        file:flush()
        file:close()
        return message
end
local function run(msg, matches)
  if msg.to.type ~= 'chat' or is_sudo(msg) and is_realm(msg) then
  local data = load_data(_config.moderation.data)
  if is_sudo(msg) then
    if matches[1] == 'link' and data[tostring(matches[2])] then
        if is_banned(msg.from.id, matches[2]) then
     return '🔱 شما از گروه مسدود (بن) شدید. 🔱'
  end
      if is_gbanned(msg.from.id) then
            return '🔱 متأسفیم، شما بصورت دائم از گروهای ربات تله گولد محروم شدید، اگر احساس میکنید اشکتباهی رخ داده است به کانال @TeleGold_Team بروید و با سازندگان در ارتباط شوید. 🔱'
      end
      if data[tostring(matches[2])]['settings']['lock_member'] == 'yes' and not is_owner2(msg.from.id, matches[2]) then
        return '🔱 متأسفم، این گروه شخصی است و اجازه ورود را ندارید! 🔱'
      end
          local chat_id = "chat#id"..matches[2]
          local user_id = "user#id"..msg.from.id
      chat_add_user(chat_id, user_id, ok_cb, false)   
   local group_link = data[tostring(matches[2])]['settings']['set_link']
   local group_name = data[tostring(matches[2])]['settings']['set_name']
   return "🔱 بفرمایید پیشاپیش خوش آمدید:\n"..group_link.."\n🔱(نام گروه:"..group_name..")🔱"
   
    elseif matches[1] == 'link' and not data[tostring(matches[2])] then

          return "🔱 گروه یافت نشد، اگر کیبورد شما فارسی است اول انگلیسی کنید بعد اعداد رو وارد کنید! 🔱"
         end
    end
  else
   return "🔱 فقط برای سازنده اصلی امکان پذیر است! 🔱"
  end

     if matches[1] == 'groups' then
      if is_sudo(msg) and msg.to.type == 'chat' then
         return chat_list(msg)
       elseif msg.to.type ~= 'chat' then
         return chat_list(msg)
      end
 end
 end
return {
    description = "See link of a group and groups list",
    usage = "!link ID && !groups",
patterns = {"^[!#/]([Ll]ink) (.*)$","^[!#/]([Gg]roups)$"},
run = run
}
