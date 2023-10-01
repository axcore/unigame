---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_nickeline_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_nickeline_rock.init()

    return {
        description = "Nickeline rock (as mineral)",
        notes = "An alternative to the stone ores with nickeline",
        depends = "mineral_nickeline",
    }

end

function unilib.pkg.mineral_nickeline_rock.exec()

    local c_lump = "unilib:mineral_nickeline_lump"
    local hardness = unilib.mineral_table["nickeline"]["hardness"]

    unilib.register_mineral_rock("nickeline")

    unilib.register_node("unilib:mineral_nickeline_rock", nil, mode, {
        -- Texture from AATO, nickeline.png. Original code
        description = S("Nickeline Rock"),
        tiles = {"unilib_mineral_nickeline_rock.png"},
        groups = {cracky = 1},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_nickeline_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
