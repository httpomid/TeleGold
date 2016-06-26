do
local function run(msg, matches)
  if matches[1] == 'wai' then
    if is_sudo(msg) then
      return "شما سازنده ربات تله گلد هستید"
    elseif is_owner(msg) then
      return " شما مدیر گروه هستید! "
    elseif is_momod(msg) then
      return "شما دستیار مدیر گروه (ادمین) هستید!"
    else
      return "شما جایگاهی خاصی ندارید!"
    end
  end
end
return {
  patterns = {"^([Ww]ai)$",},
  run = run
}
end 
