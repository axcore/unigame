---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- final_fuel.lua
--      Set up tree trunks as fuel
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Set up tree trunks as fuel
---------------------------------------------------------------------------------------------------

-- Adapted from default/crafting.lua

-- Support use of tree/wood groups
-- Burn times for wooden items depend on wood density (see the tables in ../lib/system/global.lua).
--      These values represent the burntimes for an apple tree
unilib.register_craft({
    type = "fuel",
    recipe = "group:tree",
    burntime = 30,
})

unilib.register_craft({
    type = "fuel",
    recipe = "group:wood",
    burntime = 7,
})

unilib.register_craft({
    type = "fuel",
    recipe = "group:leaves",
    burntime = 4,
})

unilib.register_craft({
    type = "fuel",
    recipe = "group:sapling",
    burntime = 5,
})
