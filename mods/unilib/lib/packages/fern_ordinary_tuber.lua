---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/ferns
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.fern_ordinary_tuber = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ferns.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fern_ordinary_tuber.init()

    return {
        description = "Ordinary fern tuber",
        notes = "Harvested from ordinary ferns, edible when cooked",
    }

end

function unilib.pkg.fern_ordinary_tuber.exec()

    -- (Produced as a leftover by a craft recipe in the "food_fiddlehead" package)
    unilib.register_craftitem("unilib:fern_ordinary_tuber", "ferns:ferntuber", mode, {
        -- From ferns:ferntuber
        description = S("Ordinary Fern Tuber"),
        inventory_image = "unilib_fern_ordinary_tuber.png",
    })

    unilib.register_craftitem(
        -- From ferns:ferntuber_roasted
        "unilib:fern_ordinary_tuber_cooked",
        "ferns:ferntuber_roasted",
        mode,
        {
            description = S("Roasted Ordinary Fern Tuber"),
            inventory_image = "unilib_fern_ordinary_tuber_cooked.png",
            -- Not in original code; matches code in unilib:fern_boston_tubers
            groups = {flammable = 2, food_tuber = 1},

            on_use = unilib.cuisine.eat_on_use("unilib:fern_ordinary_tuber", 3),
        }
    )
    unilib.register_craft({
        -- From ferns:ferntuber_roasted
        type = "cooking",
        output = "unilib:fern_ordinary_tuber_cooked",
        recipe = "unilib:fern_ordinary_tuber",
        cooktime = 3,
    })

end
