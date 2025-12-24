--Aliases

minetest.register_alias("mesecons_gamecompat:chest", "unilib:container_chest_ordinary")
minetest.register_alias("mesecons_gamecompat:chest_locked", "unilib:container_chest_ordinary_locked")
minetest.register_alias("mesecons_gamecompat:coalblock", "unilib:mineral_coal_block")
minetest.register_alias("mesecons_gamecompat:cobble", "unilib:stone_ordinary_cobble")
minetest.register_alias("mesecons_gamecompat:glass", "unilib:glass_ordinary")
minetest.register_alias("mesecons_gamecompat:lava_source", "unilib:liquid_lava_ordinary_source")
minetest.register_alias("mesecons_gamecompat:mese", "unilib:mineral_mese_block")
minetest.register_alias("mesecons_gamecompat:mese_crystal", "unilib:mineral_mese_crystal")
minetest.register_alias("mesecons_gamecompat:mese_crystal_fragment", "unilib:mineral_mese_crystal_fragment")
minetest.register_alias("mesecons_gamecompat:obsidian_glass", "unilib:glass_obsidian")
minetest.register_alias("mesecons_gamecompat:stone", "unilib:stone_ordinary")
minetest.register_alias("mesecons_gamecompat:steel_ingot", "unilib:metal_steel_ingot")
minetest.register_alias("mesecons_gamecompat:steelblock", "unilib:metal_steel_block")
minetest.register_alias("mesecons_gamecompat:torch", "unilib:torch_ordinary")

if minetest.get_modpath("dye") then
    for _, color in ipairs(mesecon.dye_colors) do
        minetest.register_alias("mesecons_gamecompat:dye_" .. color, "unilib:dye_" .. color)
    end
end

-- Sounds

mesecon.node_sound.default = default.node_sound_defaults()
mesecon.node_sound.glass = default.node_sound_glass_defaults()
mesecon.node_sound.leaves = default.node_sound_leaves_defaults()
mesecon.node_sound.stone = default.node_sound_stone_defaults()
mesecon.node_sound.wood = default.node_sound_wood_defaults()

if minetest.get_modpath("fire") then
    mesecon.sound_name.fire = "unilib_fire"
end

if minetest.get_modpath("tnt") then
    mesecon.sound_name.explode = "unilib_tnt_explode"
end

-- Textures

mesecon.texture.steel_block = "unilib_metal_steel_block.png"

-- MVPS stoppers

if minetest.get_modpath("mesecons_mvps") then
    -- All of the locked and internal nodes (imported from) minetest_game
    for _, name in ipairs({
        "unilib:container_chest_ordinary_locked",
        "unilib:container_chest_ordinary_locked_open",
--      "doors:door_steel_b_1",
--      "doors:door_steel_b_2",
--      "doors:door_steel_t_1",
--      "doors:door_steel_t_2",
        "unilib:door_steel_closed_left",
        "unilib:door_steel_closed_right",
        "unilib:door_steel_open_left",
        "unilib:door_steel_open_right",
        "unilib:door_hidden",
        "unilib:trapdoor_steel_closed",
        "unilib:trapdoor_steel_open",
        "unilib:bed_ordinary_bottom",
        "unilib:bed_ordinary_top",
        "unilib:bed_fancy_bottom",
        "unilib:bed_fancy_top",
        "unilib:door_steel_bar_closed_left",
        "unilib:door_steel_bar_closed_right",
        "unilib:door_steel_bar_open_left",
        "unilib:door_steel_bar_open_right",
        "unilib:trapdoor_steel_bar_closed",
        "unilib:trapdoor_steel_bar_open",
    }) do
        mesecon.register_mvps_stopper(name)
    end
end

-- Code in mesecons_extrawires overrides the mese block, but unilib must be loaded AFTER mesecons
--      (otherwise unilib can't be used with technic and pipeworks)
-- Get around the problem by defining unilib's block here; unilib's "mineral_mese" package will
--      check that the block already exists, before trying to register it. (If it is already
--      registered, then it is overriden again to apply unilib sounds)

local S = minetest.get_translator(minetest.get_current_modname())

minetest.register_node(":unilib:mineral_mese_block", {
    description = S("Mese Block"),
    tiles = {"unilib_mineral_mese_block.png"},
    groups = {cracky = 1, level = 2},
	sounds = default.node_sound_stone_defaults(),

    light_source = 3,
    paramtype = "light",
})
