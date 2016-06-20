 function run(msg, matches)
local reply = msg['id']
local text = 'سلام خوبی؟ '..msg.from.print_name
local text2 = 'سلام بابا جونم، فدای سلام کردنت بشم من😍'
if not is_sudo(msg) then
reply_msg(reply, text, ok_cb, false)
elseif is_sudo(msg) then
reply_msg(reply, text2, ok_cb, false)
end
end
return {
patterns = {
"^سلام$",
"^[Hh]i$",
"^[Ss]lm$",
"^[Ss]alam$",
"^[Hh]ello$",
"^[Hh]elo$",
"^شلام$",
"^دلام$",
"^سلوم$",
"^سیلام$",
"^هلو$"
},
run = run
}
