---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_coke_natural_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_coke_natural_rock.init()

    return {
        description = "Natural coke rock (as mineral)",
        notes = "An alternative to the stone ores with natural coke",
        depends = "mineral_coke_natural",
    }

end

function unilib.pkg.mineral_coke_natural_rock.exec()

    local c_lump = "unilib:mineral_coke_natural_lump"
    local hardness = unilib.global.mineral_table["coke_natural"]["hardness"]

    unilib.register_mineral_rock("coke_natural")

    unilib.register_node("unilib:mineral_coke_natural_rock", nil, mode, {
        -- Original to unilib
        description = S("Natural Coke Rock"),
        tiles = {"unilib_mineral_coke_natural_rock.png"},
        groups = {cracky = 1},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_coke_natural_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
