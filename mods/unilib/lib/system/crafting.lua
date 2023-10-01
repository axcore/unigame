---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- crafting.lua
--      Set up shared craft recipes
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Tool repair
---------------------------------------------------------------------------------------------------

if not unilib.mtgame_tweak_flag then

    -- Adapted from default/crafting.lua
    unilib.register_craft({
        type = "toolrepair",
        additional_wear = -0.02,
    })

else

    -- Adapted from moreblocks/redefinitions.lua. 10% bonus instead of 2%
    unilib.register_craft({
        type = "toolrepair",
        additional_wear = -0.02,
    })

end

---------------------------------------------------------------------------------------------------
-- Tree trunks as fuel
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
