local function run(msg, matches)
    
  local text = matches[2]
  local bot_id = 184244646
   if matches[1] == 'پسرم بگو' and matches[2] and matches[3] == 'و لفت بده' and is_sudo(msg) then
    chat_del_user("chat#id"..msg.to.id, 'user#id'..bot_id, ok_cb, false)
    return text
  end
end
return {
patterns = {
"^(پسرم بگو) (.*) (و لفت بده)$"
},
run = run
}

--by @TeleGold_Team
