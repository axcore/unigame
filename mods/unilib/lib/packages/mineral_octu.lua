---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    octu
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_octu = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.octu.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_octu.init()

    return {
        description = "Octu crystal and block",
        optional = {"mineral_mese", "mineral_sapphire"},
    }

end

function unilib.pkg.mineral_octu.exec()

    unilib.register_craftitem("unilib:mineral_octu_crystal", "octu:octu", mode, {
        -- From octu:octu
        description = S("Octu Crystal"),
        inventory_image = "unilib_mineral_octu_crystal.png",
    })

    unilib.register_node("unilib:mineral_octu_block", "octu:block", mode, {
        -- From octu:block
        description = S("Octu Block"),
        tiles = {"unilib_mineral_octu_block.png"},
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.glass,

        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From octu:block
        output = "unilib:mineral_octu_block",
        ingredient = "unilib:mineral_octu_crystal",
    })
    unilib.register_craft({
        type = "shapeless",
        output = "unilib:mineral_octu_crystal 9",
        recipe = {"unilib:mineral_octu_block"},
    })
    if unilib.global.pkg_executed_table["mineral_mese"] ~= nil and
            unilib.global.pkg_executed_table["mineral_sapphire"] ~= nil then

        unilib.register_craft({
            -- From octu:octu
            output = "unilib:mineral_octu_crystal",
            recipe = {
                {"unilib:mineral_sapphire_gem", "unilib:mineral_mese_crystal"},
                {"unilib:mineral_mese_crystal", "unilib:mineral_sapphire_gem"},
            },
        })

    end

end
