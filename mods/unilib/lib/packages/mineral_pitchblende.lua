---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_pitchblende = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_pitchblende.init()

    return {
        description = "Pitchblende (as a mineral)",
        notes = "In real life, pitchblende and uraninite are the same; here, they are two" ..
                " separate packages (but both can be used to produce uranium ingots)",
        optional = "metal_uranium",
    }

end

function unilib.pkg.mineral_pitchblende.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "pitchblende",
        description = S("Pitchblende"),

        hardness = 3,
        metal_list = {"uranium"},
    })

    unilib.register_craftitem(
        -- From real_minerals:pitchblende
        "unilib:mineral_pitchblende_lump",
        "real_minerals:pitchblende",
        mode,
        {
            description = S("Pitchblende Lump"),
            inventory_image = "unilib_mineral_pitchblende_lump.png",
        }
    )
    if unilib.global.pkg_executed_table["metal_uranium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_uranium_ingot",
            recipe = "unilib:mineral_pitchblende_lump",
        })

    end

end
