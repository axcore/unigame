---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_nepheline_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_nepheline_rock.init()

    return {
        description = "Nepheline rock (as mineral)",
        notes = "An alternative to the stone ores with nepheline",
        depends = "mineral_nepheline",
    }

end

function unilib.pkg.mineral_nepheline_rock.exec()

    local c_lump = "unilib:mineral_nepheline_lump"
    local hardness = unilib.global.mineral_table["nepheline"]["hardness"]

    unilib.register_mineral_rock("nepheline")

    unilib.register_node("unilib:mineral_nepheline_rock", nil, mode, {
        -- Texture from AATO, nepheline.png. Original code
        description = S("Nepheline Rock"),
        tiles = {"unilib_mineral_nepheline_rock.png"},
        groups = {cracky = 1},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_nepheline_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
