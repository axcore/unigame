---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights_extras
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
do
    local tile = "default_sandstone_block.png"
    if morelights.game == "mineclone2" then
        tile = "mcl_core_sandstone_smooth.png"
    elseif morelights.game == "hades_revisited" then
        tile = "default_sandstone.png"
    end

    minetest.register_node("morelights_extras:sandstone_block", {
        description = S("Sandstone Block Light"),
        tiles = {tile .. "^morelights_extras_blocklight.png"},
        paramtype = "light",
        light_source = 12,
        groups = {cracky = 2, oddly_breakable_by_hand = 3, handy = 1},
        _mcl_hardness = 0.3,
        sounds = morelights.sounds.glass
    })
end
minetest.register_craft({
    output = "morelights_extras:sandstone_block",
    recipe = {
        {"", a.glass_pane, ""},
        {"", "morelights:bulb", ""},
        {"", a.sandstone_block, ""}
    }
})
]]--
