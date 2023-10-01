---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ropes
-- Code:    MIT
-- Media:   unknown (textures), CC0 (sounds)
---------------------------------------------------------------------------------------------------

unilib.pkg.ladder_wood_extendable = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ropes.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ladder_wood_extendable.init()

    return {
        description = "Extendable wooden ladder",
        notes = "Place an extendable ladder at the desired lowest position, then right-click to" ..
                " extend it, up to a maximum height",
        depends = "shared_ropes",
    }

end

function unilib.pkg.ladder_wood_extendable.exec()

    unilib.register_node("unilib:ladder_wood_extendable", "ropes:ladder_wood", mode, {
        -- From ropes:ladder_wood
        description = S("Extendable Wooden Ladder"),
        tiles = {
            "unilib_tree_apple_wood.png",
            "unilib_tree_apple_wood.png",
            "unilib_tree_apple_wood.png^[transformR270",
            "unilib_tree_apple_wood.png^[transformR270",
            "unilib_ladder_wood_ordinary.png",
        },
        groups = {choppy = 2, flammable = 2, flow_through = 1, oddly_breakable_by_hand = 3},
        sounds = unilib.sound_table.wood,

        climbable = true,
        drawtype = "nodebox",
        inventory_image = "unilib_ladder_wood_ordinary.png",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.375, -0.5, 0.375, -0.25, 0.5, 0.5},
                {0.25, -0.5, 0.375, 0.375, 0.5, 0.5},
                {-0.4375, 0.3125, 0.4375, 0.4375, 0.4375, 0.5},
                {-0.4375, -0.1875, 0.4375, 0.4375, -0.0625, 0.5},
                {-0.4375, -0.4375, 0.4375, 0.4375, -0.3125, 0.5},
                {-0.4375, 0.0625, 0.4375, 0.4375, 0.1875, 0.5},
            }
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        walkable = false,
        wield_image = "unilib_ladder_wood_ordinary.png",

        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)

            return unilib.pkg.shared_ropes.ladder_extender(
                pos,
                node,
                clicker,
                itemstack,
                pointed_thing,
                "unilib:ladder_wood_extendable",
                -- Maximum height of the (whole) extended section of the ladder
                5
            )

        end,
    })
    unilib.register_craft({
        -- From ropes:ladder_wood
        output = "unilib:ladder_wood_extendable 5",
        recipe = {
            {"group:stick", "group:stick", "group:stick"},
            {"group:stick", "", "group:stick"},
            {"group:stick", "", "group:stick"},
        },
    })

end
