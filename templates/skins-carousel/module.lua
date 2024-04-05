local function trim(s)
  return s:match("^%s*(.-)%s*$")
end

local function duplicateTable(table, multiplier)
  local duplicatedTable = {}
  for i = 1, multiplier do
      for _, v in ipairs(table) do
          duplicatedTable[#duplicatedTable + 1] = v
      end
  end
  return duplicatedTable
end

local function moveFirstItemsToEnd(tbl, x)
  local movedItems = {}
  
  for i = 1, x do
      movedItems[#movedItems + 1] = tbl[i]
  end
  
  for i = 1, x do
      table.remove(tbl, 1)
  end
  
  for _, v in ipairs(movedItems) do
      tbl[#tbl + 1] = v
  end
  
  return tbl
end

local p = {}

function p.main(frame)
local args = require('Dev:Arguments').getArgs(frame)

local skinsT = {}
local namesT = {}
local descriptionsT = {}

local i = 1
  while true do
      local skin = args['skin ' .. i]
  if not skin then break end
      
      local name = args['nome ' .. i]
      local description = args['descrição ' .. i]
      
      if skin then table.insert(skinsT, { i = i, skin = skin }) end
      if name then table.insert(namesT, { i = i, name = name }) end
      if description then table.insert(descriptionsT, { i = i, description = description }) end
      
      i = i + 1
  end
  
  if #skinsT == 2 then skinsT = duplicateTable(skinsT, 3) end
if #skinsT >= 3 and #skinsT <= 4 then skinsT = duplicateTable(skinsT, 2) end
  
  local middle = math.floor(#skinsT / 2)
local classesTemplate = {
  [middle - 2] = "slider__item--pos-prev",
  [middle - 1] = "slider__item--prev",
  [middle] = "slider__item--act",
  [middle + 1] = "slider__item--next",
  [middle + 2] = "slider__item--pos-next"
}

skinsT = moveFirstItemsToEnd(skinsT, math.ceil(#skinsT / 2))

local skins = ""
local names = ""
local descriptions = ""

for i, skin in ipairs(skinsT) do
    skins = skins .. string.format('<li class="%s" data-index="%s">[[Arquivo:%s]]</li>', classesTemplate[i - 1] or "slider__item--outside", skin.i, skin.skin)
end

for i, name in ipairs(namesT) do
    names = names .. string.format('<span class="skins-carousel__name %s" data-index="%s">%s</span>', name.i == skinsT[middle + 1].i and "--active" or "", name.i, trim(name.name))
end

for i, description in ipairs(descriptionsT) do
    descriptions = descriptions .. string.format('<p class="skins-carousel__description %s" data-index="%s">%s</p>', description.i == skinsT[middle + 1].i and "--active" or "", description.i, string.gsub(trim(description.description), "\\n", "<br>"))
end

return string.format('<div class="skins-carousel__name-container">%s</div><ul class="skins-carousel__slider">%s</ul><div class="skins-carousel__description-container">%s</div>', names, skins, descriptions)
end

function p.mobile(frame)
local args = require('Dev:Arguments').getArgs(frame)

local data = {}

local i = 1
  while true do
      local skin = args['skin ' .. i]
  if not skin then break end
      
      local name = args['nome ' .. i]
      local description = args['descrição ' .. i]
      
      table.insert(data, { skin = skin, name = name or "", description = description or "" })
      
      i = i + 1
  end

local res = {}

for j=1, #data do
    local item = data[j]
    
    if item then
        table.insert(res, string.format('<li><span class="mobile--skins-carousel__name" data-content="%s"></span><div class="mobile--skins-carousel__image">[[Arquivo:%s]]</div><p class="mobile--skins-carousel__description">%s</p></li>', item.name, item.skin, item.description))
    end
end

return table.concat(res, "")
end

return p