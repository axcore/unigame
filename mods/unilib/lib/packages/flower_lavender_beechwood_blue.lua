---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_lavender_beechwood_blue = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_lavender_beechwood_blue.init()

    return {
        description = "Beechwood blue lavender",
    }

end

function unilib.pkg.flower_lavender_beechwood_blue.exec()

    local full_name = "unilib:flower_lavender_beechwood_blue"
    local orig_name = "elysflowers:lavender"
    local img = "unilib_flower_lavender_beechwood_blue.png"

    unilib.register_node(full_name, orig_name, mode, {
        -- From elysflowers:lavender
        description = unilib.utils.annotate(S("Beechwood Blue Lavender"), "Lavandula officinalis"),
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
        selection_box = {-0.35, -0.5, -0.35, 0.35, 0.40, 0.35},
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = img,
    })
    unilib.register_flower_in_pot(
        full_name, orig_name, "unilib_flower_lavender_beechwood_blue_potted.png"
    )

    unilib.register_decoration_generic("elysflowers_flower_lavender_beechwood_blue", {
        -- From elysflowers/init.lua
        deco_type = "simple",
        decoration = full_name,

        noise_params = {
            octaves = 1,
            offset = -0.0135193,
            persist = 0.4,
            scale = 0.0222,
            seed = math.random(),
            spread = {x = 32, y = 32, z = 32},
        },
        rotation = "random",
        sidelen = 16,
    })

end
