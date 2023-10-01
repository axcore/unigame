---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_painting_small = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xdecor.add_mode

local node_box = {
    type = "wallmounted",
    wall_top = {-0.4375, 0.4375, -0.3125, 0.4375, 0.5, 0.3125},
    wall_bottom = {-0.4375, -0.5, -0.3125, 0.4375, -0.4375, 0.3125},
    wall_side = {-0.5, -0.3125, -0.4375, -0.4375, 0.3125, 0.4375},
}

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_painting_small.init()

    return {
        description = "Small paintings",
        notes = "When placed, one of four paintings becomes visible at random",
        depends = "sign_wall_wood",
    }

end

function unilib.pkg.misc_painting_small.exec()

    unilib.register_node("unilib:misc_painting_small_1", "xdecor:painting_1", mode, {
        -- From xdecor:painting_1
        description = S("Small Painting"),
        tiles = {"unilib_misc_painting_small_1.png"},
        groups = {attached_node = 1, choppy = 3, flammable = 2, oddly_breakable_by_hand = 2},
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        inventory_image = "unilib_misc_painting_small_empty.png",
        node_box = node_box,
        node_placement_prediction = "",
        paramtype = "light",
        paramtype2 = "wallmounted",
        sunlight_propagates = true,
        use_texture_alpha = "opaque",
        wield_image = "unilib_misc_painting_small_empty.png",

        on_place = function(itemstack, placer, pointed_thing)

            local num = math.random(4)
            local leftover = minetest.item_place_node(
                ItemStack("unilib:misc_painting_small_" .. num), placer, pointed_thing
            )

            if leftover:get_count() == 0 and
                    not minetest.setting_getbool("creative_mode") then
                itemstack:take_item()
            end

            return itemstack

        end,
    })
    unilib.register_craft({
        -- From xdecor:painting_1
        output = "unilib:misc_painting_small_1",
        recipe = {
            {"unilib:sign_wall_wood", "group:dye"},
        },
    })

    for i = 2, 4 do

        unilib.register_node("unilib:misc_painting_small_" .. i, "xdecor:painting_" .. i, mode, {
            -- From xdecor:painting_2, etc
            -- (no description)
            tiles = {"unilib_misc_painting_small_" .. i .. ".png"},
            groups = {
                attached_node = 1,
                choppy = 3,
                flammable = 2,
                not_in_creative_inventory = 1,
                oddly_breakable_by_hand = 2,
            },
            sounds = unilib.sound_table.wood,

            drawtype = "nodebox",
            drop = "unilib:misc_painting_small_1",
            node_box = node_box,
            paramtype = "light",
            paramtype2 = "wallmounted",
            sunlight_propagates = true,
            use_texture_alpha = "opaque",
        })

    end

end
