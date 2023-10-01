---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_columbite_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_columbite_rock.init()

    return {
        description = "Columbite rock (as mineral)",
        notes = "An alternative to the stone ores with columbite",
        depends = "mineral_columbite",
    }

end

function unilib.pkg.mineral_columbite_rock.exec()

    local c_lump = "unilib:mineral_columbite_lump"
    local hardness = unilib.mineral_table["columbite"]["hardness"]

    unilib.register_mineral_rock("columbite")

    unilib.register_node("unilib:mineral_columbite_rock", nil, mode, {
        -- Texture from AATO, columbite.png. Original code
        description = S("Columbite Rock"),
        tiles = {"unilib_mineral_columbite_rock.png"},
        groups = {cracky = 1},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_columbite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
