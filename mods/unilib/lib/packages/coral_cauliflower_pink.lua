---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_cauliflower_pink = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_cauliflower_pink.init()

    return {
        description = "Pink cauliflower coral",
    }

end

function unilib.pkg.coral_cauliflower_pink.exec()

    unilib.register_node(
        -- From australia:cauliflower_coral_pink
        "unilib:coral_cauliflower_pink",
        "australia:cauliflower_coral_pink",
        mode,
        {
            description = unilib.annotate(S("Pink Cauliflower Coral"), "Pocillopora damicornis"),
            tiles = {"unilib_coral_cauliflower_pink.png"},
            groups = {attached_node = 1, coral = 1, cracky = 3, sea = 1, stone = 1},
            sounds = unilib.sound_table.leaves,

            climbable = true,
            drawtype = "plantlike",
            drowning = 1,
            visual_scale = 0.75,
            inventory_image = "unilib_coral_cauliflower_pink.png",
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
            },
            walkable = false,
            wield_image = "unilib_coral_cauliflower_pink.png",
        }
    )

end
