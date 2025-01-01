---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng (20241119 update)
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_poppy_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_poppy_normal.init()

    return {
        description = "Normal poppy",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_poppy_normal.exec()

    unilib.register_node("unilib:flower_poppy_normal", "xanadu:poppy", mode, {
        -- From ethereal, xanadu:poppy
        description = unilib.utils.annotate(S("Normal Poppy"), "Papaver somniferum"),
        tiles = {"unilib_flower_poppy_normal.png"},
        groups = {attached_node = 1, flammable = 3, flora = 1, flower = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_flower_poppy_normal.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_flower_poppy_normal.png",
    })
    if unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From ethereal, xanadu:poppy
            output = "unilib:dye_red 4",
            recipe = {
                {"unilib:flower_poppy_normal"},
            },
        })

    end
    unilib.register_flower_in_pot("unilib:flower_poppy_normal", "xanadu:poppy")

    unilib.register_decoration_spare("unilib:flower_poppy_normal")

end
