---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_agate_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_agate_rock.init()

    return {
        description = "Agate rock (as mineral)",
        notes = "An alternative to the stone ores with agate",
        depends = "mineral_agate",
    }

end

function unilib.pkg.mineral_agate_rock.exec()

    local c_lump = "unilib:mineral_agate_lump"
    local hardness = unilib.global.mineral_table["agate"]["hardness"]

    unilib.register_mineral_rock("agate")

    unilib.register_node("unilib:mineral_agate_rock", nil, mode, {
        -- Original to unilib
        description = S("Agate Rock"),
        tiles = {"unilib_mineral_agate_rock.png"},
        groups = {cracky = 1},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_agate_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
