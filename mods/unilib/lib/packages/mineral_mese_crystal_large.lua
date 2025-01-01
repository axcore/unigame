---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_mese_crystal_large = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_mese_crystal_large.init()

    return {
        description = "Large mese crystal (as a mineral)",
    }

end

function unilib.pkg.mineral_mese_crystal_large.exec()

    unilib.register_node("unilib:mineral_mese_crystal_large", "underch:mese_crystal", mode, {
        -- From underch:mese_crystal
        description = S("Large Mese Crystal"),
        tiles = {"unilib_mineral_mese_crystal_large.png"},
        groups = {cracky = 2},
        sounds = unilib.global.sound_table.glass,

        drawtype = "mesh",
        is_ground_content = false,
        light_source = 4,
        mesh = "unilib_mineral_crystal_large.obj",
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From underch:mese_crystal
        type = "shapeless",
        output = "unilib:mineral_mese_crystal 2",
        recipe = {"unilib:mineral_mese_crystal_large"},
    })

end
