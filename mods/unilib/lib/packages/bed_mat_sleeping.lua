---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.bed_mat_sleeping = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cottages.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bed_mat_sleeping.init()

    return {
        description = "Decorative sleeping mat",
        notes = "A decorative bed (does not advance the game time, like a real bed)",
        depends = "shared_cottages",
    }

end

function unilib.pkg.bed_mat_sleeping.exec()

    unilib.register_node("unilib:bed_mat_sleeping", "cottages:sleeping_mat", mode, {
        -- From cottages:sleeping_mat
        description = S("Decorative sleeping Mat"),
        tiles = {"unilib_bed_mat_sleeping.png"},
        groups = {snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "nodebox",
        -- N.B. Removed ,so that this item and "unilib:bed_mat_straw" are rotated the same way in
        --      the player's inventory
--      inventory_image = "unilib_bed_mat_sleeping.png",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.48, -0.5,-0.48, 0.48, -0.5+1/16, 0.48},
            },
        },
        paramtype = 'light',
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.48, -0.5, -0.48, 0.48, -0.5+2/16, 0.48},
            },
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_bed_mat_sleeping.png",

        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)

            return unilib.pkg.shared_cottages.sleep_in_bed(
                pos, node, clicker, itemstack, pointed_thing
            )

        end,
    })
    unilib.register_craft({
        -- From cottages:sleeping_mat
        output = "unilib:bed_mat_sleeping 3",
        recipe = {
            {"unilib:misc_flooring_wool", "unilib:bed_mat_straw", "unilib:bed_mat_straw"},
        },
    })

    -- Notes from cottages:
    -- This one has a pillow for the head; thus, param2 becomes visible to the builder, and mobs may
    --      use it as a bed
    unilib.register_node("unilib:bed_mat_sleeping_head", "cottages:sleeping_mat_head", mode, {
        -- From cottages:sleeping_mat_head
        description = S("Decorative Sleeping Mat with Pillow"),
        tiles = {"unilib_bed_mat_sleeping.png"},
        groups = {snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "nodebox",
        -- N.B. Removed ,so that this item and "unilib:bed_mat_straw" are rotated the same way in
        --      the player's inventory
--      inventory_image = "unilib_bed_mat_sleeping.png",
        is_ground_content = false,
        -- (In original code, pillow was lower and harder to see)
        node_box = {
            type = "fixed",
            fixed = {
                {-0.48, -0.5, -0.48, 0.48, -0.5+1/16, 0.48},
--              {-0.34, -0.5+1/16, -0.12, 0.34, -0.5+2/16, 0.34},
                {-0.34, -0.5+3/16, -0.12, 0.34, -0.5+2/16, 0.34},
            },
        },
        paramtype = 'light',
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.48, -0.5,-0.48, 0.48, -0.5+2/16, 0.48},
            },
        },
        sunlight_propagates = true,
        wield_image = "unilib_bed_mat_sleeping.png",

        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)

            return unilib.pkg.shared_cottages.sleep_in_bed(
                pos, node, clicker, itemstack, pointed_thing
            )

        end,
    })
    unilib.register_craft({
        -- From cottages:sleeping_mat_head
        output = "unilib:bed_mat_sleeping_head",
        recipe = {
            {"unilib:bed_mat_sleeping", "unilib:bed_mat_straw"},
        },
    })

end
