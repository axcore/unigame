---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_lignite_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_lignite_rock.init()

    return {
        description = "Lignite rock (as mineral)",
        notes = "An alternative to the stone ores with lignite",
        depends = "mineral_lignite",
    }

end

function unilib.pkg.mineral_lignite_rock.exec()

    local c_lump = "unilib:mineral_lignite_lump"
    local hardness = unilib.mineral_table["lignite"]["hardness"]

    unilib.register_mineral_rock("lignite")

    unilib.register_node("unilib:mineral_lignite_rock", nil, mode, {
        -- Texture from AATO, lignite_ore.png. Original code
        description = S("Lignite Rock"),
        tiles = {"unilib_mineral_lignite_rock.png"},
        groups = {cracky = 2},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_lignite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
