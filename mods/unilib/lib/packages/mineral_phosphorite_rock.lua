---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_phosphorite_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_phosphorite_rock.init()

    return {
        description = "Phosphorite rock (as mineral)",
        notes = "An alternative to the stone ores with phosphorite",
        depends = "mineral_phosphorite",
    }

end

function unilib.pkg.mineral_phosphorite_rock.exec()

    local c_lump = "unilib:mineral_phosphorite_lump"
    local hardness = unilib.global.mineral_table["phosphorite"]["hardness"]

    unilib.register_mineral_rock("phosphorite")

    unilib.register_node("unilib:mineral_phosphorite_rock", nil, mode, {
        -- Texture from AATO, phosphorite.png. Original code
        description = S("Phosphorite Rock"),
        tiles = {"unilib_mineral_phosphorite_rock.png"},
        groups = {cracky = 1},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_phosphorite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
