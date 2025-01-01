---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_boulangerite_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_boulangerite_rock.init()

    return {
        description = "Boulangerite rock (as mineral)",
        notes = "An alternative to the stone ores with boulangerite",
        depends = "mineral_boulangerite",
    }

end

function unilib.pkg.mineral_boulangerite_rock.exec()

    local c_lump = "unilib:mineral_boulangerite_lump"
    local hardness = unilib.global.mineral_table["boulangerite"]["hardness"]

    unilib.register_mineral_rock("boulangerite")

    unilib.register_node("unilib:mineral_boulangerite_rock", nil, mode, {
        -- Texture from AATO, boulangerite.png. Original code
        description = S("Boulangerite Rock"),
        tiles = {"unilib_mineral_boulangerite_rock.png"},
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_boulangerite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
