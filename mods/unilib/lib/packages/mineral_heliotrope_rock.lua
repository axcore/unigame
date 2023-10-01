---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_heliotrope_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_heliotrope_rock.init()

    return {
        description = "Heliotrope rock (as mineral)",
        notes = "An alternative to the stone ores with heliotrope",
        depends = "mineral_heliotrope",
    }

end

function unilib.pkg.mineral_heliotrope_rock.exec()

    local c_lump = "unilib:mineral_heliotrope_lump"
    local hardness = unilib.mineral_table["heliotrope"]["hardness"]

    unilib.register_mineral_rock("heliotrope")

    unilib.register_node("unilib:mineral_heliotrope_rock", nil, mode, {
        -- Original to unilib
        description = S("Heliotrope Rock"),
        tiles = {"unilib_mineral_heliotrope_rock.png"},
        groups = {cracky = 1},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_heliotrope_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
