---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_cluster_orange = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_cluster_orange.init()

    return {
        description = "Orange cluster coral",
    }

end

function unilib.pkg.coral_cluster_orange.exec()

    unilib.register_node("unilib:coral_cluster_orange", "australia:cluster_coral_orange", mode, {
        -- From australia:cluster_coral_orange
        description = unilib.annotate(S("Orange Cluster Coral"), "Acropora millepora"),
        tiles = {"unilib_coral_cluster_orange.png"},
        groups = {attached_node = 1, coral = 1, cracky = 3, sea = 1, stone = 1},
        sounds = unilib.sound_table.stone,

        climbable = true,
        drawtype = "plantlike",
        drowning = 1,
        inventory_image = "unilib_coral_cluster_orange.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
        },
        walkable = false,
        wield_image = "unilib_coral_cluster_orange.png",
    })

end
