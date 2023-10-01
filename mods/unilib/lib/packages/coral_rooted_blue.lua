---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_rooted_blue = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_rooted_blue.init()

    return {
        description = "Blue rooted coral",
    }

end

function unilib.pkg.coral_rooted_blue.exec()

    unilib.register_node("unilib:coral_rooted_blue", "mapgen:blue_coral", mode, {
        -- From mapgen:blue_coral
        description = S("Blue Rooted Coral"),
        tiles = {"unilib_coral_rooted_blue.png"},
        groups = {attached_node = 1, flammable = 1, sea = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_coral_rooted_blue.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
    })

end
