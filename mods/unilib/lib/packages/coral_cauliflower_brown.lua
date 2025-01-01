---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_cauliflower_brown = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_cauliflower_brown.init()

    return {
        description = "Brown cauliflower coral",
    }

end

function unilib.pkg.coral_cauliflower_brown.exec()

    unilib.register_node(
        -- From australia:cauliflower_coral_brown
        "unilib:coral_cauliflower_brown",
        "australia:cauliflower_coral_brown",
        mode,
        {
            description = unilib.utils.annotate(
                S("Brown Cauliflower Coral"), "Pocillopora damicornis"
            ),
            tiles = {"unilib_coral_cauliflower_brown.png"},
            groups = {attached_node = 1, coral = 1, cracky = 3, sea = 1, stone = 1},
            sounds = unilib.global.sound_table.leaves,

            climbable = true,
            drawtype = "plantlike",
            drowning = 1,
            inventory_image = "unilib_coral_cauliflower_brown.png",
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
            },
            visual_scale = 0.75,
            walkable = false,
            wield_image = "unilib_coral_cauliflower_brown.png",

            -- N.B. No .on_place() in original code
            on_place = function(itemstack, placer, pointed_thing)

                return unilib.misc.place_in_medium(
                    itemstack, placer, pointed_thing,
                    {need_under = "group:sand"}
                )

            end,
        }
    )

end
