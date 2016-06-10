do
    local function run(msg, matches)
    local support = '148595896' 
    local data = load_data(_config.moderation.data)
    local name_log = user_print_name(msg.from)
        if matches[1] == 'support' then
        local group_link = data[tostring(support)]['settings']['set_link']
    return "👑 گروه ساپورت ربات تله گولد ( @TeleGold):\n"..group_link
    end
end
return {
    patterns = {
    "^[!/#](support)$",
     },
    run = run
}
end
