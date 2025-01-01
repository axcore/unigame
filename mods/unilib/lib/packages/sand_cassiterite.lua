---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_cassiterite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_cassiterite.init()

    return {
        description = "Cassiterite sand",
        depends = "sand_ordinary",
        optional = "mineral_cassiterite",
    }

end

function unilib.pkg.sand_cassiterite.exec()

    local drop = "unilib:sand_ordinary"
    local group_table = {crumbly = 3, falling_node = 1, sand = 1}

    if unilib.global.pkg_executed_table["mineral_cassiterite"] ~= nil and
            unilib.setting.gravel_sand_bonus_rate > 0 then

        drop = {
            max_items = 1,
            items = {
                {
                    items = {"unilib:mineral_cassiterite_lump"},
                    rarity = unilib.setting.gravel_sand_bonus_rate,
                },
                {items = {"unilib:sand_ordinary"}},
            },
        }

        group_table.ore = 1

    end

    unilib.register_node("unilib:sand_cassiterite", nil, mode, {
        -- Texture from PFAA, weakOreSand_cassiteriteSand.png. Original code
        description = S("Cassiterite Sand"),
        tiles = {"unilib_sand_cassiterite.png"},
        groups = group_table,
        sounds = unilib.global.sound_table.sand,

        drop = drop,
    })

end
