local function chat_list(msg)
    local data = load_data(_config.moderation.data)
        local groups = 'groups'
        if not data[tostring(groups)] then
                return 'No groups at the moment'
        end
        local message = 'برای عضوییت در هر گروه بصورت زیر عمل کنید.\n#join شماره گروه\nبرای دریافت لینک هر گروه نیز:\n#link شماره گروه\n_____________________\n'
        for k,v in pairs(data[tostring(groups)]) do
                local settings = data[tostring(v)]['settings']
                for m,n in pairsByKeys(settings) do
                        if m == 'set_name' then
                                name = n
                        end
                end

                message = message .. 'نام گروه>'.. name .. '(شماره گروه: ' .. v .. ')\n____________________\n '
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
     return 'You are in ban'
  end
      if is_gbanned(msg.from.id) then
            return 'شما مسدود شدید از گروه یا گروها'
      end
      if data[tostring(matches[2])]['settings']['lock_member'] == 'yes' and not is_owner2(msg.from.id, matches[2]) then
        return 'گروه شخصی است اجازه ورود ندارید'
      end
          local chat_id = "chat#id"..matches[2]
          local user_id = "user#id"..msg.from.id
      chat_add_user(chat_id, user_id, ok_cb, false)   
   local group_link = data[tostring(matches[2])]['settings']['set_link']
   local group_name = data[tostring(matches[2])]['settings']['set_name']
   return "لینک گروه مورد نظر، خوش آمدید:\n"..group_link.."\n( نام گروه:"..group_name..")"
   
    elseif matches[1] == 'link' and not data[tostring(matches[2])] then

          return "گروه یافت نشد"
         end
    end
  else
   return "فقط برای سازنده امکان پذیر است"
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
    usage = "link ID && groups",
patterns = {"^([Ll]ink) (.*)$","^([Gg]roups)$","^[#/!]([Gg]roups)$"},
run = run
}
