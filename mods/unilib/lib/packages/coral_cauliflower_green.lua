---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_cauliflower_green = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_cauliflower_green.init()

    return {
        description = "Green cauliflower coral",
    }

end

function unilib.pkg.coral_cauliflower_green.exec()

    unilib.register_node(
        -- From australia:cauliflower_coral_green
        "unilib:coral_cauliflower_green",
        "australia:cauliflower_coral_green",
        mode,
        {
            description = unilib.annotate(S("Green Cauliflower Coral"), "Pocillopora damicornis"),
            tiles = {"unilib_coral_cauliflower_green.png"},
            groups = {attached_node = 1, coral = 1, cracky = 3, sea = 1, stone = 1},
            sounds = unilib.sound_table.leaves,

            climbable = true,
            drawtype = "plantlike",
            drowning = 1,
            inventory_image = "unilib_coral_cauliflower_green.png",
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
            },
            visual_scale = 0.75,
            walkable = false,
            wield_image = "unilib_coral_cauliflower_green.png",
        }
    )

end
