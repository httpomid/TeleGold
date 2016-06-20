#addplug function run(msg, matches)
local reply = msg['id']
local text = 'سلوم :)'
local text2 = 'سلام بابا جونم خسته نباشی عزیزم😍'
local text3 = 'سلام مدیر جونم :)'
local text4 = 'سلام ادمین خسته نباشی :)'
if not is_sudo(msg) then
return text
elseif is_sudo(msg) then
return text2
elseif is_owner(msg) and not is_sudo(msg) then
return text3
elseif is_momod(msg) then
return text4
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
} salam
