---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.grass_swamp_dark = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.grass_swamp_dark.init()

    return {
        description = "Dark swamp grass",
    }

end

function unilib.pkg.grass_swamp_dark.exec()

    local full_name = "unilib:grass_swamp_dark"
    local drop = full_name
    if unilib.setting.disable_grass_drop_flag then
        drop = ""
    end

    unilib.register_node(full_name, "lib_ecology:grass_swamp", mode, {
        -- From GLEMr11, lib_ecology:grass_swamp
        description = S("Dark Swamp Grass"),
        tiles = {"unilib_grass_swamp_dark.png"},
        -- N.B. dark_swamp_grass = 1, grass = 1 not in original code
        groups = {
            attached_node = 1, dark_swamp_grass = 1, flammable = 1, flora = 1, grass = 1,
            leaves = 1, oddly_breakable_by_hand = 1, snappy = 3,
        },
        -- N.B. No sounds in original code
        sounds = unilib.global.sound_table.leaves,

        buildable_to = false,
        drawtype = "plantlike",
        drop = drop,
        -- N.B. floodable no longer required, because of unilib's flooding effects
--      floodable = true,
        -- N.B. inventory_image not in original code
        inventory_image = "unilib_grass_swamp_dark.png",
        -- N.B. removed is_ground_content = false to match other grasses
--      is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0, 0.3},
        },
        sunlight_propagates = true,
        visual_scale = 1,
        walkable = false,
        waving = 1,
        wield_scale = {x = 0.5, y = 0.5, z = 0.5},
    })
    unilib.register_plant_in_pot(full_name, "lib_ecology:grass_swamp")

    unilib.register_decoration_spare(full_name)

end
