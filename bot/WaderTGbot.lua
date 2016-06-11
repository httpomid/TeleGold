package.path = package.path .. ';.luarocks/share/lua/5.2/?.lua'
  ..';.luarocks/share/lua/5.2/?/init.lua'
package.cpath = package.cpath .. ';.luarocks/lib/lua/5.2/?.so'

require("./bot/utils")

local f = assert(io.popen('/usr/bin/git describe --tags', 'r'))
VERSION = assert(f:read('*a'))
f:close()

-- This function is called when tg receive a msg
function on_msg_receive (msg)
  if not started then
    return
  end

  msg = backward_msg_format(msg)

  local receiver = get_receiver(msg)
  print(receiver)
  --vardump(msg)
  --vardump(msg)
  msg = pre_process_service_msg(msg)
  if msg_valid(msg) then
    msg = pre_process_msg(msg)
    if msg then
      match_plugins(msg)
      if redis:get("bot:markread") then
        if redis:get("bot:markread") == "on" then
          mark_read(receiver, ok_cb, false)
        end
      end
    end
  end
end

function ok_cb(extra, success, result)

end

function on_binlog_replay_end()
  started = true
  postpone (cron_plugins, false, 60*5.0)
  -- See plugins/isup.lua as an example for cron

  _config = load_config()

  -- load plugins
  plugins = {}
  load_plugins()
end

function msg_valid(msg)
  -- Don't process outgoing messages
  if msg.out then
    print('\27[36mNot valid: msg from us\27[39m')
    return false
  end

  -- Before bot was started
  if msg.date < os.time() - 5 then
    print('\27[36mNot valid: old msg\27[39m')
    return false
  end

  if msg.unread == 0 then
    print('\27[36mNot valid: readed\27[39m')
    return false
  end

  if not msg.to.id then
    print('\27[36mNot valid: To id not provided\27[39m')
    return false
  end

  if not msg.from.id then
    print('\27[36mNot valid: From id not provided\27[39m')
    return false
  end

  if msg.from.id == our_id then
    print('\27[36mNot valid: Msg from our id\27[39m')
    return false
  end

  if msg.to.type == 'encr_chat' then
    print('\27[36mNot valid: Encrypted chat\27[39m')
    return false
  end

  if msg.from.id == 777000 then
    --send_large_msg(*group id*, msg.text) *login code will be sent to GroupID*
    return false
  end

  return true
end

--
function pre_process_service_msg(msg)
   if msg.service then
      local action = msg.action or {type=""}
      -- Double ! to discriminate of normal actions
      msg.text = "!!tgservice " .. action.type

      -- wipe the data to allow the bot to read service messages
      if msg.out then
         msg.out = false
      end
      if msg.from.id == our_id then
         msg.from.id = 0
      end
   end
   return msg
end

-- Apply plugin.pre_process function
function pre_process_msg(msg)
  for name,plugin in pairs(plugins) do
    if plugin.pre_process and msg then
      print('Preprocess', name)
      msg = plugin.pre_process(msg)
    end
  end
  return msg
end

-- Go over enabled plugins patterns.
function match_plugins(msg)
  for name, plugin in pairs(plugins) do
    match_plugin(plugin, name, msg)
  end
end

-- Check if plugin is on _config.disabled_plugin_on_chat table
local function is_plugin_disabled_on_chat(plugin_name, receiver)
  local disabled_chats = _config.disabled_plugin_on_chat
  -- Table exists and chat has disabled plugins
  if disabled_chats and disabled_chats[receiver] then
    -- Checks if plugin is disabled on this chat
    for disabled_plugin,disabled in pairs(disabled_chats[receiver]) do
      if disabled_plugin == plugin_name and disabled then
        local warning = 'Plugin '..disabled_plugin..' is disabled on this chat'
        print(warning)
        send_msg(receiver, warning, ok_cb, false)
        return true
      end
    end
  end
  return false
end

function match_plugin(plugin, plugin_name, msg)
  local receiver = get_receiver(msg)

  -- Go over patterns. If one matches it's enough.
  for k, pattern in pairs(plugin.patterns) do
    local matches = match_pattern(pattern, msg.text)
    if matches then
      print("msg matches: ", pattern)

      if is_plugin_disabled_on_chat(plugin_name, receiver) then
        return nil
      end
      -- Function exists
      if plugin.run then
        -- If plugin is for privileged users only
        if not warns_user_not_allowed(plugin, msg) then
          local result = plugin.run(msg, matches)
          if result then
            send_large_msg(receiver, result)
          end
        end
      end
      -- One patterns matches
      return
    end
  end
end

-- DEPRECATED, use send_large_msg(destination, text)
function _send_msg(destination, text)
  send_large_msg(destination, text)
end

-- Save the content of _config to config.lua
function save_config( )
  serialize_to_file(_config, './data/config.lua')
  print ('saved config into ./data/config.lua')
end

-- Returns the config from config.lua file.
-- If file doesn't exist, create it.
function load_config( )
  local f = io.open('./data/config.lua', "r")
  -- If config.lua doesn't exist
  if not f then
    print ("Created new config file: data/config.lua")
    create_config()
  else
    f:close()
  end
  local config = loadfile ("./data/config.lua")()
  for v,user in pairs(config.sudo_users) do
    print("Sudo user: " .. user)
  end
  return config
end

-- Create a basic config.json file and saves it.
function create_config( )
  -- A simple config with basic plugins and ourselves as privileged user
  config = {
    enabled_plugins = {
	"admin",
    "onservice",
    "inrealm",
    "ingroup",
    "inpm",
    "banhammer",
    "stats",
    "anti_spam",
    "owners",
    "arabic_lock",
    "set",
    "get",
    "broadcast",
    "invite",
    "all",
    "me",
    "leave_ban",
	"supergroup",
	"whitelist",
	"msg_checks",
	"plugins",
	"badword",
	"bot-lock",
	"clash_of_clan",
	"cleaner",
	"infull",
	"instagram",
	"linkpv",
	"lock-forward",
	"photo2sticker",
	"sticker2photo",
	"text2photo",
	"text2sticker",
	"server",
	"voice",
	"wai"
    },
    sudo_users = {194849320,97648706,tonumber(our_id)},--Sudo users
    moderation = {data = 'data/moderation.json'},
    about_text = [[WaderTG v4
An advanced administration bot based on TG-CLI written in Lua

Admins
@mohammadsdi4799
@iphonei
@Amin1779
@Oo_hamed_ice_fuckeram_oO

Our channels
@WaderTGTeam

thankyou for all admins bot WaderTG
]],
    help_text_realm = [[
Realm Commands:

!creategroup [Name]
Create a group

!createrealm [Name]
Create a realm

!setname [Name]
Set realm name

!setabout [group|sgroup] [GroupID] [Text]
Set a group's about text

!setrules [GroupID] [Text]
Set a group's rules

!lock [GroupID] [setting]
Lock a group's setting

!unlock [GroupID] [setting]
Unock a group's setting

!settings [group|sgroup] [GroupID]
Set settings for GroupID

!wholist
Get a list of members in group/realm

!who
Get a file of members in group/realm

!type
Get group type

!kill chat [GroupID]
Kick all memebers and delete group

!kill realm [RealmID]
Kick all members and delete realm

!addadmin [id|username]
Promote an admin by id OR username *Sudo only

!removeadmin [id|username]
Demote an admin by id OR username *Sudo only

!list groups
Get a list of all groups

!list realms
Get a list of all realms

!support
Promote user to support

!-support
Demote user from support

!log
Get a logfile of current group or realm

!broadcast [text]
!broadcast Hello !
Send text to all groups
Only sudo users can run this command

!bc [group_id] [text]
!bc 123456789 Hello !
This command will send text to [group_id]


**You can use "#", "!", or "/" to begin all commands


*Only admins and sudo can add bots in group


*Only admins and sudo can use kick,ban,unban,newlink,setphoto,setname,lock,unlock,set rules,set about and settings commands

*Only admins and sudo can use res, setowner, commands

channel:@WaderTGTeam
]],
    help_text = [[
Commands list :

!kick [username|id]
You can also do it by reply

!ban [ username|id]
You can also do it by reply

!unban [id]
You can also do it by reply

!who
Members list

!modlist
Moderators list

!promote [username]
Promote someone

!demote [username]
Demote someone

!kickme
Will kick user

!about
Group description

!setphoto
Set and locks group photo

!setname [name]
Set group name

!rules
Group rules

!id
return group id or user id

!help
Returns help text

!lock [links|flood|spam|Arabic|member|rtl|sticker|contacts|strict]
Lock group settings
*rtl: Kick user if Right To Left Char. is in name*

!unlock [links|flood|spam|Arabic|member|rtl|sticker|contacts|strict]
Unlock group settings
*rtl: Kick user if Right To Left Char. is in name*

!mute [all|audio|gifs|photo|video]
mute group message types
*If "muted" message type: user is kicked if message type is posted 

!unmute [all|audio|gifs|photo|video]
Unmute group message types
*If "unmuted" message type: user is not kicked if message type is posted 

!set rules <text>
Set <text> as rules

!set about <text>
Set <text> as about

!settings
Returns group settings

!muteslist
Returns mutes for chat

!muteuser [username]
Mute a user in chat
*user is kicked if they talk
*only owners can mute | mods and owners can unmute

!mutelist
Returns list of muted users in chat

!newlink
create/revoke your group link

!link
returns group link

!owner
returns group owner id

!setowner [id]
Will set id as owner

!setflood [value]
Set [value] as flood sensitivity

!stats
Simple message statistics

!save [value] <text>
Save <text> as [value]

!get [value]
Returns text of [value]

!clean [modlist|rules|about]
Will clear [modlist|rules|about] and set it to nil

!res [username]
returns user id
"!res @username"

!log
Returns group logs

!banlist
will return group ban list

**You can use "#", "!", or "/" to begin all commands


*Only owner and mods can add bots in group


*Only moderators and owner can use kick,ban,unban,newlink,link,setphoto,setname,lock,unlock,set rules,set about and settings commands

*Only owner can use res,setowner,promote,demote and log commands

@TeleGold_Team
]],
	help_text_super =[[

	🔱راهنمای مدیریت گروه تله گولد🔱
=======================
#settings 
⚙تنظیمات گروه
==================
#newlink 
🆕لینک جدید
==================
#link 
☑️ارسال لینک
==================
#setlink 
🔝ثبت و ذخیره لینک
==================
#linkpv
🔘ارسال لینک در پی وی
==================
#kick
⚠️برای اخراج فردی از گروه
==================
#unban
〽️خارج کردن از مسدود.
==================
#ban
❗️برای مسدود گروه فردی از گروه
==================
#banlist 
⭕️لیست مسدود شدگان
==================
#block
👍بلاک کردن شخصی از گروه
==================
#promote 
💯مدیر کردن دیگران
==================
#demote 
🌫از مدیریت برکنار میشود
==================
#setname نام گروه
🆙برای تعویض اسم گروه
==================
#setphoto
🖼برای تعویض عکس گروه
==================
#addword کلمه مورد نظر
🤐برای فیلتر کردن کلمه‌ای 
==================
#rw
😌حذف کلمه‌ای از فیلترشدها
==================
#badwords 
📜لیست فیلترشدها
==================
#clearbadwords 
📈برای حذف همه فیلتر ها
==================
#del
✂️پاک کردن یک پیام با ریپلی
==================
#public yes | no
📍شخصی یا عمومی کردن گروه
==================
#clean [rules+about+modlist+mutelist]
📎پاک کردن موارد بالا شامل: قوانین+توضیحات+لیست مدیران+افراد بیصدا شده
==================
#muteuser 
🤐باصدا و بیصدا کردن شخصی
==================
#mutelist 
📃لیست بیصداشدگان 
==================
#mute [all+audio+gifs+photo+video+text+service]
🤐بیصدا کردن و موارد بالا، یکی از موارد رو جلوی دستور بزارید.
==================
#unmute 
😌با صدا کردن موارد بالا 👆
==================
#lock [ links+flood+spam+arabic+member+rtl+sticker+contects+strict+tgservice+forward ]
🔒قفل کردن موارد بالا، یکی از موارد رو جلوی دستور بزارید.
==================
#unlock
🔓باز کردن موارد ذکر شده بالا
==================
#setflood 5 - 20
🕵حساسیت اسپم بین 5 تا 20
==================
#setrules قوانین
👥برای تنظیم قوانین
==================
#rules 
🗣نمایش قوانین
==================
#setabout 
👀تنظیم توضیحات پروفایل گروه
==================
#id
👾نمایش آیدی گروه
==================
#kickme 
🚫خروج از گروه
==================
#modlist 
📋لیست مدیران
==================
#get عدد
📇مشاهده پیام در گروه
==================
#res آیدی
📉گرفتن اطلاعات صاحب آیدی
==================
#who
📁لیست اعضای گروه
==================
#bots
🤖لیست ربات ها
==================
#admins
💂ادمین های گروه
==================
#setadmin 
👮ادمین شدن
==================
#me
🕳مشخصات خودتان
==================
#info
🖱مشخصات دقیق فرد با ریپلی و بدون ریپلی مشخصات خودتان. 
==================
برا نمایش راهنما سرویس های ربات /help2 را ارسال کنید.〽
==================
🔱 @TeleGold_Team 🔱
]],
  }
  serialize_to_file(config, './data/config.lua')
  print('saved config into ./data/config.lua')
end

function on_our_id (id)
  our_id = id
end

function on_user_update (user, what)
  --vardump (user)
end

function on_chat_update (chat, what)
  --vardump (chat)
end

function on_secret_chat_update (schat, what)
  --vardump (schat)
end

function on_get_difference_end ()
end

-- Enable plugins in config.json
function load_plugins()
  for k, v in pairs(_config.enabled_plugins) do
    print("Loading plugin", v)

    local ok, err =  pcall(function()
      local t = loadfile("plugins/"..v..'.lua')()
      plugins[v] = t
    end)

    if not ok then
      print('\27[31mError loading plugin '..v..'\27[39m')
	  print(tostring(io.popen("lua plugins/"..v..".lua"):read('*all')))
      print('\27[31m'..err..'\27[39m')
    end

  end
end

-- custom add
function load_data(filename)

	local f = io.open(filename)
	if not f then
		return {}
	end
	local s = f:read('*all')
	f:close()
	local data = JSON.decode(s)

	return data

end

function save_data(filename, data)

	local s = JSON.encode(data)
	local f = io.open(filename, 'w')
	f:write(s)
	f:close()

end


-- Call and postpone execution for cron plugins
function cron_plugins()

  for name, plugin in pairs(plugins) do
    -- Only plugins with cron function
    if plugin.cron ~= nil then
      plugin.cron()
    end
  end

  -- Called again in 2 mins
  postpone (cron_plugins, false, 120)
end

-- Start and load values
our_id = 0
now = os.time()
math.randomseed(now)
started = false
