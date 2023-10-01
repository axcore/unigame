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
    local tile = "default_stone_block.png"
    if morelights.game == "mineclone2" then
        tile = "mcl_stairs_stone_slab_top.png"
    end

    minetest.register_node("morelights_extras:stone_block", {
        description = S("Stone Block Light"),
        tiles = {tile .. "^morelights_extras_blocklight.png"},
        paramtype = "light",
        light_source = 12,
        groups = {cracky = 2, oddly_breakable_by_hand = 3, handy = 1},
        _mcl_hardness = 0.3,
        sounds = morelights.sounds.glass
    })
end
minetest.register_craft({
    output = "morelights_extras:stone_block",
    recipe = {
        {"", a.glass_pane, ""},
        {"", "morelights:bulb", ""},
        {"", a.stone_block, ""}
    }
})
]]--
