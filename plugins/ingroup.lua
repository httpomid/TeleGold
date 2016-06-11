do

-- Check Member
local function check_member_autorealm(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local data = cb_extra.data
  local msg = cb_extra.msg
  for k,v in pairs(result.members) do
    local member_id = v.peer_id
    if member_id ~= our_id then
      -- Group configuration
      data[tostring(msg.to.id)] = {
        group_type = 'Realm',
        settings = {
          set_name = string.gsub(msg.to.print_name, '_', ' '),
          lock_name = 'yes',
          lock_photo = 'no',
          lock_member = 'no',
          flood = 'yes'
        }
      }
      save_data(_config.moderation.data, data)
      local realms = 'realms'
      if not data[tostring(realms)] then
        data[tostring(realms)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(realms)][tostring(msg.to.id)] = msg.to.id
      save_data(_config.moderation.data, data)
      return send_large_msg(receiver, 'به ریلم جدیدتان خوش آمدید')
    end
  end
end
local function check_member_realm_add(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local data = cb_extra.data
  local msg = cb_extra.msg
  for k,v in pairs(result.members) do
    local member_id = v.peer_id
    if member_id ~= our_id then
      -- Group configuration
      data[tostring(msg.to.id)] = {
        group_type = 'Realm',
        settings = {
          set_name = string.gsub(msg.to.print_name, '_', ' '),
          lock_name = 'yes',
          lock_photo = 'no',
          lock_member = 'no',
          flood = 'yes'
        }
      }
      save_data(_config.moderation.data, data)
      local realms = 'realms'
      if not data[tostring(realms)] then
        data[tostring(realms)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(realms)][tostring(msg.to.id)] = msg.to.id
      save_data(_config.moderation.data, data)
      return send_large_msg(receiver, 'ریلم اضافه شد')
    end
  end
end
function check_member_group(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local data = cb_extra.data
  local msg = cb_extra.msg
  for k,v in pairs(result.members) do
    local member_id = v.peer_id
    if member_id ~= our_id then
      -- Group configuration
      data[tostring(msg.to.id)] = {
        group_type = 'Group',
        moderators = {},
        set_owner = member_id ,
        settings = {
          set_name = string.gsub(msg.to.print_name, '_', ' '),
          lock_name = 'yes',
          lock_photo = 'no',
          lock_member = 'no',
          flood = 'yes',
        }
      }
      save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = msg.to.id
      save_data(_config.moderation.data, data)
      return send_large_msg(receiver, 'شما به دارنده ارتقا یافتید')
    end
  end
end
local function check_member_modadd(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local data = cb_extra.data
  local msg = cb_extra.msg
  for k,v in pairs(result.members) do
    local member_id = v.peer_id
    if member_id ~= our_id then
      -- Group configuration
      data[tostring(msg.to.id)] = {
        group_type = 'Group',
		long_id = msg.to.peer_id,
        moderators = {},
        set_owner = member_id ,
        settings = {
          set_name = string.gsub(msg.to.print_name, '_', ' '),
          lock_name = 'yes',
          lock_photo = 'no',
          lock_member = 'no',
          flood = 'yes',
        }
      }
      save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = msg.to.id
      save_data(_config.moderation.data, data)
      return send_large_msg(receiver, 'گروه اضافه شد و اکنون شما صاحب آن هستید')
    end
  end
end
local function automodadd(msg)
  local data = load_data(_config.moderation.data)
  if msg.action.type == 'chat_created' then
    receiver = get_receiver(msg)
    chat_info(receiver, check_member_group,{receiver=receiver, data=data, msg = msg})
  end
end
local function autorealmadd(msg)
  local data = load_data(_config.moderation.data)
  if msg.action.type == 'chat_created' then
    receiver = get_receiver(msg)
    chat_info(receiver, check_member_autorealm,{receiver=receiver, data=data, msg = msg})
  end
end
local function check_member_realmrem(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local data = cb_extra.data
  local msg = cb_extra.msg
  for k,v in pairs(result.members) do
    local member_id = v.id
    if member_id ~= our_id then
      -- Realm configuration removal
      data[tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
      local realms = 'realms'
      if not data[tostring(realms)] then
        data[tostring(realms)] = nil
        save_data(_config.moderation.data, data)
      end
      data[tostring(realms)][tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
      return send_large_msg(receiver, 'ریلم حذف شد')
    end
  end
end
local function check_member_modrem(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local data = cb_extra.data
  local msg = cb_extra.msg
  for k,v in pairs(result.members) do
    local member_id = v.peer_id
    if member_id ~= our_id then
      -- Group configuration removal
      data[tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = nil
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
      return send_large_msg(receiver, 'گروه حذف شد')
    end
  end
end
--End Check Member
function show_group_settingsmod(msg, target)
 	if not is_momod(msg) then
    	return "فقط برای مدیران!"
  	end
  	local data = load_data(_config.moderation.data)
    if data[tostring(target)] then
     	if data[tostring(target)]['settings']['flood_msg_max'] then
        	NUM_MSG_MAX = tonumber(data[tostring(target)]['settings']['flood_msg_max'])
        	print('custom'..NUM_MSG_MAX)
      	else
        	NUM_MSG_MAX = 5
      	end
    end
    local bots_protection = "Yes"
    if data[tostring(target)]['settings']['lock_bots'] then
    	bots_protection = data[tostring(target)]['settings']['lock_bots']
   	end
    local leave_ban = "no"
    if data[tostring(target)]['settings']['leave_ban'] then
    	leave_ban = data[tostring(target)]['settings']['leave_ban']
   	end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_link'] then
			data[tostring(target)]['settings']['lock_link'] = 'no'
		end
	end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_sticker'] then
			data[tostring(target)]['settings']['lock_sticker'] = 'no'
		end
	end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['public'] then
			data[tostring(target)]['settings']['public'] = 'no'
		end
	end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_rtl'] then
			data[tostring(target)]['settings']['lock_rtl'] = 'no'
		end
	end
  local settings = data[tostring(target)]['settings']
  local text = "🔧تنظیمات کلی:\n🔐قفل نام گروه: "..settings.lock_name.."\n🔐قفل عکس گروه: "..settings.lock_photo.."\n🔐قفل اعضا: "..settings.lock_member.."\n🔐قفل لفت اعضا: "..leave_ban.."\n🔐حساسیت اسپم: "..NUM_MSG_MAX.."\n🔐قفل ربات: "..bots_protection.."\n🔐قفل لینک: "..settings.lock_link.."\n🔐قفل استیکر: "..settings.lock_sticker.."\n"
  return text
end

local function set_descriptionmod(msg, data, target, about)
  if not is_momod(msg) then
    return
  end
  local data_cat = 'description'
  data[tostring(target)][data_cat] = about
  save_data(_config.moderation.data, data)
  return 'توضیحات گروه تنظیم شد به:\n'..about
end
local function get_description(msg, data)
  local data_cat = 'description'
  if not data[tostring(msg.to.id)][data_cat] then
    return 'متن توضیحی تنظیم نشده است.'
  end
  local about = data[tostring(msg.to.id)][data_cat]
  local about = string.gsub(msg.to.print_name, "_", " ")..':\n\n'..about
  return 'درباره '..about
end
local function lock_group_arabic(msg, data, target)
  if not is_momod(msg) then
    return 
  end
  local group_arabic_lock = data[tostring(target)]['settings']['lock_arabic']
  if group_arabic_lock == 'yes' then
    return 'عربی از قبل قفل بود'
  else
    data[tostring(target)]['settings']['lock_arabic'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'عربی قفل شد'
  end
end

local function unlock_group_arabic(msg, data, target)
  if not is_momod(msg) then
    return 
  end
  local group_arabic_lock = data[tostring(target)]['settings']['lock_arabic']
  if group_arabic_lock == 'no' then
    return 'عربی از قبل باز بود'
  else
    data[tostring(target)]['settings']['lock_arabic'] = 'no'
    save_data(_config.moderation.data, data)
    return 'عربی باز شد'
  end
end

local function lock_group_bots(msg, data, target)
  if not is_momod(msg) then
    return 
  end
  local group_bots_lock = data[tostring(target)]['settings']['lock_bots']
  if group_bots_lock == 'yes' then
    return 'Bots protection is already enabled'
  else
    data[tostring(target)]['settings']['lock_bots'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'Bots protection has been enabled'
  end
end

local function unlock_group_bots(msg, data, target)
  if not is_momod(msg) then
    return 
  end
  local group_bots_lock = data[tostring(target)]['settings']['lock_bots']
  if group_bots_lock == 'no' then
    return 'Bots protection is already disabled'
  else
    data[tostring(target)]['settings']['lock_bots'] = 'no'
    save_data(_config.moderation.data, data)
    return 'Bots protection has been disabled'
  end
end

local function lock_group_namemod(msg, data, target)
  if not is_momod(msg) then
    return 
  end
  local group_name_set = data[tostring(target)]['settings']['set_name']
  local group_name_lock = data[tostring(target)]['settings']['lock_name']
  if group_name_lock == 'yes' then
    return 'نام گروه از قبل قفل بوده است'
  else
    data[tostring(target)]['settings']['lock_name'] = 'yes'
    save_data(_config.moderation.data, data)
    rename_chat('chat#id'..target, group_name_set, ok_cb, false)
    return 'نام گروه قفل شد'
  end
end
local function unlock_group_namemod(msg, data, target)
  if not is_momod(msg) then
    return 
  end
  local group_name_set = data[tostring(target)]['settings']['set_name']
  local group_name_lock = data[tostring(target)]['settings']['lock_name']
  if group_name_lock == 'no' then
    return 'نام گروه از قبل باز است'
  else
    data[tostring(target)]['settings']['lock_name'] = 'no'
    save_data(_config.moderation.data, data)
    return 'نام گروه باز شد'
  end
end
local function lock_group_floodmod(msg, data, target)
  if not is_momod(msg) then
    return 
  end
  local group_flood_lock = data[tostring(target)]['settings']['flood']
  if group_flood_lock == 'yes' then
    return 'اسپم قفل است'
  else
    data[tostring(target)]['settings']['flood'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'اسپم قفل شد'
  end
end

local function unlock_group_floodmod(msg, data, target)
  if not is_momod(msg) then
	return 
  end
  if not is_owner(msg) then
    return "فقط برای سازنده"
  end
  local group_flood_lock = data[tostring(target)]['settings']['flood']
  if group_flood_lock == 'no' then
    return 'اسپم قفل نیست'
  else
    data[tostring(target)]['settings']['flood'] = 'no'
    save_data(_config.moderation.data, data)
    return 'اسپم آزاد شد'
  end
end

local function lock_group_membermod(msg, data, target)
  if not is_momod(msg) then
    return 
  end
  local group_member_lock = data[tostring(target)]['settings']['lock_member']
  if group_member_lock == 'yes' then
    return 'اعضا از قبل قفل بودند'
  else
    data[tostring(target)]['settings']['lock_member'] = 'yes'
    save_data(_config.moderation.data, data)
  end
  return 'اعضا قفل شدند'
end

local function unlock_group_membermod(msg, data, target)
  if not is_momod(msg) then
    return 
  end
  local group_member_lock = data[tostring(target)]['settings']['lock_member']
  if group_member_lock == 'no' then
    return 'اعضا قفل نیستند'
  else
    data[tostring(target)]['settings']['lock_member'] = 'no'
    save_data(_config.moderation.data, data)
    return 'اعضا باز شدند'
  end
end


local function set_public_membermod(msg, data, target)
  if not is_momod(msg) then
    return 
  end
  local group_member_lock = data[tostring(target)]['settings']['public']
  local long_id = data[tostring(target)]['long_id']
  if not long_id then
	data[tostring(target)]['long_id'] = msg.to.peer_id 
	save_data(_config.moderation.data, data)
  end
  if group_member_lock == 'yes' then
    return 'Group is already public'
  else
    data[tostring(target)]['settings']['public'] = 'yes'
    save_data(_config.moderation.data, data)
  end
  return 'Group is now: public'
end

local function unset_public_membermod(msg, data, target)
  if not is_momod(msg) then
    return 
  end
  local group_member_lock = data[tostring(target)]['settings']['public']
  local long_id = data[tostring(target)]['long_id']
  if not long_id then
	data[tostring(target)]['long_id'] = msg.to.peer_id 
	save_data(_config.moderation.data, data)
  end
  if group_member_lock == 'no' then
    return 'Group is not public'
  else
    data[tostring(target)]['settings']['public'] = 'no'
    save_data(_config.moderation.data, data)
    return 'Group is now: not public'
  end
end

local function lock_group_leave(msg, data, target)
  if not is_momod(msg) then
    return 
  end
  local leave_ban = data[tostring(target)]['settings']['leave_ban']
  if leave_ban == 'yes' then
    return 'اعضایی که لفت میدهند اخراج و مسدود میشوند'
  else
    data[tostring(target)]['settings']['leave_ban'] = 'yes'
    save_data(_config.moderation.data, data)
  end
  return 'اعضایی که لفت میدهند بن میشوند'
end

local function unlock_group_leave(msg, data, target)
  if not is_momod(msg) then
    return 
  end
  local leave_ban = data[tostring(msg.to.id)]['settings']['leave_ban']
  if leave_ban == 'no' then
    return 'اعضایی که لفت میدهند بن نمیشوند'
  else
    data[tostring(target)]['settings']['leave_ban'] = 'no'
    save_data(_config.moderation.data, data)
    return 'اعضایی که لفت میدهند بن نمیشوند'
  end
end

local function unlock_group_photomod(msg, data, target)
  if not is_momod(msg) then
    return 
  end
  local group_photo_lock = data[tostring(target)]['settings']['lock_photo']
  if group_photo_lock == 'no' then
    return 'عکس گروه قفل نیست'
  else
    data[tostring(target)]['settings']['lock_photo'] = 'no'
    save_data(_config.moderation.data, data)
    return 'عکس گروه باز شد'
  end
end

local function lock_group_links(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_link_lock = data[tostring(target)]['settings']['lock_link']
  if group_link_lock == 'yes' then
    return 'لینک قفل بود'
  else
    data[tostring(target)]['settings']['lock_link'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'لینک قفل شد'
  end
end

local function unlock_group_links(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_link_lock = data[tostring(target)]['settings']['lock_link']
  if group_link_lock == 'no' then
    return 'لینک قفل نبود'
  else
    data[tostring(target)]['settings']['lock_link'] = 'no'
    save_data(_config.moderation.data, data)
    return 'لینک باز شد'
  end
end

local function lock_group_rtl(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_rtl_lock = data[tostring(target)]['settings']['lock_rtl']
  if group_rtl_lock == 'yes' then
    return 'RTL is already locked'
  else
    data[tostring(target)]['settings']['lock_rtl'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'RTL has been locked'
  end
end

local function unlock_group_rtl(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_rtl_lock = data[tostring(target)]['settings']['lock_rtl']
  if group_rtl_lock == 'no' then
    return 'RTL is already unlocked'
  else
    data[tostring(target)]['settings']['lock_rtl'] = 'no'
    save_data(_config.moderation.data, data)
    return 'RTL has been unlocked'
  end
end

local function lock_group_sticker(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_sticker_lock = data[tostring(target)]['settings']['lock_sticker']
  if group_sticker_lock == 'yes' then
    return 'استیکر قفل بود'
  else
    data[tostring(target)]['settings']['lock_sticker'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'استیکر قفل شد'
  end
end

local function unlock_group_sticker(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_sticker_lock = data[tostring(target)]['settings']['lock_sticker']
  if group_sticker_lock == 'no' then
    return 'استیکر باز بود'
  else
    data[tostring(target)]['settings']['lock_sticker'] = 'no'
    save_data(_config.moderation.data, data)
    return 'استیکر باز شد'
  end
end

local function lock_group_contacts(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_rtl_lock = data[tostring(target)]['settings']['lock_contacts']
  if group_contacts_lock == 'yes' then
    return 'شیر مخاطب از قبل قفل بود'
  else
    data[tostring(target)]['settings']['lock_contacts'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'شیر مخاطب قفل شد'
  end
end

local function unlock_group_contacts(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_contacts_lock = data[tostring(target)]['settings']['lock_contacts']
  if group_contacts_lock == 'no' then
    return 'شیر مخاطب از قبل باز بود'
  else
    data[tostring(target)]['settings']['lock_contacts'] = 'no'
    save_data(_config.moderation.data, data)
    return 'شیر مخاطب باز شد'
  end
end

local function enable_strict_rules(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_rtl_lock = data[tostring(target)]['settings']['strict']
  if strict == 'yes' then
    return 'Settings are already strictly enforced'
  else
    data[tostring(target)]['settings']['strict'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'Settings will be strictly enforced'
  end
end

local function disable_strict_rules(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_contacts_lock = data[tostring(target)]['settings']['strict']
  if strict == 'no' then
    return 'Settings are not strictly enforced'
  else
    data[tostring(target)]['settings']['strict'] = 'no'
    save_data(_config.moderation.data, data)
    return 'Settings will not be strictly enforced'
  end
end

local function set_rulesmod(msg, data, target)
  if not is_momod(msg) then
    return "فقط برای مدیران!"
  end
  local data_cat = 'rules'
  data[tostring(target)][data_cat] = rules
  save_data(_config.moderation.data, data)
  return 'قانون گروه تنظیم شد به:\n\n'..rules
end
local function modadd(msg)
  -- superuser and admins only (because sudo are always has privilege)
   if not is_momod(msg) then
	return
  end
  if not is_admin1(msg) then
    return "شما ادمین نیستید"
  end
  local data = load_data(_config.moderation.data)
  if is_group(msg) then
    return 'گروه از قبل اضافه شده است.'
  end
    receiver = get_receiver(msg)
    chat_info(receiver, check_member_modadd,{receiver=receiver, data=data, msg = msg})
end
local function realmadd(msg)
  -- superuser and admins only (because sudo are always has privilege)
  if not is_momod(msg) then
	return
  end
  if not is_admin1(msg) then
    return "شما ادمین نیستید"
  end
  local data = load_data(_config.moderation.data)
  if is_realm(msg) then
    return 'ریلم از قبل اضافه شده است.'
  end
    receiver = get_receiver(msg)
    chat_info(receiver, check_member_realm_add,{receiver=receiver, data=data, msg = msg})
end
-- Global functions
function modrem(msg)
  -- superuser and admins only (because sudo are always has privilege)
  if not is_admin1(msg) then
    return "شما ادمین نیستید"
  end
  local data = load_data(_config.moderation.data)
  if not is_group(msg) then
    return 'گروه اضافه نشده است.'
  end
    receiver = get_receiver(msg)
    chat_info(receiver, check_member_modrem,{receiver=receiver, data=data, msg = msg})
end

function realmrem(msg)
  -- superuser and admins only (because sudo are always has privilege)
  if not is_admin1(msg) then
    return "شما ادمین نیستید"
  end
  local data = load_data(_config.moderation.data)
  if not is_realm(msg) then
    return 'ریلم اضافه نشده است.'
  end
    receiver = get_receiver(msg)
    chat_info(receiver, check_member_realmrem,{receiver=receiver, data=data, msg = msg})
end
local function get_rules(msg, data)
  local data_cat = 'قوانین'
  if not data[tostring(msg.to.id)][data_cat] then
    return 'قانونی تنظیم نشده است.'
  end
  local rules = data[tostring(msg.to.id)][data_cat]
  local rules = 'قوانین گروه:\n\n'..rules
  return rules
end

local function set_group_photo(msg, success, result)
  local data = load_data(_config.moderation.data)
  local receiver = get_receiver(msg)
  if success then
    local file = 'data/photos/chat_photo_'..msg.to.id..'.jpg'
    print('فایل بارگذاری شد در:', result)
    os.rename(result, file)
    print('فایل منتقل شد به:', file)
    chat_set_photo (receiver, file, ok_cb, false)
    data[tostring(msg.to.id)]['settings']['set_photo'] = file
    save_data(_config.moderation.data, data)
    data[tostring(msg.to.id)]['settings']['lock_photo'] = 'yes'
    save_data(_config.moderation.data, data)
    send_large_msg(receiver, 'عکس ذخیره شد!', ok_cb, false)
  else
    print('مشکل در بارگذاری '..msg.id)
    send_large_msg(receiver, 'خطایی رخ داد لطفا دوباره امتحان کنید', ok_cb, false)
  end
end

local function promote(receiver, member_username, member_id)
  local data = load_data(_config.moderation.data)
  local group = string.gsub(receiver, 'chat#id', '')
  local member_tag_username = string.gsub(member_username, '@', '(at)')
  if not data[group] then
    return send_large_msg(receiver, 'گروه اضافه نشده است.')
  end
  if data[group]['moderators'][tostring(member_id)] then
    return send_large_msg(receiver, member_username..' این یک مدیر است.')
  end
  data[group]['moderators'][tostring(member_id)] = member_username
  save_data(_config.moderation.data, data)
  return send_large_msg(receiver, member_username..' ترفیع پیدا کرد.')
end

local function promote_by_reply(extra, success, result)
    local msg = result
    local full_name = (msg.from.first_name or '')..' '..(msg.from.last_name or '')
    if msg.from.username then
      member_username = '@'.. msg.from.username
    else
      member_username = full_name
    end
    local member_id = msg.from.peer_id
    if msg.to.peer_type == 'chat' then
      return promote(get_receiver(msg), member_username, member_id)
    end
end

local function demote(receiver, member_username, member_id)
  local data = load_data(_config.moderation.data)
  local group = string.gsub(receiver, 'chat#id', '')
  if not data[group] then
    return send_large_msg(receiver, 'گروه اضافه نشده است.')
  end
  if not data[group]['moderators'][tostring(member_id)] then
    return send_large_msg(receiver, member_username..' این یک مدیر نیست.')
  end
  data[group]['moderators'][tostring(member_id)] = nil
  save_data(_config.moderation.data, data)
  return send_large_msg(receiver, member_username..' تنزل درجه پیدا کرد.')
end

local function demote_by_reply(extra, success, result)
    local msg = result
    local full_name = (msg.from.first_name or '')..' '..(msg.from.last_name or '')
    if msg.from.username then
      member_username = '@'..msg.from.username
    else
      member_username = full_name
    end
    local member_id = msg.from.peer_id
    if msg.to.peer_type == 'chat' then
      return demote(get_receiver(msg), member_username, member_id)
    end
end

local function setowner_by_reply(extra, success, result)
  local msg = result
  local receiver = get_receiver(msg)
  local data = load_data(_config.moderation.data)
  local name_log = msg.from.print_name:gsub("_", " ")
  data[tostring(msg.to.id)]['set_owner'] = tostring(msg.from.id)
      save_data(_config.moderation.data, data)
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] set ["..msg.from.id.."] as owner")
      local text = msg.from.print_name:gsub("_", " ").." الان سازنده گروه است"
      return send_large_msg(receiver, text)
end

local function promote_demote_res(extra, success, result)
--vardump(result)
--vardump(extra)
      local member_id = result.peer_id
      local member_username = "@"..result.username
      local chat_id = extra.chat_id
      local mod_cmd = extra.mod_cmd
      local receiver = "chat#id"..chat_id
      if mod_cmd == 'promote' then
        return promote(receiver, member_username, member_id)
      elseif mod_cmd == 'demote' then
        return demote(receiver, member_username, member_id)
      end
end
local function mute_user_callback(extra, success, result)
	if result.service then
		local action = result.action.type
		if action == 'chat_add_user' or action == 'chat_del_user' or action == 'chat_rename' or action == 'chat_change_photo' then
			if result.action.user then
				user_id = result.action.user.peer_id
			end
		end
	else
		user_id = result.from.peer_id
	end
	local receiver = extra.receiver
	local chat_id = string.gsub(receiver, 'channel#id', '')
	if is_muted_user(chat_id, user_id) then
		mute_user(chat_id, user_id)
		send_large_msg(receiver, "["..user_id.."] از لیست میوت حذف شد")
	else
		unmute_user(chat_id, user_id)
		send_large_msg(receiver, " ["..user_id.."] به لیست میوت اضافه شد")
	end
end

local function modlist(msg)
  local data = load_data(_config.moderation.data)
  local groups = "groups"
  if not data[tostring(groups)][tostring(msg.to.id)] then
    return 'گروه اضافه نشده است.'
  end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['moderators']) == nil then --fix way
    return 'مدیری در گروه نیست.'
  end
  local i = 1
  local message = '\nلیست مدیران ' .. string.gsub(msg.to.print_name, '_', ' ') .. ':\n'
  for k,v in pairs(data[tostring(msg.to.id)]['moderators']) do
    message = message ..i..' - '..v..' [' ..k.. '] \n'
    i = i + 1
  end
  return message
end

local function callbackres(extra, success, result)
  local user = result.peer_id
  local name = string.gsub(result.print_name, "_", " ")
  local chat = 'chat#id'..extra.chatid
  send_large_msg(chat, user..'\n'..name)
  return user
end

local function callback_mute_res(extra, success, result)
	local user_id = result.peer_id
	local receiver = extra.receiver
	local chat_id = string.gsub(receiver, 'chat#id', '')
	if is_muted_user(chat_id, user_id) then
		unmute_user(chat_id, user_id)
		send_large_msg(receiver, " ["..user_id.."] از لیست میوت حدف شد")
	else
		mute_user(chat_id, user_id)
		send_large_msg(receiver, " ["..user_id.."] به لیست میوت اضافه شد")
	end
end

local function help()
  local help_text = tostring(_config.help_text)
  return help_text
end

local function cleanmember(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local chat_id = "chat#id"..result.id
  local chatname = result.print_name
  for k,v in pairs(result.members) do
    kick_user(v.id, result.peer_id)
  end
end

local function killchat(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local chat_id = "chat#id"..result.id
  local chatname = result.print_name
  for k,v in pairs(result.members) do
    kick_user_any(v.id, result.peer_id)
  end
end

local function killrealm(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local chat_id = "chat#id"..result.id
  local chatname = result.print_name
  for k,v in pairs(result.members) do
    kick_user_any(v.id, result.peer_id)
  end
end

--[[local function user_msgs(user_id, chat_id)
  local user_info
  local uhash = 'user:'..user_id
  local user = redis:hgetall(uhash)
  local um_hash = 'msgs:'..user_id..':'..chat_id
  user_info = tonumber(redis:get(um_hash) or 0)
  return user_info
end

local function kick_zero(cb_extra, success, result)
    local chat_id = cb_extra.chat_id
    local chat = "chat#id"..chat_id
    local ci_user
    local re_user
    for k,v in pairs(result.members) do
        local si = false
        ci_user = v.peer_id
        local hash = 'chat:'..chat_id..':users'
        local users = redis:smembers(hash)
        for i = 1, #users do
            re_user = users[i]
            if tonumber(ci_user) == tonumber(re_user) then
                si = true
            end
        end
        if not si then
            if ci_user ~= our_id then
                if not is_momod2(ci_user, chat_id) then
                  chat_del_user(chat, 'user#id'..ci_user, ok_cb, true)
                end
            end
        end
    end
end

local function kick_inactive(chat_id, num, receiver)
    local hash = 'chat:'..chat_id..':users'
    local users = redis:smembers(hash)
    -- Get user info
    for i = 1, #users do
        local user_id = users[i]
        local user_info = user_msgs(user_id, chat_id)
        local nmsg = user_info
        if tonumber(nmsg) < tonumber(num) then
            if not is_momod2(user_id, chat_id) then
              chat_del_user('chat#id'..chat_id, 'user#id'..user_id, ok_cb, true)
            end
        end
    end
    return chat_info(receiver, kick_zero, {chat_id = chat_id})
end]]

local function run(msg, matches)
  local data = load_data(_config.moderation.data)
  local receiver = get_receiver(msg)
   local name_log = user_print_name(msg.from)
  local group = msg.to.id
  if msg.media then
    if msg.media.type == 'photo' and data[tostring(msg.to.id)] and data[tostring(msg.to.id)]['settings']['set_photo'] == 'waiting' and is_chat_msg(msg) and is_momod(msg) then
      load_photo(msg.id, set_group_photo, msg)
    end
  end
if msg.to.type == 'chat' then
  if is_admin1(msg) or not is_support(msg.from.id) then-- Admin only
	  if matches[1] == 'اضافه' and not matches[2] then
		if not is_admin1(msg) and not is_support(msg.from.id) then-- Admin only
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] attempted to add group [ "..msg.to.id.." ]")
			return
		end
		if is_realm(msg) then
		   return 'خطا! اینجا یک ریلم است'
		end
		savelog(msg.to.id, name_log.." ["..msg.from.id.."] added group [ "..msg.to.id.." ]")
		print("گروه "..msg.to.print_name.."("..msg.to.id..") اضافه شد")
		return modadd(msg)
	  end
	   if matches[1] == 'اضافه' and matches[2] == 'ریلم' then
		if not is_sudo(msg) then-- Admin only
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] attempted to add realm [ "..msg.to.id.." ]")
			return
		end
		if is_group(msg) then
		   return 'خطا! اینجا یک گروه است.'
		end
		savelog(msg.to.id, name_log.." ["..msg.from.id.."] added realm [ "..msg.to.id.." ]")
		print("ریلم "..msg.to.print_name.."("..msg.to.id..") اضافه شد")
		return realmadd(msg)
	  end
	  if matches[1] == 'حذف' and not matches[2] then
		if not is_admin1(msg) and not is_support(msg.from.id) then-- Admin only
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] attempted to remove group [ "..msg.to.id.." ]")
			return
		end
		if not is_group(msg) then
		   return 'خطا!اینجا گروه نیست.'
		end
		savelog(msg.to.id, name_log.." ["..msg.from.id.."] removed group [ "..msg.to.id.." ]")
		print("گروه "..msg.to.print_name.."("..msg.to.id..") حذف شد")
		return modrem(msg)
	  end
	  if matches[1] == 'حذف' and matches[2] == 'realm' then
		if not is_sudo(msg) then-- Sudo only
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] attempted to remove realm [ "..msg.to.id.." ]")
			return
		end
		if not is_realm(msg) then
		   return 'Error: Not a realm.'
		end
		savelog(msg.to.id, name_log.." ["..msg.from.id.."] removed realm [ "..msg.to.id.." ]")
		print("ریلم "..msg.to.print_name.."("..msg.to.id..") حذف شد")
		return realmrem(msg)
	  end
	end
  if matches[1] == 'chat_created' and msg.from.id == 0 and group_type == "group" then
    return automodadd(msg)
  end
 --[[Experimental
  if matches[1] == 'chat_created' and msg.from.id == 0 and group_type == "super_group" then
	local chat_id = get_receiver(msg)
	users = {[1]="user#id167472799",[2]="user#id170131770"}
		for k,v in pairs(users) do
			chat_add_user(chat_id, v, ok_cb, false)
		end
	--chat_upgrade(chat_id, ok_cb, false)
  end ]]
  if matches[1] == 'chat_created' and msg.from.id == 0 and group_type == "realm" then
    return autorealmadd(msg)
  end
  if msg.to.id and data[tostring(msg.to.id)] then
    local settings = data[tostring(msg.to.id)]['settings']
    if matches[1] == 'chat_add_user' then
      if not msg.service then
        return
      end
      local group_member_lock = settings.lock_member
      local user = 'user#id'..msg.action.user.id
      local chat = 'chat#id'..msg.to.id
      if group_member_lock == 'yes' and not is_owner2(msg.action.user.id, msg.to.id) then
        chat_del_user(chat, user, ok_cb, true)
      elseif group_member_lock == 'yes' and tonumber(msg.from.id) == tonumber(our_id) then
        return nil
      elseif group_member_lock == 'no' then
        return nil
      end
    end
    if matches[1] == 'chat_del_user' then
      if not msg.service then
         -- return "Are you trying to troll me?"
      end
      local user = 'user#id'..msg.action.user.id
      local chat = 'chat#id'..msg.to.id
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] deleted user  "..user)
    end
    if matches[1] == 'chat_delete_photo' then
      if not msg.service then
        return
      end
      local group_photo_lock = settings.lock_photo
      if group_photo_lock == 'yes' then
        local picturehash = 'picture:changed:'..msg.to.id..':'..msg.from.id
        redis:incr(picturehash)
        ---
        local picturehash = 'picture:changed:'..msg.to.id..':'..msg.from.id
        local picprotectionredis = redis:get(picturehash)
        if picprotectionredis then
          if tonumber(picprotectionredis) == 4 and not is_owner(msg) then
            kick_user(msg.from.id, msg.to.id)
          end
          if tonumber(picprotectionredis) ==  8 and not is_owner(msg) then
            ban_user(msg.from.id, msg.to.id)
            local picturehash = 'picture:changed:'..msg.to.id..':'..msg.from.id
            redis:set(picturehash, 0)
          end
        end

        savelog(msg.to.id, name_log.." ["..msg.from.id.."] tried to deleted picture but failed  ")
        chat_set_photo(receiver, settings.set_photo, ok_cb, false)
      elseif group_photo_lock == 'no' then
        return nil
      end
    end
    if matches[1] == 'chat_change_photo' and msg.from.id ~= 0 then
      if not msg.service then
        return
      end
      local group_photo_lock = settings.lock_photo
      if group_photo_lock == 'yes' then
        local picturehash = 'picture:changed:'..msg.to.id..':'..msg.from.id
        redis:incr(picturehash)
        ---
        local picturehash = 'picture:changed:'..msg.to.id..':'..msg.from.id
        local picprotectionredis = redis:get(picturehash)
        if picprotectionredis then
          if tonumber(picprotectionredis) == 4 and not is_owner(msg) then
            kick_user(msg.from.id, msg.to.id)
          end
          if tonumber(picprotectionredis) ==  8 and not is_owner(msg) then
            ban_user(msg.from.id, msg.to.id)
          local picturehash = 'picture:changed:'..msg.to.id..':'..msg.from.id
          redis:set(picturehash, 0)
          end
        end

        savelog(msg.to.id, name_log.." ["..msg.from.id.."] tried to change picture but failed  ")
        chat_set_photo(receiver, settings.set_photo, ok_cb, false)
      elseif group_photo_lock == 'no' then
        return nil
      end
    end
    if matches[1] == 'chat_rename' then
      if not msg.service then
        return
      end
      local group_name_set = settings.set_name
      local group_name_lock = settings.lock_name
      local to_rename = 'chat#id'..msg.to.id
      if group_name_lock == 'yes' then
        if group_name_set ~= tostring(msg.to.print_name) then
          local namehash = 'name:changed:'..msg.to.id..':'..msg.from.id
          redis:incr(namehash)
          local namehash = 'name:changed:'..msg.to.id..':'..msg.from.id
          local nameprotectionredis = redis:get(namehash)
          if nameprotectionredis then
            if tonumber(nameprotectionredis) == 4 and not is_owner(msg) then
              kick_user(msg.from.id, msg.to.id)
            end
            if tonumber(nameprotectionredis) ==  8 and not is_owner(msg) then
              ban_user(msg.from.id, msg.to.id)
              local namehash = 'name:changed:'..msg.to.id..':'..msg.from.id
              redis:set(namehash, 0)
            end
          end
          savelog(msg.to.id, name_log.." ["..msg.from.id.."] tried to change name but failed  ")
          rename_chat(to_rename, group_name_set, ok_cb, false)
        end
      elseif group_name_lock == 'no' then
        return nil
      end
    end
    if matches[1] == 'تنظیم نام' and is_momod(msg) then
      local new_name = string.gsub(matches[2], '_', ' ')
      data[tostring(msg.to.id)]['settings']['set_name'] = new_name
      save_data(_config.moderation.data, data)
      local group_name_set = data[tostring(msg.to.id)]['settings']['set_name']
      local to_rename = 'chat#id'..msg.to.id
      rename_chat(to_rename, group_name_set, ok_cb, false)

      savelog(msg.to.id, "Group { "..msg.to.print_name.." }  name changed to [ "..new_name.." ] by "..name_log.." ["..msg.from.id.."]")
    end
    if matches[1] == 'تنظیم عکس' and is_momod(msg) then
      data[tostring(msg.to.id)]['settings']['set_photo'] = 'waiting'
      save_data(_config.moderation.data, data)
      return 'لطفا عکس را ارسال کنید'
    end
    if matches[1] == 'ترفیع' and not matches[2] then
	   if not is_momod(msg) then
        return
      end
      if not is_owner(msg) then
        return "فقط سازنده قادر به این کار است"
      end
      if type(msg.reply_id)~="nil" then
          msgr = get_message(msg.reply_id, promote_by_reply, false)
      end
    end
    if matches[1] == 'ترفیع' and matches[2] then
      if not is_momod(msg) then
        return
      end
      if not is_owner(msg) then
        return "فقط سازنده"
      end
	local member = matches[2]
	savelog(msg.to.id, name_log.." ["..msg.from.id.."] promoted @".. member)
	local cbres_extra = {
		chat_id = msg.to.id,
        mod_cmd = 'promote',
		from_id = msg.from.id
	}
	local username = matches[2]
	local username = string.gsub(matches[2], '@', '')
	return resolve_username(username, promote_demote_res, cbres_extra)
    end
    if matches[1] == 'تنزل' and not matches[2] then
	  if not is_momod(msg) then
        return
      end
      if not is_owner(msg) then
        return "قفط سازنده قادر به تنزل کردن یک ادمین است"
      end
      if type(msg.reply_id)~="nil" then
          msgr = get_message(msg.reply_id, demote_by_reply, false)
      end
    end
    if matches[1] == 'تنزل' and matches[2] then
      if not is_momod(msg) then
        return
      end
      if not is_owner(msg) then
        return "فقط سازنده"
      end
      if string.gsub(matches[2], "@", "") == msg.from.username and not is_owner(msg) then
        return "شما نمیتوانید برای خود از تنزل استفاده کنید"
      end
	local member = matches[2]
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] demoted @".. member)
	local cbres_extra = {
	chat_id = msg.to.id,
        mod_cmd = 'demote',
	from_id = msg.from.id
	}
	local username = matches[2]
	local username = string.gsub(matches[2], '@', '')
	return resolve_username(username, promote_demote_res, cbres_extra)
    end
    if matches[1] == 'لیست مدیران' then
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested group modlist")
      return modlist(msg)
    end
    if matches[1] == 'درباره' then
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested group description")
      return get_description(msg, data)
    end
    if matches[1] == 'قوانین' then
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested group rules")
      return get_rules(msg, data)
    end
    if matches[1] == 'تنظیم' then
      if matches[2] == 'قوانین' then
        rules = matches[3]
        local target = msg.to.id
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] has changed group rules to ["..matches[3].."]")
        return set_rulesmod(msg, data, target)
      end
      if matches[2] == 'درباره' then
        local data = load_data(_config.moderation.data)
        local target = msg.to.id
        local about = matches[3]
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] has changed group description to ["..matches[3].."]")
        return set_descriptionmod(msg, data, target, about)
      end
    end
end
--Begin chat settings
    if matches[1] == 'قفل' then
      local target = msg.to.id
		if matches[2] == 'نام' then
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked name ")
			return lock_group_namemod(msg, data, target)
		end
		if matches[2] == 'اعضا' then
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked member ")
			return lock_group_membermod(msg, data, target)
		end
		if matches[2] == 'اسپم' then
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked flood ")
			return lock_group_floodmod(msg, data, target)
		end
		if matches[2] == 'عربی' then
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked arabic ")
			return lock_group_arabic(msg, data, target)
		end
		if matches[2] == 'ربات' then
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked bots ")
			return lock_group_bots(msg, data, target)
		end
		if matches[2] == 'خروج' then
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked leaving ")
			return lock_group_leave(msg, data, target)
		end
		if matches[2] == 'لینک' then
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked link posting ")
			return lock_group_links(msg, data, target)
		end
		if matches[2]:lower() == 'rtl' then
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked rtl chars. in names")
			return lock_group_rtl(msg, data, target)
		end
		if matches[2] == 'استیکر' then
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked sticker posting")
			return lock_group_sticker(msg, data, target)
		end
		if matches[2] == 'مخاطب' then
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked contact posting")
			return lock_group_contacts(msg, data, target)
		end
	end
    if matches[1] == 'باز کردن' then
		local target = msg.to.id
		if matches[2] == 'نام' then
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked name ")
			return unlock_group_namemod(msg, data, target)
		end
		if matches[2] == 'اعضا' then
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked member ")
			return unlock_group_membermod(msg, data, target)
		end
		if matches[2] == 'عکس' then
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked photo ")
			return unlock_group_photomod(msg, data, target)
		end
		if matches[2] == 'اسپم' then
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked flood ")
			return unlock_group_floodmod(msg, data, target)
		end
		if matches[2] == 'عربی' then
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked arabic ")
			return unlock_group_arabic(msg, data, target)
		end
		if matches[2] == 'ربات' then
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked bots ")
			return unlock_group_bots(msg, data, target)
		end
		if matches[2] == 'خروج' then
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked leaving ")
			return unlock_group_leave(msg, data, target)
		end
		if matches[2] == 'لینک' then
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked link posting")
			return unlock_group_links(msg, data, target)
		end
		if matches[2]:lower() == 'rtl' then
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked RTL chars. in names")
			return unlock_group_rtl(msg, data, target)
		end
		if matches[2] == 'استیکر' then
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked sticker posting")
			return unlock_group_sticker(msg, data, target)
		end
		if matches[2] == 'مخاطب' then
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked contact posting")
			return unlock_group_contacts(msg, data, target)
		end
	end
	--End chat settings
	
  --Begin Chat mutes

  if matches[1] == 'میوت' and is_owner(msg) then
			local chat_id = msg.to.id
			if matches[2] == 'صدا' then
			local msg_type = 'Audio'
				if not is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set group to: mute "..msg_type)
					mute(chat_id, msg_type)
					return "Group "..matches[2].." has been muted"
				else
					return "Group mute "..matches[2].." is already on"
				end
			end
			if matches[2] == 'عکس' then
			local msg_type = 'Photo'
				if not is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set group to: mute "..msg_type)
					mute(chat_id, msg_type)
					return "Group "..matches[2].." has been muted"
				else
					return "Group mute "..matches[2].." is already on"
				end
			end
			if matches[2] == 'فیلم' then
			local msg_type = 'Video'
				if not is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set group to: mute "..msg_type)
					mute(chat_id, msg_type)
					return "Group "..matches[2].." has been muted"
				else
					return "Group mute "..matches[2].." is already on"
				end
			end
			if matches[2] == 'گیف' then
			local msg_type = 'Gifs'
				if not is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set group to: mute "..msg_type)
					mute(chat_id, msg_type)
					return msg_type.." have been muted"
				else
					return "Group mute "..msg_type.." is already on"
				end
			end
			if matches[2] == 'فایل' then
			local msg_type = 'Documents'
				if not is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set group to: mute "..msg_type)
					mute(chat_id, msg_type)
					return msg_type.." میوت شد"
				else
					return "میوت گروه "..msg_type.." فعال بوده است"
				end
			end
			if matches[2] == 'متن' then
			local msg_type = 'Text'
				if not is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set group to: mute "..msg_type)
					mute(chat_id, msg_type)
					return "متن در گروه میوت شد"
				else
					return "متن در گروه میوت بوده است"
				end
			end
			if matches[2] == 'همه' then
			local msg_type = 'All'
				if not is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set group to: mute "..msg_type)
					mute(chat_id, msg_type)
					return "میوت "..msg_type.." فعال شد"
				else
					return "میوت "..msg_type.." روشن بوده است"
				end
			end
		end
		if matches[1] == 'آنمیوت' and is_owner(msg) then
			local chat_id = msg.to.id
			if matches[2] == 'صدا' then
			local msg_type = 'Audio'
				if is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set group to: unmute "..msg_type)
					unmute(chat_id, msg_type)
					return "گروه "..msg_type.." آنمیوت شد"
				else
					return "میوت گروه "..msg_type.." غیرفعال بوده است"
				end
			end
			if matches[2] == 'عکس' then
			local msg_type = 'Photo'
				if is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set group to: unmute "..msg_type)
					unmute(chat_id, msg_type)
					return "گروه "..msg_type.." آنمیوت شد"
				else
					return "میوت گروه "..msg_type.." غیرفعال بوده است"
				end
			end
			if matches[2] == 'فیلم' then
			local msg_type = 'Video'
				if is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set group to: unmute "..msg_type)
					unmute(chat_id, msg_type)
					return "گروه "..msg_type.." آنمیوت شد"
				else
					return "میوت گروه "..msg_type.." غیرفعال بوده است"
				end
			end
			if matches[2] == 'گیف' then
			local msg_type = 'Gifs'
				if is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set group to: unmute "..msg_type)
					unmute(chat_id, msg_type)
					return msg_type.." آنمیوت شد"
				else
					return "میوت "..msg_type.." خاموش بوده است"
				end
			end
			if matches[2] == 'فایل' then
			local msg_type = 'Documents'
				if is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set group to: unmute "..msg_type)
					unmute(chat_id, msg_type)
					return msg_type.." آنمیوت شد"
				else
					return "میوت "..msg_type.." خاموش بوده است"
				end
			end
			if matches[2] == 'متن' then
			local msg_type = 'Text'
				if is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set group to: unmute message")
					unmute(chat_id, msg_type)
					return "متن در گروه میوت شد"
				else
					return "متن در گروه آنمیوت بود"
				end
			end
			if matches[2] == 'همه' then
			local msg_type = 'All'
				if is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set group to: unmute "..msg_type)
					unmute(chat_id, msg_type)
					return "میوت "..msg_type.." غیرفعال شد"
				else
					return "میوت "..msg_type.." غیرفعال بوده است"
				end
			end
		end

	--Begin chat muteuser
		if matches[1] == "میوت کردن" and is_momod(msg) then
		local chat_id = msg.to.id
		local hash = "mute_user"..chat_id
		local user_id = ""
			if type(msg.reply_id) ~= "nil" then
				local receiver = get_receiver(msg)
				local get_cmd = "mute_user"
				get_message(msg.reply_id, mute_user_callback, {receiver = receiver, get_cmd = get_cmd})
			elseif matches[1] == "میوت کردن" and string.match(matches[2], '^%d+$') then
				local user_id = matches[2]
				if is_muted_user(chat_id, user_id) then
					mute_user(chat_id, user_id)
					return "["..user_id.."] از لیست میوت حذف شد"
				else
					unmute_user(chat_id, user_id)
					return "["..user_id.."] به لیست میوت اضافه شد"
				end
			elseif matches[1] == "میوت کردن" and not string.match(matches[2], '^%d+$') then
				local receiver = get_receiver(msg)
				local get_cmd = "mute_user"
				local username = matches[2]
				local username = string.gsub(matches[2], '@', '')
				resolve_username(username, callback_mute_res, {receiver = receiver, get_cmd = get_cmd})
			end
		end

  --End Chat muteuser
  	if matches[1] == "لیست میوت" and is_momod(msg) then
		local chat_id = msg.to.id
		if not has_mutes(chat_id) then
			set_mutes(chat_id)
			return mutes_list(chat_id)
		end
		savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup muteslist")
		return mutes_list(chat_id)
	end
	if matches[1] == "لیست میوت" and is_momod(msg) then
		local chat_id = msg.to.id
		savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup mutelist")
		return muted_user_list(chat_id)
	end

    if matches[1] == 'تنظیمات' and is_momod(msg) then
      local target = msg.to.id
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested group settings ")
      return show_group_settingsmod(msg, target)
    end

 if matches[1] == 'public' and is_momod(msg) then
    local target = msg.to.id
    if matches[2] == 'yes' then
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] set group to: public")
      return set_public_membermod(msg, data, target)
    end
    if matches[2] == 'no' then
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] set group to: not public")
      return unset_public_membermod(msg, data, target)
    end
  end

if msg.to.type == 'chat' then
    if matches[1] == 'لینک جدید' and not is_realm(msg) then
      if not is_momod(msg) then
        return "فقط برای مدیران!"
      end
      local function callback (extra , success, result)
        local receiver = 'chat#'..msg.to.id
        if success == 0 then
           return send_large_msg(receiver, 'خطا!ربات سازنده گروه نیست')
        end
        send_large_msg(receiver, "لینک جدید ساخته شد")
        data[tostring(msg.to.id)]['settings']['set_link'] = result
        save_data(_config.moderation.data, data)
      end
      local receiver = 'chat#'..msg.to.id
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] revoked group link ")
      return export_chat_link(receiver, callback, true)
    end
    if matches[1] == 'لینک' then
      if not is_momod(msg) then
        return "فقط برای مدیران!"
      end
      local group_link = data[tostring(msg.to.id)]['settings']['set_link']
      if not group_link then
        return "ابتدا از دستور لینک جدید استفاده کنید!"
      end
       savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested group link ["..group_link.."]")
      return " :🔱لینک گروه:  "..group_link
    end
    if matches[1] == 'دارنده' and matches[2] then
      if not is_owner(msg) then
        return "فقط مختص سازنده"
      end
      data[tostring(msg.to.id)]['set_owner'] = matches[2]
      save_data(_config.moderation.data, data)
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] set ["..matches[2].."] as owner")
      local text = matches[2].." سازنده گروه شد"
      return text
    end
    if matches[1] == 'دارنده' and not matches[2] then
      if not is_owner(msg) then
        return "فقط مختص سازنده گروه!"
      end
      if type(msg.reply_id)~="nil" then
          msgr = get_message(msg.reply_id, setowner_by_reply, false)
      end
    end
end
    if matches[1] == 'صاحب' then
      local group_owner = data[tostring(msg.to.id)]['set_owner']
      if not group_owner then
        return "متاسفانه سازنده ای در گروه نیست از دستور مدیرو بیار استفاده کنید تا مدیر سازنده ای را به گروه اضافه کند."
      end
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] used /owner")
      return "سازنده گروه: ["..group_owner..']'
    end
    if matches[1] == 'تنظیم دارنده' then
      local receiver = "chat#id"..matches[2]
      if not is_admin1(msg) then
        return "فقط برای ادمین"
      end
      data[tostring(matches[2])]['set_owner'] = matches[3]
      save_data(_config.moderation.data, data)
      local text = matches[3].." سازنده گروه شد"
      send_large_msg(receiver, text)
      return
    end
    if matches[1] == 'حساسیت' then
      if not is_momod(msg) then
        return "فقط برای مدیران!"
      end
      if tonumber(matches[2]) < 5 or tonumber(matches[2]) > 20 then
        return "اعداد مجاز بین 5 تا 20 میباشند."
      end
      local flood_max = matches[2]
      data[tostring(msg.to.id)]['settings']['flood_msg_max'] = flood_max
      save_data(_config.moderation.data, data)
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] set flood to ["..matches[2].."]")
      return 'حساسیت گروه تغییر کرد به '..matches[2]
    end

if msg.to.type == 'chat' then
    if matches[1] == 'پاک کردن' then
      if not is_owner(msg) then
        return "پاک کردن فقط برای سازنده گروه است"
      end
      if matches[2] == 'اعضا' then
        if not is_owner(msg) then
          return "فقط مدیران میتوانند اعضا را پاک کنند!"
        end
        local receiver = get_receiver(msg)
        chat_info(receiver, cleanmember, {receiver=receiver})
      end
	 end
      if matches[2] == 'لیست مدیران' then
        if next(data[tostring(msg.to.id)]['moderators']) == nil then --fix way
          return 'مدیری در گروه نیست.'
        end
        local message = '\nلیست مدیران ' .. string.gsub(msg.to.print_name, '_', ' ') .. ':\n'
        for k,v in pairs(data[tostring(msg.to.id)]['moderators']) do
          data[tostring(msg.to.id)]['moderators'][tostring(k)] = nil
          save_data(_config.moderation.data, data)
        end
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] cleaned modlist")
      end
      if matches[2] == 'قوانین' then
        local data_cat = 'rules'
        data[tostring(msg.to.id)][data_cat] = nil
        save_data(_config.moderation.data, data)
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] cleaned rules")
      end
      if matches[2] == 'درباره' then
        local data_cat = 'description'
        data[tostring(msg.to.id)][data_cat] = nil
        save_data(_config.moderation.data, data)
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] cleaned about")
      end
    end
if msg.to.type == 'chat' then
    if matches[1] == 'خراب کردن' and matches[2] == 'گروه' then
      if not is_admin1(msg) then
          return nil
      end
      if not is_realm(msg) then
          local receiver = get_receiver(msg)
          return modrem(msg),
          print("درحال بستن گروه..."),
          chat_info(receiver, killchat, {receiver=receiver})
      else
          return 'این یک ریلم است'
      end
   end
    if matches[1] == 'خراب کردن' and matches[2] == 'ریلم' then
     if not is_admin1(msg) then
         return nil
     end
     if not is_group(msg) then
        local receiver = get_receiver(msg)
        return realmrem(msg),
        print("درحال بستن ریلم..."),
        chat_info(receiver, killrealm, {receiver=receiver})
     else
        return 'این یک گروه است'
     end
   end
    if matches[1] == 'راهنما' then
      if not is_momod(msg) or is_realm(msg) then
        return
      end
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] Used /help")
      return help()
    end
    if matches[1] == 'ایدی' then 
      local cbres_extra = {
        chatid = msg.to.id
      }
      local username = matches[2]
      local username = username:gsub("@","")
      resolve_username(username,  callbackres, cbres_extra)
	  return
    end
    if matches[1] == 'kickinactive' then
      --send_large_msg('chat#id'..msg.to.id, 'I\'m in matches[1]')
	    if not is_momod(msg) then
	      return 'فقط برای مدیران!'
	    end
	    local num = 1
	    if matches[2] then
	        num = matches[2]
	    end
	    local chat_id = msg.to.id
	    local receiver = get_receiver(msg)
      return kick_inactive(chat_id, num, receiver)
    end
   end
  end
end

local function pre_process(msg)
  if not msg.text and msg.media then
    msg.text = '['..msg.media.type..']'
  end
  return msg
end

return {
  patterns = {
  "^(اضافه)$",
  "^(اضافه) (ریلم)$",
  "^(حذف)$",
  "^(حذف) (ریلم)$",
  "^(قوانین)$",
  "^(درباره)$",
  "^(تنظیم نام) (.*)$",
  "^(تنظیم عکس)$",
  "^(ترفیع) (.*)$",
  "^(ترفیع)",
  "^(راهنما)$",
  "^(پاک کردن) (.*)$",
  "^(خراب کردن) (گروه)$",
  "^(خراب کردن) (ریلم)$",
  "^(تنزل) (.*)$",
  "^(تنزل)",
  "^(تنظیم) ([^%s]+) (.*)$",
  "^(قفل) (.*)$",
  "^(دارنده) (%d+)$",
  "^(دارنده)",
  "^(صاحب)$",
  "^(ایدی) (.*)$",
  "^(تنظیم دارنده) (%d+) (%d+)$",-- (group id) (owner id)
  "^(باز کردن) (.*)$",
  "^(حساسیت) (%d+)$",
  "^(تنظیمات)$",
  "^[#!/](public) (.*)$",
  "^(لیست مدیران)$",
  "^(لینک جدید)$",
  "^(لینک)$",
  "^([میوت) ([^%s]+)$",
  "^(آنمیوت) ([^%s]+)$",
  "^(میوت کردن)$",
  "^(میوت کردن) (.*)$",
  "^(لیست میوت)$",
  "^(لیست میوت)$",
  "^(kickinactive)$",
  "^[#!/](kickinactive) (%d+)$",
  "%[(document)%]",
  "%[(photo)%]",
  "%[(video)%]",
  "%[(audio)%]",
  "^!!tgservice (.+)$",
  },
  run = run,
  pre_process = pre_process
}
end
