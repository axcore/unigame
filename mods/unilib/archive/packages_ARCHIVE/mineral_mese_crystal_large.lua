---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("underch:mese_crystal", {
    description = "Mese Crystal",
    tiles = {"underch_mese_crystal.png"},
    groups = {cracky = 2},
    paramtype = "light",
    paramtype2 = "facedir",
    drawtype = "mesh",
    mesh = "underch_crystal.obj",
    light_source = 4,
    is_ground_content = false,
    sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
    output = "default:mese_crystal 2",
    type = "shapeless",
    recipe = {"underch:mese_crystal"}
})
]]--
