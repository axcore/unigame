---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_bauxite_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_bauxite_rock.init()

    return {
        description = "Bauxite rock (as mineral)",
        notes = "An alternative to the stone ores with bauxite",
        depends = "mineral_bauxite",
    }

end

function unilib.pkg.mineral_bauxite_rock.exec()

    local c_lump = "unilib:mineral_bauxite_lump"
    local hardness = unilib.mineral_table["bauxite"]["hardness"]

    unilib.register_mineral_rock("bauxite")

    unilib.register_node("unilib:mineral_bauxite_rock", nil, mode, {
        -- Texture from AATO, bauxite.png. Original code
        description = S("Bauxite Rock"),
        tiles = {"unilib_mineral_bauxite_rock.png"},
        groups = {cracky = 2},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_bauxite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
