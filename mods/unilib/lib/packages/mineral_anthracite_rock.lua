---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_anthracite_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_anthracite_rock.init()

    return {
        description = "Anthracite rock (as mineral)",
        notes = "An alternative to the stone ores with anthracite",
        depends = "mineral_anthracite",
    }

end

function unilib.pkg.mineral_anthracite_rock.exec()

    local c_lump = "unilib:mineral_anthracite_lump"
    local hardness = unilib.mineral_table["anthracite"]["hardness"]

    unilib.register_mineral_rock("anthracite")

    unilib.register_node("unilib:mineral_anthracite_rock", nil, mode, {
        -- Texture from AATO, anthracite_block.png. Original code
        description = S("Anthracite Rock"),
        tiles = {"unilib_mineral_anthracite_rock.png"},
        groups = {cracky = 2},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_anthracite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
