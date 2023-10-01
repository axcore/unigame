---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_gold_native_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_gold_native_rock.init()

    return {
        description = "Native gold rock (as mineral)",
        notes = "An alternative to the stone ores with native gold",
        depends = "mineral_gold_native",
    }

end

function unilib.pkg.mineral_gold_native_rock.exec()

    local c_lump = "unilib:mineral_gold_native_lump"
    local hardness = unilib.mineral_table["gold_native"]["hardness"]

    unilib.register_mineral_rock("gold_native")

    unilib.register_node("unilib:mineral_gold_native_rock", nil, mode, {
        -- Original to unilib
        description = S("Native Gold Rock"),
        tiles = {"unilib_mineral_gold_native_rock.png"},
        groups = {cracky = 1},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_gold_native_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
