---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_chrysocolla_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_chrysocolla_rock.init()

    return {
        description = "Chrysocolla rock (as mineral)",
        notes = "An alternative to the stone ores with chrysocolla",
        depends = "mineral_chrysocolla",
    }

end

function unilib.pkg.mineral_chrysocolla_rock.exec()

    local c_lump = "unilib:mineral_chrysocolla_lump"
    local hardness = unilib.global.mineral_table["chrysocolla"]["hardness"]

    unilib.register_mineral_rock("chrysocolla")

    unilib.register_node("unilib:mineral_chrysocolla_rock", nil, mode, {
        -- Original to unilib
        description = S("Chrysocolla Rock"),
        tiles = {"unilib_mineral_chrysocolla_rock.png"},
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_chrysocolla_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
