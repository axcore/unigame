---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_painting_small = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

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
        description = "Small painting set",
        notes = "When placed, one of up to twenty paintings becomes visible at random",
        depends = "sign_wall_wood",
    }

end

function unilib.pkg.misc_painting_small.exec()

    unilib.register_node("unilib:misc_painting_small_1", "xdecor:painting_1", mode, {
        -- From xdecor:painting_1
        description = S("Small Painting"),
        tiles = {"unilib_misc_painting_small_1.png", "unilib_misc_painting_frame_small.png"},
        groups = {attached_node = 1, choppy = 3, flammable = 2, oddly_breakable_by_hand = 2},
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        inventory_image = "unilib_misc_painting_small_inv.png",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = node_box,
        node_placement_prediction = "",
        paramtype = "light",
        paramtype2 = "wallmounted",
        sunlight_propagates = true,
        use_texture_alpha = "opaque",
        wield_image = "unilib_misc_painting_small_inv.png",

        on_place = function(itemstack, placer, pointed_thing)

            -- (Compatibility with wooden display frames, etc)
            if unilib.misc.pointed_has_rightclick(itemstack, placer, pointed_thing) then
                return unilib.misc.pointed_use_rightclick(itemstack, placer, pointed_thing)
            end

            local num = math.random(unilib.setting.xdecor_painting_count)
            local leftover, pos = core.item_place_node(
                ItemStack("unilib:misc_painting_small_" .. num), placer, pointed_thing
            )

            -- N.B. Not in original code: check that the "attached_node = 1" didn't prevent the
            --      painting from being placed
            if pos == nil then
                return
            end

            if leftover:get_count() == 0 and not core.setting_getbool("creative_mode") then
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

    if unilib.setting.xdecor_painting_count > 1 then

        for i = 2, unilib.setting.xdecor_painting_count do

            -- Paintings 1-4 are from xdecor; paintings 5-20 are original to unilib
            local orig_name = nil
            if i <= 4 then
                orig_name = "xdecor:painting_" .. i
            end

            unilib.register_node("unilib:misc_painting_small_" .. i, orig_name, mode, {
                -- From xdecor:painting_2, etc
                -- (no description)
                tiles = {
                    "unilib_misc_painting_small_" .. i .. ".png",
                    "unilib_misc_painting_frame_small.png",
                },
                groups = {
                    attached_node = 1,
                    choppy = 3,
                    flammable = 2,
                    not_in_creative_inventory = 1,
                    oddly_breakable_by_hand = 2,
                },
                sounds = unilib.global.sound_table.wood,

                drawtype = "nodebox",
                drop = "unilib:misc_painting_small_1",
                -- N.B. is_ground_content = false not in original code
                is_ground_content = false,
                node_box = node_box,
                paramtype = "light",
                paramtype2 = "wallmounted",
                sunlight_propagates = true,
                use_texture_alpha = "opaque",
            })

        end

    end

end
