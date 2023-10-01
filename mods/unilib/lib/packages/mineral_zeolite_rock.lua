---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_zeolite_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_zeolite_rock.init()

    return {
        description = "Zeolite rock (as mineral)",
        notes = "An alternative to the stone ores with zeolite",
        depends = "mineral_zeolite",
    }

end

function unilib.pkg.mineral_zeolite_rock.exec()

    local c_lump = "unilib:mineral_zeolite_lump"
    local hardness = unilib.mineral_table["zeolite"]["hardness"]

    unilib.register_mineral_rock("zeolite")

    unilib.register_node("unilib:mineral_zeolite_rock", nil, mode, {
        -- Texture from PFAA, mediumOreRock_zeolite.png. Original code
        description = S("Zeolite Rock"),
        tiles = {"unilib_mineral_zeolite_rock.png"},
        groups = {cracky = 2},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_zeolite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
