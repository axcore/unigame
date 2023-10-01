---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_jet_dark_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_jet_dark_rock.init()

    return {
        description = "Dark jet rock (as mineral)",
        notes = "An alternative to the stone ores with dark jet",
        depends = "mineral_jet_dark",
    }

end

function unilib.pkg.mineral_jet_dark_rock.exec()

    local c_lump = "unilib:mineral_jet_dark_lump"
    local hardness = unilib.mineral_table["jet_dark"]["hardness"]

    unilib.register_mineral_rock("jet_dark")

    unilib.register_node("unilib:mineral_jet_dark_rock", nil, mode, {
        -- Original to unilib
        description = S("Dark Jet Rock"),
        tiles = {"unilib_mineral_jet_dark_rock.png"},
        groups = {cracky = 3},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_jet_dark_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
