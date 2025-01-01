---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_arsenopyrite_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_arsenopyrite_rock.init()

    return {
        description = "Arsenopyrite rock (as mineral)",
        notes = "An alternative to the stone ores with arsenopyrite",
        depends = "mineral_arsenopyrite",
    }

end

function unilib.pkg.mineral_arsenopyrite_rock.exec()

    local c_lump = "unilib:mineral_arsenopyrite_lump"
    local hardness = unilib.global.mineral_table["arsenopyrite"]["hardness"]

    unilib.register_mineral_rock("arsenopyrite")

    unilib.register_node("unilib:mineral_arsenopyrite_rock", nil, mode, {
        -- Texture from AATO, arsenopyrite.png. Original code
        description = S("Arsenopyrite Rock"),
        tiles = {"unilib_mineral_arsenopyrite_rock.png"},
        groups = {cracky = 1},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_arsenopyrite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
