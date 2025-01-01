---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_cryolite_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_cryolite_rock.init()

    return {
        description = "Cryolite rock (as mineral)",
        notes = "An alternative to the stone ores with cryolite",
        depends = "mineral_cryolite",
    }

end

function unilib.pkg.mineral_cryolite_rock.exec()

    local c_lump = "unilib:mineral_cryolite_lump"
    local hardness = unilib.global.mineral_table["cryolite"]["hardness"]

    unilib.register_mineral_rock("cryolite")

    unilib.register_node("unilib:mineral_cryolite_rock", nil, mode, {
        -- Original to unilib
        description = S("Cryolite Rock"),
        tiles = {"unilib_mineral_cryolite_rock.png"},
        groups = {cracky = 2},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_cryolite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
