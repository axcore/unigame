---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- final_repair.lua
--      Set up tool repair
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Set up tool repair
---------------------------------------------------------------------------------------------------

if not unilib.setting.mtgame_tweak_flag then

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
