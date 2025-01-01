---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decoblocks
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_dark = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.decoblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_dark.init()

    return {
        description = "Dark gravel",
        depends = "gravel_ordinary",
        optional = "mineral_flint",
    }

end

function unilib.pkg.gravel_dark.exec()

    local drop = "unilib:gravel_ordinary"
    if unilib.global.pkg_executed_table["mineral_flint"] ~= nil and
            unilib.setting.gravel_sand_bonus_rate > 0 then

        -- N.B. rarity was 15 in original code, changed to 16 to match ordinary gravel
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

    -- N.B. orig_name omitted to prevent Minetest alias warning
    unilib.register_node("unilib:gravel_dark", nil, mode, {
        -- From decoblocks, default:gravel
        description = S("Dark Gravel"),
        tiles = {"unilib_gravel_dark.png"},
        -- N.B. gravel = 1 not in original code
        groups = {crumbly = 3, falling_node = 1, gravel = 1},
        sounds = unilib.global.sound_table.gravel,

        -- N.B. rarity was 15 in original code, changed to 16 to match ordinary gravel
        drop = drop,
    })

end
