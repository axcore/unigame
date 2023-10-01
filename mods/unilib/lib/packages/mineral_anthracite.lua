---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_anthracite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_anthracite.init()

    return {
        description = "Anthracite (as a mineral)",
        optional = "mineral_coal",
    }

end

function unilib.pkg.mineral_anthracite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "anthracite",
        description = S("Anthracite"),

        combustible_flag = true,
        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_anthracite_lump", "real_minerals:anthracite", mode, {
        -- From real_minerals:anthracite
        description = S("Anthracite Lump"),
        inventory_image = "unilib_mineral_anthracite_lump.png",
    })
    minetest.register_craft({
        -- From real_minerals:anthracite
        type = "fuel",
        recipe = "unilib:mineral_anthracite_lump",
        burntime = 50,
    })
    if unilib.pkg_executed_table["mineral_coal"] ~= nil then

        -- (Since ordinary coal is such an important craftitem, allow it to be crafted from this
        --      mineral)
        unilib.register_craft({
            -- Original to unilib
            output = "unilib:mineral_coal_lump 2",
            recipe = {
                {"unilib:mineral_anthracite_lump"},
            }
        })

    end

end
