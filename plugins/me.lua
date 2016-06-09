do
--create by @TeleGold_Team
function run(msg, matches)
local reply_id = msg['id']

local info = 'نام : '..msg.from.first_name..'\n'
..'فامیل : '..(msg.from.last_name or 'ندارد.')..'\n'
..'آیدی : '..msg.from.id..'\n'
..'شماره تلفن : +'..(msg.from.phone or 'نامشخص')..'\n'
..'نام کاربری : @'..(msg.from.username or 'ندارد')..'\n'
..'آیدی گروه : '..msg.to.id..'\n'
..'نام گروه : '..msg.to.title..'\n🔱 @TeleGold_Team 🔱'

reply_msg(reply_id, info, ok_cb, false)
end

return {
patterns = {
"^(من)",
"^[!/#]me"
--create by @TeleGold_Team
},
run = run
}

end
