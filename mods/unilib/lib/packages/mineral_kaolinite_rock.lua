---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_kaolinite_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_kaolinite_rock.init()

    return {
        description = "Kaolinite rock (as mineral)",
        notes = "An alternative to the stone ores with kaolinite",
        depends = "mineral_kaolinite",
    }

end

function unilib.pkg.mineral_kaolinite_rock.exec()

    local c_lump = "unilib:mineral_kaolinite_lump"
    local hardness = unilib.global.mineral_table["kaolinite"]["hardness"]

    unilib.register_mineral_rock("kaolinite")

    unilib.register_node("unilib:mineral_kaolinite_rock", nil, mode, {
        -- Original to unilib
        description = S("Kaolinite Rock"),
        tiles = {"unilib_mineral_kaolinite_rock.png"},
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_kaolinite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
