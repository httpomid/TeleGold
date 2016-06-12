local function run(msg, matches)
  if matches[1] == 'بگو' and matches[2] then
   return matches[2]
   end
end
return {
patterns = {
"^(بگو) (.*)$",
},
run = run,
}
