
local function run(msg, matches)
    if matches[1] == "delplug" and is_sudo(msg) then
text = io.popen("cd plugins && rm "..matches[2]..".lua")
return text.."🔱پلاگینی با نام: ["..matches[2].."] با موفقیت حذف شد🔱"
end 
end

return { 
patterns = {
 
'^[!#/](delplug) (.*)$' 
},
run = run,
}
