---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_sulphur = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_sulphur.init()

    return {
        description = "Sulphur sand",
        optional = "mineral_sulphur",
    }

end

function unilib.pkg.sand_sulphur.exec()

    local drop = "unilib:sand_sulphur"
    local group_table = {crumbly = 3, falling_node = 1, sand = 1}

    if unilib.global.pkg_executed_table["mineral_sulphur"] ~= nil and
            unilib.setting.gravel_sand_bonus_rate > 0 then

        drop = {
            max_items = 1,
            items = {
                {
                    items = {"unilib:mineral_sulphur_lump"},
                    rarity = unilib.setting.gravel_sand_bonus_rate,
                },
                {items = {"unilib:sand_sulphur"}},
            },
        }

        group_table.ore = 1

    end

    unilib.register_node("unilib:sand_sulphur", nil, mode, {
        -- Texture from PFAA, weakOreSand_sulfur.png. Original code
        description = S("Sulphur Sand"),
        tiles = {"unilib_sand_sulphur.png"},
        groups = group_table,
        sounds = unilib.global.sound_table.sand,

        drop = drop,
    })

    if unilib.setting.squeezed_sand_flag then

        unilib.register_node("unilib:sand_sulphur_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Sulphur Sand"),
            tiles = {"unilib_sand_sulphur_compressed.png"},
            groups = {compressedsand = 1, crumbly = 2},
            sounds = unilib.global.sound_table.sand,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        -- Original to unilib
        unilib.misc.set_squeezed_recipes("unilib:sand_sulphur", "unilib:sand_sulphur_compressed")

    end

end
