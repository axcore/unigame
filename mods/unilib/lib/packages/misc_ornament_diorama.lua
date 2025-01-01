---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nbea
-- Code:    WTFPL
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_ornament_diorama = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.nbea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_ornament_diorama.init()

    return {
        description = "Minetest diorama",
        notes = "Break the framed diorama to get a model",
        depends = {
            "dirt_ordinary",
            "grass_ordinary",
            "mineral_coal",
            "plant_cactus_ordinary",
            "sand_ordinary",
            "stone_ordinary",
            "tree_apple",
        },
        optional = "misc_frame_wood_simple",
    }

end

function unilib.pkg.misc_ornament_diorama.exec()

    local img = "unilib_misc_frame_wood_overlay.png"

    unilib.register_node("unilib:misc_ornament_diorama", "nbea:nbox_014", mode, {
        -- From nbea:nbox_014
        description = S("Minetest Diorama"),
        tiles = {
            "unilib_misc_ornament_diorama_top.png^" .. img,
            "unilib_misc_ornament_diorama_bottom.png^" .. img,
            "unilib_misc_ornament_diorama_right.png^" .. img,
            "unilib_misc_ornament_diorama_left.png^" .. img,
            "unilib_misc_ornament_diorama_back.png^" .. img,
            "unilib_misc_ornament_diorama_front.png^" .. img,
        },
        groups = {oddly_breakable_by_hand = 3},
        sounds = unilib.sound.generate_wood({
            footstep = {name = "unilib_glass_footstep", gain = 0.5},
            dug = {name = "unilib_break_glass", gain = 1.0},
        }),

        drawtype = "nodebox",
        drop = "",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.4375, -0.4375, -0.4375, 0.0625, 0.0625, 0.0625},
                {-0.4375, -0.4375, 0.0625, -0.1875, 0.0625, 0.4375},
                {-0.1875, -0.4375, 0.0625, 0.4375, 0, 0.4375},
                {0.0625, -0.4375, -0.4375, 0.4375, -0.125, 0.0625},
                {-0.4375, 0.1875, -0.4375, -0.125, 0.4375, -0.125},
                {-0.3125, 0.0625, -0.3125, -0.25, 0.1875, -0.25},
                {0.25, 0, 0.25, 0.375, 0.3125, 0.375},
                {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
                -- Corner frame
                {-0.4375, 0.4375, 0.4375, 0.4375, 0.5, 0.5},
                {-0.4375, -0.5, 0.4375, 0.4375, -0.4375, 0.5},
                {-0.5, -0.5, 0.4375, -0.4375, 0.5, 0.5},
                {0.4375, -0.5, 0.4375, 0.5, 0.5, 0.5},
                {-0.5, 0.4375, -0.4375, -0.4375, 0.5, 0.4375},
                {-0.5, -0.5, -0.4375, -0.4375, -0.4375, 0.4375},
                {0.4375, 0.4375, -0.4375, 0.5, 0.5, 0.4375},
                {0.4375, -0.5, -0.4375, 0.5, -0.4375, 0.4375},
                {-0.5, 0.4375, -0.5, 0.5, 0.5, -0.4375},
                {-0.5, -0.5, -0.5, 0.5, -0.4375, -0.4375},
                {0.4375, -0.4375, -0.5, 0.5, 0.4375, -0.4375},
                {-0.5, -0.4375, -0.5, -0.4375, 0.4375, -0.4375},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            },
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",

        after_destruct = function(pos,node)

            core.set_node(
                pos,
                {name = "unilib:misc_ornament_diorama_model", param2 = node.param2}
            )

        end,
    })
    if not unilib.global.use_unipanes_flag then

        unilib.register_craft({
            -- From nbea:nbox_014
            output = "unilib:misc_ornament_diorama",
            recipe = {
                {"group:stick", "group:pane", "group:stick"},
                {"group:pane", "unilib:misc_ornament_diorama_model", "group:pane"},
                {"group:stick", "group:pane", "group:stick"},
            },
        })

    else

        unilib.register_craft({
            -- From nbea:nbox_014
            output = "unilib:misc_ornament_diorama",
            recipe = {
                {"group:stick", "group:unipane", "group:stick"},
                {"group:unipane", "unilib:misc_ornament_diorama_model", "group:unipane"},
                {"group:stick", "group:unipane", "group:stick"},
            },
        })

    end
    if unilib.global.pkg_executed_table["misc_frame_wood_simple"] ~= nil then

        unilib.register_craft({
            -- From nbea:nbox_014
            type   = "shapeless",
            output = "unilib:misc_ornament_diorama",
            recipe = {"unilib:misc_frame_wood_simple", "unilib:misc_ornament_diorama_model"},
        })

    end

    unilib.register_node("unilib:misc_ornament_diorama_model", "nbea:nbox_013", mode, {
        -- From nbea:nbox_013
        description = S("Minetest Diorama Model"),
        tiles = {
            "unilib_misc_ornament_diorama_top.png",
            "unilib_misc_ornament_diorama_bottom.png",
            "unilib_misc_ornament_diorama_right.png",
            "unilib_misc_ornament_diorama_left.png",
            "unilib_misc_ornament_diorama_back.png",
            "unilib_misc_ornament_diorama_front.png",
        },
        -- N.B. not_in_creative_inventory = 1 removed from original code, so that the model can be
        --      used as a crafting ingredient (as in the original code)
--      groups = {falling_node = 1, not_in_creative_inventory = 1, oddly_breakable_by_hand = 3},
        groups = {falling_node = 1, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.0625, 0.0625, 0.0625},
                {-0.5, -0.5, 0.0625, -0.1875, 0.0625, 0.5},
                {-0.1875, -0.5, 0.0625, 0.5, 0, 0.5},
                {0.0625, -0.5, -0.5, 0.5, -0.125, 0.0625},
                {-0.4375, 0.1875, -0.4375, -0.125, 0.4375, -0.125},
                {-0.3125, 0.0625, -0.3125, -0.25, 0.1875, -0.25},
                {0.25, 0, 0.25, 0.375, 0.3125, 0.375},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.4375, 0.5},
            },
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",
    })

end

function unilib.pkg.misc_ornament_diorama.post()

    for bucket_type, _ in pairs(unilib.global.generic_bucket_table) do

        local c_water_bucket = "unilib:" .. bucket_type .. "_with_water_ordinary"
        local c_empty_bucket = "unilib:" .. bucket_type .. "_empty"

        unilib.register_craft({
            -- Original to unilib
            type = "shapeless",
            output = "unilib:misc_ornament_diorama_model",
            recipe = {
                "unilib:stone_ordinary",
                "unilib:dirt_ordinary",
                "unilib:sand_ordinary",
                "unilib:mineral_coal_lump",
                "unilib:plant_cactus_ordinary",
                "unilib:tree_apple_trunk",
                "unilib:tree_apple_leaves",
                "unilib:grass_ordinary",
                c_water_bucket,
            },
            replacements = {
                {c_water_bucket, c_empty_bucket},
            },
        })

    end

end
