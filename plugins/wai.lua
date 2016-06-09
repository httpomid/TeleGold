do

local function run(msg, matches)
  if matches[1] == 'wai' then
    if is_sudo(msg) then
     --send_document(get_receiver(msg), "/home/Seed/axs/sudo.webp", ok_cb, false)
      return "🔱 با عرض ادب شما سازنده ربات تله گلد هستید! 🔱"
    elseif is_owner(msg) then
   -- send_document(get_receiver(msg), "/home/Seed/axs/owner.webp", ok_cb, false)
      return "🔱 شما مدیر گروه هستید! 🔱"
    elseif is_momod(msg) then
  --  send_document(get_receiver(msg), "/home/Seed/axs/mod.webp", ok_cb, false)
      return "🔱 شما دستیار مدیر گروه (ادمین) هستید! 🔱"
    else
  --  send_document(get_receiver(msg), "/root/Tele/axs/mmbr.webp", ok_cb, false)
      return "🔱 شما جایگاهی خاصی ندارید! 🔱"
    end
  end
end

return {
  patterns = {"^[#!/]([Ww]ai)$",},
  run = run
}
end 
