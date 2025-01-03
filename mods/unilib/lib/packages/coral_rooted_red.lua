---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_rooted_red = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_rooted_red.init()

    return {
        description = "Red rooted coral",
    }

end

function unilib.pkg.coral_rooted_red.exec()

    unilib.register_node("unilib:coral_rooted_red", "mapgen:red_coral", mode, {
        -- From farlands, mapgen:red_coral
        description = S("Red Rooted Coral"),
        tiles = {"unilib_coral_rooted_red.png"},
        -- N.B. No coral = 1 in original code
        groups = {attached_node = 1, coral = 1, flammable = 1, sea = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_coral_rooted_red.png",
        -- N.B. removed .is_ground_content = false to match other corals
--      is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,

        -- N.B. No .on_place() in original code
        on_place = function(itemstack, placer, pointed_thing)

            return unilib.misc.place_in_medium(
                itemstack, placer, pointed_thing,
                {need_under = "group:sand"}
            )

        end,
    })

end
