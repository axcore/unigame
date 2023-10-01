---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_graphite_rock = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_graphite_rock.init()

    return {
        description = "Graphite rock (as mineral)",
        notes = "An alternative to the stone ores with graphite",
        depends = "mineral_graphite",
    }

end

function unilib.pkg.mineral_graphite_rock.exec()

    local c_lump = "unilib:mineral_graphite_lump"
    local hardness = unilib.mineral_table["graphite"]["hardness"]

    unilib.register_mineral_rock("graphite")

    unilib.register_node("unilib:mineral_graphite_rock", nil, mode, {
        -- Texture from PFAA, weakOreRock_graphite.png. Original code
        description = S("Graphite Rock"),
        tiles = {"unilib_mineral_graphite_rock.png"},
        groups = {cracky = 3},
        unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_graphite_rock"}, rarity = (100 * hardness)},
                {items = {c_lump .. " 2"}, rarity = (2 + hardness)},
                {items = {c_lump}},
            },
        },
    })

end
