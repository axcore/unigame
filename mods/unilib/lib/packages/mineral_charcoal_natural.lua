---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_charcoal_natural = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_charcoal_natural.init()

    return {
        description = "Natural charcoal (as a mineral)",
        optional = "mineral_coal",
    }

end

function unilib.pkg.mineral_charcoal_natural.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "charcoal_natural",
        description = S("Natural Charcoal"),

        combustible_flag = true,
        hardness = 1,
    })

    unilib.register_craftitem(
        -- From real_minerals:charcoal
        "unilib:mineral_charcoal_natural_lump",
        "real_minerals:charcoal",
        mode,
        {
            description = S("Natural Charcoal Lump"),
            inventory_image = "unilib_mineral_charcoal_natural_lump.png",
        }
    )
    unilib.register_craft({
        -- From real_minerals:charcoal
        type = "fuel",
        recipe = "unilib:mineral_charcoal_natural_lump",
        burntime = 20,
    })
    if unilib.pkg_executed_table["mineral_coal"] ~= nil then

        -- (Since ordinary coal is such an important craftitem, allow it to be crafted from this
        --      mineral)
        unilib.register_craft({
            -- Original to unilib
            output = "unilib:mineral_coal_lump",
            recipe = {
                {"unilib:mineral_charcoal_natural_lump"},
            },
        })

    end

end
