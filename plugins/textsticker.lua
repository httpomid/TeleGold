do
local function run(msg, matches)

  local lionteam = URL.escape(matches[1])
  local size = '150'
        if matches[2] == 'big' then
            size = '400'
        elseif matches[2] == 'normal' then
            size = '100'
      elseif matches[2] == '300' then
          size = '300' 
    elseif matches[2] == '200' then
          size = '200'
    elseif matches[2] == '100' then
        size = '100'
    elseif matches[2] == 'small' then
        size = '50'
    elseif matches[2] then
        size = matches[2]
        end
  local f = 'ff2e4357'
        if matches[3] == 'red' then
            f = 'FF0000'
        elseif matches[3] == 'blue' then
            f = '002BFF'
      elseif matches[3] == 'yellow' then
          f = 'F7FF00' 
    elseif matches[3] == 'black' then
          f = '000000'
    elseif matches[3] == 'orange' then
          f = 'FF8000'
    elseif matches[3] == 'lowblue' then
        f = '00FFFB'
    elseif matches[3] == 'purple' then
        f = 'CB00FD'
    elseif matches[3] == 'gray' then
        f = '929C9A'
    elseif matches[3] == 'green' then
        f = '2AFF00' 
    elseif matches[3] == 'pink' then
        f = 'FF00E8'
    elseif matches[3] then
        f = matches[3]
        end
  local url = "http://assets.imgix.net/examples/redleaf.jpg?blur=120&w=700&h=400&fit=crop&txt="..lionteam.."&txtsize="..size.."&txtclr="..f.."&txtalign=middle,center&txtfont=Futura%20Condensed%20Medium&mono=ff6598cc=?markscale=60&markalign=center%2Cdown&mark64=aHR0cDovL2xpb250ZWFtLmlyL2ltZy9zcGVjdHJlbG9nby5wbmc"
  local ext = ".webp"
  local cb_extra = {file_path=file}

--Created by LionTeam
  local receiver = get_receiver(msg)
  local file = download_to_file(url, ".webp")
  send_document(receiver, file, rmtmp_cb, cb_extra)
end

return {
  patterns = {
    "^[/#!]sticker (.+) (.+) (.+)$",
    "^[/#!]sticker (.+) (.+)$",
    "^[/#!]sticker (.+)$"
  },
  run = run
}

end
