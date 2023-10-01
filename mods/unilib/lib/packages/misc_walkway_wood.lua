---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_walkway_wood = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_walkway_wood.init()

    return {
        description = "Wooden plank walkway",
        notes = "Ideal for placing on quicksand",
    }

end

function unilib.pkg.misc_walkway_wood.exec()

    unilib.register_node("unilib:misc_walkway_wood", "decoblocks:plank_walkway", mode, {
        -- From farlands, decoblocks:plank_walkway
        description = S("Wooden Plank Walkway"),
        tiles = {
            "unilib_misc_walkway_wood.png",
            "unilib_misc_walkway_wood.png",
            "unilib_tree_apple_wood.png",
        },
        groups = {choppy = 1},
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, 0.4375, -0.5, -0.3125, 0.5, 0.5},
                {-0.25, 0.4375, -0.4375, -0.0625, 0.5, 0.5},
                {0, 0.4375, -0.5, 0.1875, 0.5, 0.5},
                {0.25, 0.4375, -0.375, 0.4375, 0.5, 0.5},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    -- N.B. Original craft recipe conflicts with recipe in "machine_furnace_ordinary" package
    --[[
    unilib.register_craft({
        -- From farlands, decoblocks:plank_walkway
        output = "unilib:misc_walkway_wood 12",
        recipe = {
            {"group:wood", "", "group:wood"},
            {"group:wood", "", "group:wood"},
            {"group:wood", "", "group:wood"},
        }
    })
    ]]--
    unilib.register_craft({
        -- From farlands, decoblocks:plank_walkway
        output = "unilib:misc_walkway_wood 14",
        recipe = {
            {"group:wood", "", "group:wood"},
            {"group:wood", "group:wood", "group:wood"},
            {"group:wood", "", "group:wood"},
        }
    })

end
