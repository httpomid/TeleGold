#addplug function run(msg, matches)
local reply = msg['id']
local text = 'جان :) '
local text2 = 'جونم بابایی 😍'
local text3 = 'جانم مدیر :)'
local text4 = 'جان ادمین جون :)'
if not is_sudo(msg) then
reply_msg(reply, text, ok_cb, false)
elseif is_sudo(msg) then
reply_msg(reply, text2, ok_cb, false)
elseif is_owner(msg) and not is_sudo(msg) then
reply_msg(reply, text3, ok_cb, false)
elseif is_momod(msg) then
reply_msg(reply, text4, ok_cb, false)
end
end
return {
patterns = {
"^ربوت$",
"^[rR]obot$",
"^[bB]ot$",
"^[rR]obot?$",
"^[rR]obot??$",
"^[bB]ot?$",
"^ربات$",
"^ربات؟$",
"^ربات؟؟$",
"^ربات😍$",
"^ربات جون$"
},
run = run
} robot
