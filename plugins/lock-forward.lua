do

local function pre_process(msg)
    
    local hash = 'mate:'..msg.to.id
    if redis:get(hash) and msg.fwd_from and not is_momod(msg)  then
	  channel_kick_user('channel#id'..msg.to.id,'user#id'..msg.from.id, ok_cb, false)
            return "forward has been locked"
        end
    
        return msg
    end

  


local function run(msg, matches)
    channel_id = msg.to.id
    
    if matches[1] == 'lock' and is_momod(msg) then
      
            
                    local hash = 'mate:'..msg.to.id
                    redis:set(hash, true)
                    return "Forward has been locked"
  elseif matches[1] == 'unlock' and is_momod(msg) then
                    local hash = 'mate:'..msg.to.id
                    redis:del(hash)
                    return "Forward has been unlocked"
					end
					if matches[1] == 'status' then
                    local hash = 'mate:'..msg.to.id
                    if redis:get(hash) then
                    return "forward is locked"
					else 
					return "forward is not locked"

end
end
end
return {
    patterns = {'^([lL]ock) forward$','^([uU]nlock) forward$','^forward (status)$',},
    run = run,
    pre_process = pre_process
}
end
