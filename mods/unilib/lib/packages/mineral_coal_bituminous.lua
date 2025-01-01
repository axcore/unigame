---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_coal_bituminous = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_coal_bituminous.init()

    return {
        description = "Bituminous coal (as a mineral)",
        optional = "mineral_coal",
    }

end

function unilib.pkg.mineral_coal_bituminous.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "coal_bituminous",
        description = S("Bituminous coal"),

        combustible_flag = true,
        hardness = 2,
    })

    unilib.register_craftitem(
        -- From real_minerals:bituminous_coal
        "unilib:mineral_coal_bituminous_lump",
        "real_minerals:bituminous_coal",
        mode,
        {
            description = S("Bituminous Coal Lump"),
            inventory_image = "unilib_mineral_coal_bituminous_lump.png",
        }
    )
    unilib.register_craft({
        -- From real_minerals:bituminous_coal
        type = "fuel",
        recipe = "unilib:mineral_coal_bituminous_lump",
        burntime = 35,
    })
    if unilib.global.pkg_executed_table["mineral_coal"] ~= nil then

        -- (Since ordinary coal is such an important craftitem, allow it to be crafted from this
        --      mineral)
        unilib.register_craft({
            -- Original to unilib
            output = "unilib:mineral_coal_lump",
            recipe = {
                {"unilib:mineral_coal_bituminous_lump"},
            },
        })

    end

end
