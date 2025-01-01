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

mesecon.node_sound.default = unilib.node_sound_defaults()
mesecon.node_sound.glass = unilib.node_sound_glass_defaults()
mesecon.node_sound.leaves = unilib.node_sound_leaves_defaults()
mesecon.node_sound.stone = unilib.node_sound_stone_defaults()
mesecon.node_sound.wood = unilib.node_sound_wood_defaults()

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
    -- All of the locked and internal nodes in Minetest Game
    for _, name in ipairs({
        "unilib:container_chest_ordinary_locked",
        "unilib:container_chest_ordinary_locked_open",
--      "doors:door_steel_b_1", -- old style doors
--      "doors:door_steel_b_2", --
--      "doors:door_steel_t_1", --
--      "doors:door_steel_t_2", --
        "unilib:steel_door_a",   -- new style doors
        "unilib:steel_door_b",   --
        "unilib:steel_door_c",   --
        "unilib:steel_door_d",   --
        "unilib:door_hidden",
        "unilib:trapdoor_steel",
        "unilib:trapdoor_steel_open",
        "unilib:bed_ordinary_bottom",
        "unilib:bed_ordinary_top",
        "unilib:bed_fancy_bottom",
        "unilib:bed_fancy_top",
        "unilib:door_steel_bar_a",
        "unilib:door_steel_bar_b",
        "unilib:door_steel_bar_c",
        "unilib:door_steel_bar_d",
        "unilib:trapdoor_steel_bar",
        "unilib:trapdoor_steel_bar_open",
    }) do
        mesecon.register_mvps_stopper(name)
    end
end
