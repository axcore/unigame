---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_brain = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_brain.init()

    return {
        description = "Brain coral",
    }

end

function unilib.pkg.coral_brain.exec()

    unilib.register_node("unilib:coral_brain", "australia:brain_coral", mode, {
        -- From australia:brain_coral
        description = unilib.annotate(S("Brain Coral"), "Dipsastraea speciosa"),
        tiles = {"unilib_coral_brain.png"},
        groups = {attached_node = 1, coral = 1, cracky = 3, sea = 1, stone = 1},
        sounds = unilib.sound_table.leaves,

        drawtype = "nodebox",
        -- N.B. Removed image so user can see the item's unique shape in inventory
--      inventory_image = "unilib_coral_brain.png",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.125, -0.5, -0.125, 0.125, 0.5, 0.125},
                {-0.1875, -0.5, -0.1875, 0.1875, 0.4375, 0.1875},
                {-0.25, -0.5, -0.25, 0.25, 0.375, 0.25},
                {-0.3125, -0.5, -0.3125, 0.3125, 0.3125, 0.3125},
                {-0.375, -0.5, -0.375, 0.375, 0.25, 0.375},
                {-0.4375, -0.4375, -0.4375, 0.4375, 0.1875, 0.4375},
                {-0.5, -0.375, -0.5, 0.5, 0.125, 0.5},
            },
        },
        paramtype = "light",
        -- N.B. Removed image so user can see the item's unique shape in their hand
--      wield_image = "unilib_coral_brain.png",
    })

end
