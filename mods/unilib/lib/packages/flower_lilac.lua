---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng (20241119 update)
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_lilac = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_lilac.init()

    return {
        description = "Lilac",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_lilac.exec()

    unilib.register_node("unilib:flower_lilac", "ethereal:lilac", mode, {
        -- From ethereal:lilac
        description = unilib.utils.annotate(S("Lilac"), "Syringa vulgaris"),
        tiles = {"unilib_flower_lilac.png"},
        groups = {attached_node = 1, flammable = 2, flora = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_flower_lilac.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0.67, 5 / 16}
        },
        sunlight_propagates = true,
        visual_scale = 1.9,
        walkable = false,
        waving = 1,
        wield_image = "unilib_flower_lilac.png",

    })
    if unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From ethereal:lilac
            output = "unilib:dye_magenta 2",
            recipe = {
                {"unilib:flower_lilac"},
            },
        })

    end
    unilib.register_flower_in_pot("unilib:flower_lilac", "ethereal:lilac")

    unilib.register_decoration_generic("ethereal_flower_lilac", {
        -- From ethereal-ng/decor.lua
        deco_type = "simple",
        decoration = "unilib:flower_lilac",

        fill_ratio = 0.025,
        sidelen = 80,
    })

end
