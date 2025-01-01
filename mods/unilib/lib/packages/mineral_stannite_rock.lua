---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_stannite_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_stannite_rock.init()

    return {
        description = "Stannite rock (as mineral)",
        notes = "An alternative to the stone ores with stannite",
        depends = "mineral_stannite",
    }

end

function unilib.pkg.mineral_stannite_rock.exec()

    local c_lump = "unilib:mineral_stannite_lump"
    local hardness = unilib.global.mineral_table["stannite"]["hardness"]

    unilib.register_mineral_rock("stannite")

    unilib.register_node("unilib:mineral_stannite_rock", nil, mode, {
        -- Texture from AATO, stannite.png. Original code
        description = S("Stannite Rock"),
        tiles = {"unilib_mineral_stannite_rock.png"},
        groups = {cracky = 2},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_stannite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
