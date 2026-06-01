---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_thistle_yellow_star = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_thistle_yellow_star.init()

    return {
        description = "Yellow star thistle",
    }

end

function unilib.pkg.flower_thistle_yellow_star.exec()

    local full_name = "unilib:flower_thistle_yellow_star"
    local orig_name = "elysflowers:yellow_star_thistle"
    local img = "unilib_flower_thistle_yellow_star.png"

    unilib.register_node(full_name, orig_name, mode, {
        -- From elysflowers:yellow_star_thistle
        description = unilib.utils.annotate(S("Yellow Star Thistle"), "Centaurea solstitialis"),
        tiles = {img},
        -- N.B. Used standard unilib flower groups, rather than the extended set in original code
        groups = {
            attached_node = 1, color_yellow = 1, colour_yellow = 1, flammable = 1, flora = 1,
            flower = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        floodable = true,
        inventory_image = img,
        paramtype = "light",
        selection_box = {-0.35, -0.4, -0.35, 0.25, 0.40, 0.35},
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = img,
    })
    unilib.register_flower_in_pot(full_name, orig_name)

    unilib.register_decoration_generic("elysflowers_flower_thistle_yellow_star", {
        -- From elysflowers/init.lua
        deco_type = "simple",
        decoration = full_name,

        noise_params = {
            lacunarity = 0.040,
            octaves = 3,
            offset = 0.0002909,
            persist = 0.203,
            scale = 0.00014341,
            seed = math.random(),
            spread = {x = 12, y = 8, z = 12},
        },
        rotation = "random",
        sidelen = 16,
    })

end
