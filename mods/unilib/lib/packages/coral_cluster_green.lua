---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_cluster_green = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_cluster_green.init()

    return {
        description = "Green cluster coral",
    }

end

function unilib.pkg.coral_cluster_green.exec()

    unilib.register_node("unilib:coral_cluster_green", "australia:cluster_coral_green", mode, {
        -- From australia:cluster_coral_green
        description = unilib.utils.annotate(S("Green Cluster Coral"), "Acropora millepora"),
        tiles = {"unilib_coral_cluster_green.png"},
        groups = {attached_node = 1, coral = 1, cracky = 3, sea = 1, stone = 1},
        sounds = unilib.global.sound_table.stone,

        climbable = true,
        drawtype = "plantlike",
        drowning = 1,
        inventory_image = "unilib_coral_cluster_green.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
        },
        walkable = false,
        wield_image = "unilib_coral_cluster_green.png",

        -- N.B. No .on_place() in original code
        on_place = function(itemstack, placer, pointed_thing)

            return unilib.misc.place_in_medium(
                itemstack, placer, pointed_thing,
                {need_under = "group:sand"}
            )

        end,
    })

end
