---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_lignite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

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

    local drop = "unilib:gravel_lignite"
    if unilib.global.pkg_executed_table["mineral_lignite"] ~= nil and
            unilib.setting.gravel_sand_bonus_rate > 0 then

        drop = {
            max_items = 1,
            items = {
                {
                    items = {"unilib:mineral_lignite_lump"},
                    rarity = unilib.setting.gravel_sand_bonus_rate,
                },
                {items = {"unilib:gravel_lignite"}},
            },
        }

    end

    unilib.register_node("unilib:gravel_lignite", nil, mode, {
        -- Texture from UGBC, lignite_gravel.png. Original code
        description = S("Lignite Gravel"),
        tiles = {"unilib_gravel_lignite.png"},
        groups = {crumbly = 3, falling_node = 1, gravel = 1},
        sounds = unilib.global.sound_table.gravel,

        drop = drop,
    })

end
