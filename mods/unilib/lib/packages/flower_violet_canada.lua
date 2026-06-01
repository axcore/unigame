---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_violet_canada = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_violet_canada.init()

    return {
        description = "Canada violet",
    }

end

function unilib.pkg.flower_violet_canada.exec()

    local full_name = "unilib:flower_violet_canada"
    local orig_name = "elysflowers:canada_violet"
    local img = "unilib_flower_violet_canada.png"

    unilib.register_node(full_name, orig_name, mode, {
        -- From elysflowers:canada_violet
        -- N.B. Original code used the wrong botanical name
        description = unilib.utils.annotate(S("Canada Violet"), "Viola canadensis"),
        tiles = {img},
        -- N.B. Used standard unilib flower groups, rather than the extended set in original code
        groups = {
            attached_node = 1, color_white = 1, colour_white = 1, flammable = 1, flora = 1,
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

    unilib.register_decoration_generic("elysflowers_flower_violet_canada", {
        -- From elysflowers/init.lua
        deco_type = "simple",
        decoration = full_name,

        noise_params = {
            lacunarity = 0.21,
            octaves = 4,
            offset = 0.000190944,
            persist = 0.69,
            scale = 0.000717701,
            seed = math.random(),
            spread = {x = 24, y = 6, z = 24},
        },
        rotation = "random",
        sidelen = 16,
    })

end
