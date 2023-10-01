---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_staghorn_yellow = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_staghorn_yellow.init()

    return {
        description = "Yellow staghorn coral",
    }

end

function unilib.pkg.coral_staghorn_yellow.exec()

    unilib.register_node("unilib:coral_staghorn_yellow", "australia:staghorn_coral_yellow", mode, {
        -- From australia:staghorn_coral_yellow
        description = unilib.annotate(S("Yellow Staghorn Coral"), "Acropora cervicornis"),
        tiles = {"unilib_coral_staghorn_yellow.png"},
        groups = {attached_node = 1, coral = 1, cracky = 3, sea = 1, stone = 1},
        sounds = unilib.sound_table.stone,

        buildable_to = false,
        climbable = true,
        drawtype = "plantlike",
        drowning = 1,
        inventory_image = "unilib_coral_staghorn_yellow.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
        },
        sunlight_propagates = true,
        visual_scale = 1.0,
        walkable = false,
        waving = 0,
        wield_image = "unilib_coral_staghorn_yellow.png",
    })

end
