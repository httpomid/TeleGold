do

function run(msg, matches)
       if not is_momod(msg) then
        return "🔱 فقط برای مدیران گروه امکان پذیر است. 🔱"
       end
	  local data = load_data(_config.moderation.data)
      local group_link = data[tostring(msg.to.id)]['settings']['set_link']
       if not group_link then 
        return "create #newlink"
       end
         local text = "🔱 لینک گروه، ارسال شده در پی وی شما 🔱\n"..group_link
          send_large_msg('user#id'..msg.from.id, text.."\n", ok_cb, false)
end

return {
  patterns = {
    "^[!/#]linkpv"
  },
  run = run
}

end
