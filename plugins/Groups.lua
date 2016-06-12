local function chat_list(msg)
    local data = load_data(_config.moderation.data)
        local groups = 'groups'
        if not data[tostring(groups)] then
                return '🔱 گروهی که وارد کردید اشتباه است. 🔱'
        end
        local message = '🔱 برای عضوییت در گروهی که میخواید کافیه به شکل زیر عمل کنید:\n🔱 #join شماره گروه\n🔱 و برای دریافت لینک گروه مورد نظر به این شکل:\n🔱 #link شماره گروه \n____________________\n'
        for k,v in pairs(data[tostring(groups)]) do
                local settings = data[tostring(v)]['settings']
                for m,n in pairsByKeys(settings) do
                        if m == 'set_name' then
                                name = n
                        end
                end

                message = message .. '🔱 گروه: '.. name .. ' (شماره گروه: ' .. v .. ' )\n____________________\n '
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
     return '🔱شما از گروه مسدود شده اید! 🔱'
  end
      if is_gbanned(msg.from.id) then
            return '🔱 شما برای همیشه از این گروه یا همه گروهای ربات تله گولد اخراج و مسدود شدید! 🔱'
      end
      if data[tostring(matches[2])]['settings']['lock_member'] == 'yes' and not is_owner2(msg.from.id, matches[2]) then
        return '🔱این گروه شخصی است!🔱'
      end
          local chat_id = "chat#id"..matches[2]
          local user_id = "user#id"..msg.from.id
      chat_add_user(chat_id, user_id, ok_cb, false)   
   local group_link = data[tostring(matches[2])]['settings']['set_link']
   local group_name = data[tostring(matches[2])]['settings']['set_name']
   return "🔱 لینک گروه مورد نظر شما خوش اومدید:\n"..group_link.."\n\n(Group name:"..group_name..")\n🔱 @TeleGold_Team 🔱"
   
    elseif matches[1] == 'link' and not data[tostring(matches[2])] then

          return "🔱 گروه یافت نشد لطفا اول کیبورد را فارسی کنید سپس شماره گروه را وارد کنید. 🔱"
         end
    end
  else
   return "🔱فقط برای سازندگان🔱"
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
