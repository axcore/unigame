---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_chive_siberian = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_chive_siberian.init()

    return {
        description = "Siberian chive",
    }

end

function unilib.pkg.flower_chive_siberian.exec()

    local full_name = "unilib:flower_chive_siberian"
    local orig_name = "elysflowers:siberian_chive"
    local img = "unilib_flower_chive_siberian.png"

    unilib.register_node(full_name, orig_name, mode, {
        -- From elysflowers:siberian_chive
        description = unilib.utils.annotate(S("Siberian Chive"), "Allium schoenoprasum"),
        tiles = {img},
        -- N.B. Used standard unilib flower groups, rather than the extended set in original code
        groups = {
            attached_node = 1, color_violet = 1, colour_violet = 1, flammable = 1, flora = 1,
            flower = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        floodable = true,
        inventory_image = img,
        paramtype = "light",
        selection_box = {-0.35, -0.4, -0.35, 0.35, 0.40, 0.35},
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = img,
    })
    unilib.register_flower_in_pot(full_name, orig_name)

    unilib.register_decoration_generic("elysflowers_flower_chive_siberian", {
        -- From elysflowers/init.lua
        deco_type = "simple",
        decoration = full_name,

        noise_params = {
            octaves = 2,
            offset = 0.00469,
            persist = 0.5,
            scale = 0.00049,
            seed = math.random(),
            spread = {x = 16, y = 16, z = 16},
        },
        rotation = "random",
        sidelen = 16,
    })

end
