---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_lignite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_lignite.init()

    return {
        description = "Lignite clay",
        optional = "mineral_lignite",
    }

end

function unilib.pkg.clay_lignite.exec()

    local drop = nil
    if unilib.pkg_executed_table["mineral_lignite"] ~= nil then

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_lignite_lump"}, rarity = 15},
                {items = {"unilib:clay_lignite"}}
            },
        }

    end


    unilib.register_node("unilib:clay_lignite", nil, mode, {
        -- Texture from UGBC, lignite_clay.png. Original code
        description = S("Lignite Clay"),
        tiles = {"unilib_clay_lignite.png"},
        groups = {crumbly = 3},
        sounds = unilib.sound_table.dirt,

        drop = drop,
    })

end
