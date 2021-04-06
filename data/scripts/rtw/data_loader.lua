-- usage:
-- local data_loader = require("scripts/data_loader")
-- data_loader.load_data("scripts/data.lua")

local data_loader = {}

function data_loader.load_data(scripts/rtw/ranked_equipment.lua)
  local weapon_classes = {}
  local weapons = {}
 
  assert(sol.file.exists(path), "Error: data file not found: "..path)
 
  --create environment for loading data
  local env = setmetatable({}, {__index = function(self, data_type_name) --default function to handle unknown data entries
    print("WARNING: Unknown data entry: "..tostring(data_type_name))
    return function(properties) end --return dummy function to prevent error because return value will be called
  end})
 
  function env.weapon_class(properties)
    local id = properties.id
    assert(type(id)=="string", "Bad weapon_class property 'id' (string expected)")
    assert(not weapon_classes[id], "Bad weapon_class property 'id', must be unique value: "..id)
   
    local weapon_class_entry = {} --create new weapon entry
    for k,v in pairs(properties) do weapon_class_entry[k] = v end --copy properties to new weapon entry
    weapon_classes[id] = weapon_class_entry
  end
 
  function env.weapon(properties)
    local id = properties.id
    assert(type(id)=="string", "Bad weapon property 'id' (string expected)")
    assert(not weapons[id], "Bad weapon property 'id', must be unique value: "..id)
   
    local weapon_entry = {} --create new weapon entry
    for k,v in pairs(properties) do weapon_entry[k] = v end --copy properties to new weapon entry
    weapons[id] = weapon_entry
  end
 
  --load the data file
  local chunk = sol.main.load_file(path)
  assert(chunk, "Error: unable to read file: "..path)
  setfenv(chunk, env)
  chunk()
 
  --put loaded data into a new table and return it
  return {
    weapon_classes = weapon_classes,
    weapons = weapons,
  }
end

return data_loader