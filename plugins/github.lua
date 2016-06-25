local function run(msg, matches)
  if matches[1]:lower() == "github>" then
    local dat = https.request("https://api.github.com/repos/"..matches[2])
    local jdat = JSON.decode(dat)
    if jdat.message then
      return "🔱 آدرس وارد شده صحیح نیست به این صورت وارد کنید:\n🔱 #github UserName/Proje"
      end
    local base = "curl 'https://codeload.github.com/"..matches[2].."/zip/master'"
    local data = io.popen(base):read('*all')
    f = io.open("file/github.zip", "w+")
    f:write(data)
    f:close()
    return send_document("chat#id"..msg.to.id, "file/github.zip", ok_cb, false)
  else
    local dat = https.request("https://api.github.com/repos/"..matches[2])
    local jdat = JSON.decode(dat)
    if jdat.message then
      return "🔱 آدرس وارد شده صحیح نیست به این صورت وارد کنید:\n🔱 #github UserName/Proje"
      end
    local res = https.request(jdat.owner.url)
    local jres = JSON.decode(res)
    send_photo_from_url("chat#id"..msg.to.id, jdat.owner.avatar_url)
    return "🔱 مشخصات اکانت:\n"
      .."🔱 نام اکانت: "..(jres.name or "-----").."\n"
      .."🔱 يوزرنيم: "..jdat.owner.login.."\n"
      .."🔱 نام شرکت: "..(jres.company or "-----").."\n"
      .."🔱 وبسايت: "..(jres.blog or "-----").."\n"
      .."🔱 ايميل: "..(jres.email or "-----").."\n"
      .."🔱 موقعيت مکاني: "..(jres.location or "-----").."\n"
      .."🔱 تعداد پروژه: "..jres.public_repos.."\n"
      .."🔱 تعداد دنبال کننده: "..jres.followers.."\n"
      .."🔱 تعداد دنبال شده: "..jres.following.."\n"
      .."🔱 تاريخ ساخت اکانت: "..jres.created_at.."\n"
      .."🔱 بيوگرافي: "..(jres.bio or "-----").."\n\n"
      .."🔱 مشخصات پروژه:\n"
      .."🔱 نام پروژه: "..jdat.name.."\n"
      .."🔱 صفحه گيتهاب: "..jdat.html_url.."\n"
      .."🔱 پکيج سورس: "..jdat.clone_url.."\n"
      .."🔱 وبلاگ پروژه: "..(jdat.homepage or "-----").."\n"
      .."🔱 تاريخ ايجاد: "..jdat.created_at.."\n"
      .."🔱 آخرين آپديت: "..(jdat.updated_at or "-----").."\n"
      .."🔱 زبان برنامه نويسي: "..(jdat.language or "-----").."\n"
      .."🔱 سايز اسکريپت: "..jdat.size.."\n"
      .."🔱 ستاره ها: "..jdat.stargazers_count.."\n"
      .."🔱 بازديدها: "..jdat.watchers_count.."\n"
      .."🔱 انشعابات: "..jdat.forks_count.."\n"
      .."🔱 مشترکين: "..jdat.subscribers_count.."\n"
      .."🔱 درباره ي پروژه:\n"..(jdat.description or "-----").."\n"
  end
end

return {
  description = "Github Informations",
  usagehtm = '<tr><td align="center">github پروژه/اکانت</td><td align="right">آدرس گیتهاب را به صورت پروژه/اکانت وارد کنید<br>مثال: github shayansoft/umbrella</td></tr>'
  ..'<tr><td align="center">github> پروژه/اکانت</td><td align="right">با استفاده از این دستور، میتوانید سورس پروژه ی مورد نظر را دانلود کنید. آدرس پروژه را مثل دستور بالا وارد کنید</td></tr>',
  usage = {
    "#github (account/proje) : مشخصات پروژه و اکانت",
    "#github> (account/proje) : دانلود سورس",
    },
  patterns = {
    "^([#/!][Gg]ithub>) (.*)",
    "^([#/!][Gg]ithub) (.*)",
    },
  run = run
}
