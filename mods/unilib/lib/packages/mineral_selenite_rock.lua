---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_selenite_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_selenite_rock.init()

    return {
        description = "Selenite rock (as mineral)",
        notes = "An alternative to the stone ores with selenite",
        depends = "mineral_selenite",
    }

end

function unilib.pkg.mineral_selenite_rock.exec()

    local c_lump = "unilib:mineral_selenite_lump"
    local hardness = unilib.global.mineral_table["selenite"]["hardness"]

    unilib.register_mineral_rock("selenite")

    unilib.register_node("unilib:mineral_selenite_rock", nil, mode, {
        -- Original to unilib
        description = S("Selenite Rock"),
        tiles = {"unilib_mineral_selenite_rock.png"},
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_selenite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
