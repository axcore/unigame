---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_ordinary_with_algae = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_ordinary_with_algae.init()

    return {
        description = "Ordinary gravel with algae",
        depends = "gravel_ordinary",
        optional = "mineral_flint",
    }

end

function unilib.pkg.gravel_ordinary_with_algae.exec()

    local drop = "unilib:gravel_ordinary"
    if unilib.global.pkg_executed_table["mineral_flint"] ~= nil and
            unilib.setting.gravel_sand_bonus_rate > 0 then

        drop = {
            max_items = 1,
            items = {
                {
                    items = {"unilib:mineral_flint_lump"},
                    rarity = unilib.setting.gravel_sand_bonus_rate,
                },
                {items = {"unilib:gravel_ordinary"}},
            },
        }

    end

    unilib.register_node("unilib:gravel_ordinary_with_algae", "aotearoa:gravel_with_algae", mode, {
        -- From aotearoa:gravel_with_algae
        description = S("Gravel with Algae"),
        tiles = {"unilib_gravel_ordinary_with_algae.png"},
        -- N.B. gravel = 1 not in original code
        groups = {crumbly = 2, falling_node = 1, gravel = 1},
        sounds = unilib.global.sound_table.gravel,

        drop = drop,
    })

end
