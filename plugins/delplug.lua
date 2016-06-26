local function run(msg, matches)
    if matches[1] == "delplug" and is_sudo(msg) then
text = io.popen("cd plugins && rm "..matches[2]..".lua")
return text.."["..matches[2].."]حذف شد"
end 
end
return { 
patterns = {
'^([dD]elplug) (.*)$' 
},
run = run,
}
