---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_aetherium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_aetherium.init()

    return {
        description = "Aetherium (as a mineral)",
        notes = "Used to craft flight potions",
    }

end

function unilib.pkg.mineral_aetherium.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "aetherium",
        description = S("Aetherium"),

        hardness = 1,
        no_lump_flag = true,
    })

    -- N.B. This item is dropped directly unilib:stone_desert_with_aetherium and
    --      unilib:stone_ordinary_with_aetherium, so it is a dust, not a powder
    unilib.register_craftitem("unilib:mineral_aetherium_dust", "ethereal:etherium_dust", mode, {
        -- From ethereal:etherium_dust
        description = S("Pile of Aetherium Dust"),
        inventory_image = "unilib_mineral_aetherium_dust.png",

        wield_image = "unilib_mineral_aetherium_dust.png",
    })

end
