---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.ladder_papyrus = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ladder_papyrus.init()

    return {
        description = "Papyrus ladder",
        depends = {"item_string_ordinary", "plant_papyrus_ordinary"},
    }

end

function unilib.pkg.ladder_papyrus.exec()

    unilib.register_ladder({
        -- From mtg_plus:ladder_papyrus. Creates unilib:ladder_papyrus
        part_name = "papyrus",
        orig_name = "mtg_plus:ladder_papyrus",
        ingredient = "unilib:plant_papyrus_ordinary",

        replace_mode = mode,
        description = S("Papyrus Ladder"),
        group_table = {choppy = 1, flammable = 2, snappy = 2},
        side_ingredient = "unilib:item_string_ordinary",
        multiple = 2,
        sound_name = "leaves",
    })
    unilib.register_craft({
        -- From mtg_plus:ladder_papyrus
        type = "fuel",
        recipe = "unilib:ladder_papyrus",
        burntime = 2,
    })

end
