local function run(msg)
    if not is_momod(msg) then
        delete_msg(msg.id, ok_cb, true)
        return
    end
 end
 return {
patterns = {"^!!tgservice (chat_add_user)$","^!!tgservice (chat_add_user_link)$","^!!tgservice (chat_del_user)$","[!/#]kickme",[Kk]ickme","^!!tgservice (.+)$"},
 run = run
}
