---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.bed_decorative = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cottages.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bed_decorative.init()

    return {
        description = "Decorative bed",
        notes = "This bed is not for sleeping, it really is just decorative",
        depends = {"shared_cottages", "wool_basic"},
    }

end

function unilib.pkg.bed_decorative.exec()

    unilib.register_node("unilib:bed_decorative_foot", "cottages:bed_foot", mode, {
        -- From cottages:bed_foot
        description = unilib.brackets(S("Decorative Bed"), S("Foot")),
        tiles = {
            "unilib_bed_decorative_top_bottom.png",
            "unilib_tree_apple_wood.png",
            "unilib_bed_decorative_side.png",
            "unilib_bed_decorative_side.png",
            "unilib_bed_decorative_side.png",
            "unilib_bed_decorative_side.png",
        },
        groups = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, snappy = 1},
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, 0.0, -0.5, 0.5, 0.3, 0.5},
                {-0.5, -0.5, -0.5, -0.4, 0.5, -0.4},
                { 0.4, -0.5, -0.5, 0.5, 0.5, -0.4},
                {-0.4, 0.3, -0.5, 0.4, 0.5, -0.4}
            }
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.3, 0.5},
            }
        },

        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)

            return unilib.pkg.shared_cottages.sleep_in_bed(
                pos, node, clicker, itemstack, pointed_thing
            )

        end
    })
    unilib.register_craft({
        -- From cottages:bed_foot
        output = "unilib:bed_decorative_foot",
        recipe = {
            {"unilib:wool_white", "", ""},
            {"group:wood", "", ""},
            {"group:stick", "", ""}
        }
    })

    -- Notes from cottages:
    -- The bed is split up in two parts to avoid destruction of blocks on placement
    unilib.register_node("unilib:bed_decorative_head", "cottages:bed_head", mode, {
        -- From cottages:bed_head
        description = unilib.brackets(S("Decorative Bed"), S("Head")),
        tiles = {
            "unilib_bed_decorative_top_top.png",
            "unilib_tree_apple_wood.png",
            "unilib_bed_decorative_top_right.png",
            "unilib_bed_decorative_top_left.png",
            "unilib_tree_apple_wood.png",
            "unilib_bed_decorative_side.png",
        },
        groups = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, snappy = 1},
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, 0.0, -0.5, 0.5, 0.3, 0.5},
                {-0.5, -0.5, 0.4, -0.4, 0.5, 0.5},
                { 0.4, -0.5, 0.4, 0.5, 0.5, 0.5},
                {-0.4, 0.3, 0.4, 0.4, 0.5, 0.5}
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.3, 0.5},
            }
        },

        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)

            return unilib.pkg.shared_cottages.sleep_in_bed(
                pos, node, clicker, itemstack, pointed_thing
            )

        end
    })
    unilib.register_craft({
        -- From cottages:bed_head
        output = "unilib:bed_decorative_head",
        recipe = {
            {"", "", "unilib:wool_white"},
            {"", "group:stick", "group:wood"},
            {"", "", "group:stick"}
        }
    })

end
