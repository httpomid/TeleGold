local function tosticker(msg, success, result)
  local receiver = get_receiver(msg)
  if success then
    local file = 'data/stickers/'..msg.from.id..'.jpg'
    print('File downloaded to:', result)
    os.rename(result, file)
    print('File moved to:', file)
    send_photo(get_receiver(msg), file, ok_cb, false)
    redis:del("sticker:photo")
  else
    print('Error downloading: '..msg.id)
    send_large_msg(receiver, '🔱 متأسفم، مشکلی رخ داد، دوباره تلاش نمایید. 🔱', ok_cb, false)
  end
end
local function run(msg,matches)
    local receiver = get_receiver(msg)
    local group = msg.to.id
    if msg.media then
      	if msg.media.type == 'document' and is_momod(msg) and redis:get("sticker:photo") then
      		if redis:get("sticker:photo") == 'waiting' then
        		load_document(msg.id, tosticker, msg)
      		end
      	end
    end
    if matches[1] == "tophoto" and is_momod(msg) then
    	redis:set("sticker:photo", "waiting")
    	return '🔱لطفا استیکر مورد نظر را ارسال کنید.🔱'
    end
end
return {
  patterns = {
	"^[!/#][Tt]ophoto$",
	"%[(document)%]",
  },
  run = run,
}
