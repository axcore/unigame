---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_stibnite_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_stibnite_rock.init()

    return {
        description = "Stibnite rock (as mineral)",
        notes = "An alternative to the stone ores with stibnite",
        depends = "mineral_stibnite",
    }

end

function unilib.pkg.mineral_stibnite_rock.exec()

    local c_lump = "unilib:mineral_stibnite_lump"
    local hardness = unilib.global.mineral_table["stibnite"]["hardness"]

    unilib.register_mineral_rock("stibnite")

    unilib.register_node("unilib:mineral_stibnite_rock", nil, mode, {
        -- Texture from AATO, stibnite.png. Original code
        description = S("Stibnite Rock"),
        tiles = {"unilib_mineral_stibnite_rock.png"},
        groups = {cracky = 2},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_stibnite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
