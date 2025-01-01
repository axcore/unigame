---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_coal_bituminous_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_coal_bituminous_rock.init()

    return {
        description = "Bituminous coal rock (as mineral)",
        notes = "An alternative to the stone ores with bituminous coal",
        depends = "mineral_coal_bituminous",
    }

end

function unilib.pkg.mineral_coal_bituminous_rock.exec()

    local c_lump = "unilib:mineral_coal_bituminous_lump"
    local hardness = unilib.global.mineral_table["coal_bituminous"]["hardness"]

    unilib.register_mineral_rock("coal_bituminous")

    unilib.register_node("unilib:mineral_coal_bituminous_rock", nil, mode, {
        -- Texture from AATO, bituminous_coal_ore.png. Original code
        description = S("Bituminous Coal Rock"),
        tiles = {"unilib_mineral_coal_bituminous_rock.png"},
        groups = {cracky = 2},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_coal_bituminous_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
