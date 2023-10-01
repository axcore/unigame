---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decoblocks
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_dark = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.decoblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_dark.init()

    return {
        description = "Dark gravel",
        depends = "mineral_flint",
    }

end

function unilib.pkg.gravel_dark.exec()

    -- N.B. orig_name omitted to prevent Minetest alias warning
    unilib.register_node("unilib:gravel_dark", nil, mode, {
        -- From decoblocks, default:gravel
        description = S("Dark Gravel"),
        tiles = {"unilib_gravel_dark.png"},
        groups = {crumbly = 3, falling_node = 1},
        sounds = unilib.sound_table.gravel,

        -- N.B. rarity was 15 in original code, changed to 16 to match ordinary gravel
        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_flint_lump"}, rarity = 16},
                {items = {"unilib:gravel_ordinary"}}
            }
        }
    })

end
