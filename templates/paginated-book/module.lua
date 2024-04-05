local function trim(s)
  return s:match("^%s*(.-)%s*$")
end

local p = {}

function p.main(frame)
local args = require('Dev:Arguments').getArgs(frame)

local res = {}

for i, page in ipairs(args) do
  table.insert(res, string.format('<p class="paginated-book__content %s">%s</p>', i == 1 and "--active" or "", string.gsub(trim(page), "\\n", "<br>")))
end

return string.format('<span class="paginated-book__page-indicator">Página 1 de %s</span><div class="paginated-book__content-container">%s</div>', #res, table.concat(res, ""))
end

function p.mobile(frame)
local args = require('Dev:Arguments').getArgs(frame)

local pages = {}

for i, page in ipairs(args) do
  table.insert(pages, string.format("%s", string.gsub(trim(page), "\\n", "<br>")))
end

return table.concat(pages, " ")
end

return p