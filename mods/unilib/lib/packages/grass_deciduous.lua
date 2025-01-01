---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.grass_deciduous = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.grass_deciduous.init()

    return {
        description = "Deciduous forest grass",
    }

end

function unilib.pkg.grass_deciduous.exec()

    local full_name = "unilib:grass_deciduous"
    local drop = full_name
    if unilib.setting.disable_grass_drop_flag then
        drop = ""
    end

    unilib.register_node(full_name, "mapgen:bush", mode, {
        -- From farlands, mapgen:bush
        description = S("Deciduous Forest Bush"),
        tiles = {"unilib_grass_deciduous.png"},
        -- N.B. leaves = 1 in original code, removed. attached_node = 1, flora = 1, grass = 1,
        --      deciduous_grass = 1 not in original code, added
        groups = {
            attached_node = 1, deciduous_grass = 1, flammable = 1, flora = 1, grass = 1,
            oddly_breakable_by_hand = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "firelike",
        drop = drop,
        -- N.B. removed is_ground_content = false to match other grasses
--      is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.4, -0.4, -0.4, 0.4, 0.4, 0.4},
        },
        sunlight_propagates = false,
        visual_scale = 1.2,
        walkable = false,
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration_generic("farlands_grass_deciduous", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "simple",
        decoration = full_name,

        fill_ratio = 0.05,
        height = 1,
        sidelen = 16,
    })

end
