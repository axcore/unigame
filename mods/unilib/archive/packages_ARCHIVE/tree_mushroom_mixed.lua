---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
--
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("lib_ecology:mushroom_02_stem", {
	description = S("Mushroom 02 Stem"),
	tiles = {
		"lib_ecology_mushroom_02_trunk_top.png",
		"lib_ecology_mushroom_02_trunk_top.png",
		"lib_ecology_mushroom_02_trunk.png",
	},
	groups = {choppy = 1, flammable = 1, oddly_breakable_by_hand=1, wood=1},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})

lib_ecology:mushroom_cap_blue
{
    tiles = {
        [1] = "lib_ecology_mushroom_cap_blue.png",
        [2] = "lib_ecology_mushroom_cap_blue.png",
    },
    is_ground_content = false,
    groups = {
        lib_ecology_tree = 1,
        tree = 1,
        choppy = 1,
        flammable = 2,
    },
    sounds = {
    },
    walkable = true,
    paramtype2 = "facedir",
    paramtype = "light",
    legacy_wallmounted = false,
    description = "Mushroom - Cap Blue",
}

minetest.register_node("lib_ecology:mushroom_02_cap_brown", {
	description = S("Mushroom 02 Cap Brown"),
	tiles = {
		"lib_ecology_mushroom_02_cap_brown.png",
		"lib_ecology_mushroom_02_spores.png",
		"lib_ecology_mushroom_02_cap_brown.png",
	},
	groups = {choppy = 1, flammable = 1, oddly_breakable_by_hand=1, wood=1},
	sounds = default.node_sound_wood_defaults()
})

lib_ecology:mushroom_cap_brown_02
{
    tiles = {
        [1] = "lib_ecology_mushroom_cap_brown_02.png",
        [2] = "lib_ecology_mushroom_cap_brown_02.png",
    },
    is_ground_content = false,
    groups = {
        lib_ecology_tree = 1,
        tree = 1,
        choppy = 1,
        flammable = 2,
    },
    sounds = {
    },
    walkable = true,
    paramtype2 = "facedir",
    paramtype = "light",
    legacy_wallmounted = false,
    description = "Mushroom - Cap Brown 02",
}

lib_ecology:mushroom_cap_green_dk
{
    tiles = {
        [1] = "lib_ecology_mushroom_cap_green_dk.png",
        [2] = "lib_ecology_mushroom_cap_green_dk.png",
    },
    is_ground_content = false,
    groups = {
        lib_ecology_tree = 1,
        tree = 1,
        choppy = 1,
        flammable = 2,
    },
    sounds = {
    },
    walkable = true,
    paramtype2 = "facedir",
    paramtype = "light",
    legacy_wallmounted = false,
    description = "Mushroom - Cap Green Dark",
}

lib_ecology:mushroom_cap_green_lt
{
    tiles = {
        [1] = "lib_ecology_mushroom_cap_green_lt.png",
        [2] = "lib_ecology_mushroom_cap_green_lt.png",
    },
    is_ground_content = false,
    groups = {
        lib_ecology_tree = 1,
        tree = 1,
        choppy = 1,
        flammable = 2,
    },
    sounds = {
    },
    walkable = true,
    paramtype2 = "facedir",
    paramtype = "light",
    legacy_wallmounted = false,
    description = "Mushroom - Cap Green Light",
}

lib_ecology:mushroom_cap_green_spotted
{
    tiles = {
        [1] = "lib_ecology_mushroom_cap_green_spotted.png",
        [2] = "lib_ecology_mushroom_cap_green_spotted.png",
    },
    is_ground_content = false,
    groups = {
        lib_ecology_tree = 1,
        tree = 1,
        choppy = 1,
        flammable = 2,
    },
    sounds = {
    },
    walkable = true,
    paramtype2 = "facedir",
    paramtype = "light",
    legacy_wallmounted = false,
    description = "Mushroom - Cap Green Spotted",
}

lib_ecology:mushroom_cap_mottled
{
    tiles = {
        [1] = "lib_ecology_mushroom_cap_mottled.png",
        [2] = "lib_ecology_mushroom_cap_mottled.png",
    },
    is_ground_content = false,
    groups = {
        lib_ecology_tree = 1,
        tree = 1,
        choppy = 1,
        flammable = 2,
    },
    sounds = {
    },
    walkable = true,
    paramtype2 = "facedir",
    paramtype = "light",
    legacy_wallmounted = false,
    description = "Mushroom - Cap Mottled",
}

lib_ecology:mushroom_cap_purple
{
    tiles = {
        [1] = "lib_ecology_mushroom_cap_purple.png",
        [2] = "lib_ecology_mushroom_cap_purple.png",
    },
    is_ground_content = false,
    groups = {
        lib_ecology_tree = 1,
        tree = 1,
        choppy = 1,
        flammable = 2,
    },
    sounds = {
    },
    walkable = true,
    paramtype2 = "facedir",
    paramtype = "light",
    legacy_wallmounted = false,
    description = "Mushroom - Cap Purple",
}

minetest.register_node("lib_ecology:mushroom_02_cap_red", {
	description = S("Mushroom 02 Cap Red"),
	tiles = {
		"lib_ecology_mushroom_02_cap_red.png",
		"lib_ecology_mushroom_02_spores.png",
		"lib_ecology_mushroom_02_cap_red.png",
	},
	groups = {choppy = 1, flammable = 1, oddly_breakable_by_hand=1, wood=1},
	sounds = default.node_sound_wood_defaults()
})

lib_ecology:mushroom_cap_red_02
{
    tiles = {
        [1] = "lib_ecology_mushroom_cap_red_02.png",
        [2] = "lib_ecology_mushroom_cap_red_02.png",
    },
    is_ground_content = false,
    groups = {
        lib_ecology_tree = 1,
        tree = 1,
        choppy = 1,
        flammable = 2,
    },
    sounds = {
    },
    walkable = true,
    paramtype2 = "facedir",
    paramtype = "light",
    legacy_wallmounted = false,
    description = "Mushroom - Cap Red 02",
}

lib_ecology:mushroom_cap_tan
{
    tiles = {
        [1] = "lib_ecology_mushroom_cap_tan.png",
        [2] = "lib_ecology_mushroom_cap_tan.png",
    },
    is_ground_content = false,
    groups = {
        lib_ecology_tree = 1,
        tree = 1,
        choppy = 1,
        flammable = 2,
    },
    sounds = {
    },
    walkable = true,
    paramtype2 = "facedir",
    paramtype = "light",
    legacy_wallmounted = false,
    description = "Mushroom - Cap Tan",
}

lib_ecology:mushroom_spore_02
{
    tiles = {
        [1] = "lib_ecology_mushroom_spore_02.png",
        [2] = "lib_ecology_mushroom_spore_02.png",
    },
    is_ground_content = false,
    groups = {
        lib_ecology_tree = 1,
        tree = 1,
        choppy = 1,
        flammable = 2,
    },
    sounds = {
    },
    walkable = true,
    paramtype2 = "facedir",
    paramtype = "light",
    legacy_wallmounted = false,
    description = "Mushroom - Spore 02",
}

lib_ecology:mushroom_spore_03
{
    tiles = {
        [1] = "lib_ecology_mushroom_spore_03.png",
        [2] = "lib_ecology_mushroom_spore_03.png",
    },
    is_ground_content = false,
    groups = {
        lib_ecology_tree = 1,
        tree = 1,
        choppy = 1,
        flammable = 2,
    },
    sounds = {
    },
    walkable = true,
    paramtype2 = "facedir",
    paramtype = "light",
    legacy_wallmounted = false,
    description = "Mushroom - Spore 03",
}
]]--
