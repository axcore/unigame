---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_fungus_tinder = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.nsspf.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_fungus_tinder.init()

    return {
        description = "Tinder fungus",
        notes = "Produces amadou, which can be used as a fuel",
    }

end

function unilib.pkg.plant_fungus_tinder.exec()

    unilib.register_node("unilib:plant_fungus_tinder", "nsspf:fomes_fomentarius", mode, {
        -- From nsspf:fomes_fomentarius
        description = unilib.utils.annotate(S("Tinder Fungus"), "Fomes fomentarius"),
        tiles = {"unilib_plant_fungus_tinder.png"},
        -- N.B. In original code, only snappy = 3
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        -- N.B. In original code, no sounds
        sounds = unilib.global.sound_table.leaves,

        collision_box = {
            type = "fixed",
            fixed = {-0.2, 0, 0.2, 0.2, 0.4, 0.5},
        },
        drawtype = "mesh",
        mesh = "unilib_plant_fungus_tinder.b3d",
        paramtype = "light",
        -- N.B. In original code, "facedir"
        paramtype2 = "wallmounted",
        selection_box = {
            type = "fixed",
            fixed = {-0.2, 0, 0.2, 0.2, 0.4, 0.5},
        },

        on_place = function(itemstack, placer, pointed_thing)
            return
        end,

        on_use = unilib.cuisine.eat_on_use("unilib:plant_fungus_tinder", -1),
    })
    -- (not compatible with flowerpots)

end
