---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_goldenrod = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_goldenrod.init()

    return {
        description = "Goldenrod",
    }

end

function unilib.pkg.flower_goldenrod.exec()

    local full_name = "unilib:flower_goldenrod"
    local orig_name = "elysflowers:goldenrod"
    local img = "unilib_flower_goldenrod.png"

    unilib.register_node(full_name, orig_name, mode, {
        -- From elysflowers:goldenrod
        description = unilib.utils.annotate(S("Goldenrod"), "Solidago nemoralis"),
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
        selection_box = {-0.25, -0.5, -0.25, 0.30, 0.5, 0.30},
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = img,
    })
    -- N.B. Not compatible with flowerpots, even in original code

    unilib.register_decoration_generic("elysflowers_flower_goldenrod", {
        -- From elysflowers/init.lua
        deco_type = "simple",
        decoration = full_name,

        noise_params = {
            flags = {"absvalue", "eased"},
            octaves = 2,
            offset = -0.0471,
            persist = 0.0,
            scale = 0.054340,
            seed = 9458745,
            spread = {x = 1, y = 1, z = 1},
        },
        rotation = "random",
        sidelen = 16,
    })

end
