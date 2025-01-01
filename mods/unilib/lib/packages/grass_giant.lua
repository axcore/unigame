---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.grass_giant = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.grass_giant.init()

    return {
        description = "Giant grass",
    }

end

function unilib.pkg.grass_giant.exec()

    local full_name = "unilib:grass_giant"
    local drop = full_name
    if unilib.setting.disable_grass_drop_flag then
        drop = ""
    end

    unilib.register_node(full_name, "mapgen:giantgrass", mode, {
        -- From farlands, mapgen:giantgrass
        description = S("Giant Grass"),
        tiles = {"unilib_grass_giant.png"},
        -- N.B. grass = 1, giant_grass = 1 not in original code
        groups = {
            attached_node = 1, flammable = 1, flora = 1, giant_grass = 1, grass = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        drop = drop,
        inventory_image = "unilib_grass_giant.png",
        -- N.B. removed is_ground_content = false to match other grasses
--      is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
        },
        sunlight_propagates = true,
        visual_scale = 4,
        walkable = false,
        wield_scale = {x = 0.5, y = 0.5, z = 0.5},
    })
    unilib.register_plant_in_pot(full_name, "mapgen:giantgrass")

    unilib.register_decoration_generic("farlands_grass_giant", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "simple",
        decoration = full_name,

        height = 1,
        fill_ratio = 0.1,
        sidelen = 16,
    })

end
