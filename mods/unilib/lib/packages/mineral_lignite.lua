---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_lignite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_lignite.init()

    return {
        description = "Lignite (as a mineral)",
        optional = "mineral_coal",
    }

end

function unilib.pkg.mineral_lignite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "lignite",
        description = S("Lignite"),

        combustible_flag = true,
        hardness = 1,
    })

    unilib.register_craftitem("unilib:mineral_lignite_lump", "real_minerals:lignite", mode, {
        -- From real_minerals:lignite
        description = S("Lignite Lump"),
        inventory_image = "unilib_mineral_lignite_lump.png",
    })
    unilib.register_craft({
        -- From real_minerals:lignite
        type = "fuel",
        recipe = "unilib:mineral_lignite_lump",
        burntime = 25,
    })
    if unilib.pkg_executed_table["mineral_coal"] ~= nil then

        -- (Since ordinary coal is such an important craftitem, allow it to be crafted from this
        --      mineral)
        unilib.register_craft({
            -- Original to unilib
            output = "unilib:mineral_coal_lump",
            recipe = {
                {"unilib:mineral_lignite_lump"},
            },
        })

    end

end
