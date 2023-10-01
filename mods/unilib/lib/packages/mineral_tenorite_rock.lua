---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_tenorite_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_tenorite_rock.init()

    return {
        description = "Tenorite rock (as mineral)",
        notes = "An alternative to the stone ores with tenorite",
        depends = "mineral_tenorite",
    }

end

function unilib.pkg.mineral_tenorite_rock.exec()

    local c_lump = "unilib:mineral_tenorite_lump"
    local hardness = unilib.mineral_table["tenorite"]["hardness"]

    unilib.register_mineral_rock("tenorite")

    unilib.register_node("unilib:mineral_tenorite_rock", nil, mode, {
        -- Original to unilib
        description = S("Tenorite Rock"),
        tiles = {"unilib_mineral_tenorite_rock.png"},
        groups = {cracky = 2},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_tenorite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
