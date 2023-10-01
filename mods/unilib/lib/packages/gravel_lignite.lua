---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_lignite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_lignite.init()

    return {
        description = "Lignite gravel",
        optional = "mineral_lignite"
    }

end

function unilib.pkg.gravel_lignite.exec()

    local drop = nil
    if unilib.pkg_executed_table["mineral_lignite"] ~= nil then

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_lignite_lump"}, rarity = 16},
                {items = {"unilib:gravel_lignite"}},
            },
        }

    end

    unilib.register_node("unilib:gravel_lignite", nil, mode, {
        -- Texture from UGBC, lignite_gravel.png. Original code
        description = S("Lignite Gravel"),
        tiles = {"unilib_gravel_lignite.png"},
        groups = {crumbly = 3, falling_node = 1},
        sounds = unilib.sound_table.gravel,

        drop = drop,
    })

end
