---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.material_charcoal_artificial_briquette = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.material_charcoal_artificial_briquette.init()

    return {
        description = "Artificial charcoal briquette",
        depends = {"material_charcoal_artificial_lump", "misc_sawdust"},
    }

end

function unilib.pkg.material_charcoal_artificial_briquette.exec()

    local c_sawdust = "unilib:misc_sawdust"

    unilib.register_craftitem(
        -- From bbq:charcoal_briquette
        "unilib:material_charcoal_artificial_briquette",
        "bbq:charcoal_briquette",
        mode,
        {
            description = S("Artificial Charcoal Briquette"),
            inventory_image = "unilib_material_charcoal_artificial_briquette.png",

            wield_image = "unilib_material_charcoal_artificial_briquette.png",
        }
    )
    unilib.register_craft({
        -- From bbq:charcoal_briquette
        output = "unilib:material_charcoal_artificial_briquette",
        recipe = {
            {"", c_sawdust, ""},
            {c_sawdust, "unilib:material_charcoal_artificial_lump", c_sawdust},
            {"", c_sawdust, ""},
        },
    })
    unilib.register_craft({
        -- From bbq:charcoal_briquette
        type = "fuel",
        recipe = "unilib:material_charcoal_artificial_briquette",
        burntime = 10,
    })

end
