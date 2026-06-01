---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_dames_rocket = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_dames_rocket.init()

    return {
        description = "Dame's rocket",
    }

end

function unilib.pkg.flower_dames_rocket.exec()

    local full_name = "unilib:flower_dames_rocket"
    local orig_name = "elysflowers:dames_rocket"
    local img = "unilib_flower_dames_rocket.png"

    unilib.register_node(full_name, orig_name, mode, {
        -- From elysflowers:dames_rocket
        description = unilib.utils.annotate(S("Dame's Rocket"), "Hesperis matronalis"),
        tiles = {img},
        -- N.B. Used standard unilib flower groups, rather than the extended set in original code
        groups = {
            attached_node = 1, color_grey = 1, colour_grey = 1, flammable = 1, flora = 1,
            flower = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        floodable = true,
        inventory_image = img,
        paramtype = "light",
        selection_box = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = img,
    })
    unilib.register_flower_in_pot(full_name, orig_name)

    unilib.register_decoration_generic("elysflowers_flower_dames_rocket", {
        -- From elysflowers/init.lua
        deco_type = "simple",
        decoration = full_name,

        noise_params = {
            octaves = 1,
            offset = -0.0127,
            persist = 0.5,
            scale = 0.020,
            seed = math.random(),
            spread = {x = 64, y = 64, z = 64},
        },
        rotation = "random",
        sidelen = 16,
    })

end
