---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_gersdorffite_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_gersdorffite_rock.init()

    return {
        description = "Gersdorffite rock (as mineral)",
        notes = "An alternative to the stone ores with gersdorffite",
        depends = "mineral_gersdorffite",
    }

end

function unilib.pkg.mineral_gersdorffite_rock.exec()

    local c_lump = "unilib:mineral_gersdorffite_lump"
    local hardness = unilib.global.mineral_table["gersdorffite"]["hardness"]

    unilib.register_mineral_rock("gersdorffite")

    unilib.register_node("unilib:mineral_gersdorffite_rock", nil, mode, {
        -- Texture from AATO, gersdorffite.png. Original code
        description = S("Gersdorffite Rock"),
        tiles = {"unilib_mineral_gersdorffite_rock.png"},
        groups = {cracky = 1},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_gersdorffite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
