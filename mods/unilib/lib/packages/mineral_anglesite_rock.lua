---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_anglesite_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_anglesite_rock.init()

    return {
        description = "Anglesite rock (as mineral)",
        notes = "An alternative to the stone ores with anglesite",
        depends = "mineral_anglesite",
    }

end

function unilib.pkg.mineral_anglesite_rock.exec()

    local c_lump = "unilib:mineral_anglesite_lump"
    local hardness = unilib.mineral_table["anglesite"]["hardness"]

    unilib.register_mineral_rock("anglesite")

    unilib.register_node("unilib:mineral_anglesite_rock", nil, mode, {
        -- Texture from AATO, anglesite.png. Original code
        description = S("Anglesite Rock"),
        tiles = {"unilib_mineral_anglesite_rock.png"},
        groups = {cracky = 3},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_anglesite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
