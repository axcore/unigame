---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_basket_cat = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_basket_cat.init()

    return {
        description = "Cat basket",
        notes = "Place a cat in the basket, and it will sleep all the time (day or night); can" ..
                " be used to ensure the safety of your cats when you're away. Destroy the basket" ..
                " to wake the cat (or restart the game). Right-click the basket to change the" ..
                " cat's orientation",
        depends = {"hqb_sleep_until_wake_up", "wool_basic"},
    }

end

function unilib.pkg.misc_basket_cat.exec()

    unilib.register_node("unilib:misc_basket_cat", "petz:cat_basket", mode, {
        -- From petz:cat_basket
        description = S("Cat Basket"),
        tiles = {
            "unilib_misc_basket_cat_top.png",
            "unilib_misc_basket_cat_bottom.png",
            "unilib_misc_basket_cat_side.png",
--          "unilib_misc_basket_cat_side.png",
--          "unilib_misc_basket_cat_side.png",
--          "unilib_misc_basket_cat_side.png"
        },
        -- N.B. sleeping_place = 1 not in original code; it is used by packages like
        --      "hqb_sleep_until_wake_up"
        groups = {bendy = 2, cracky = 1, sleeping_place = 1, snappy = 1},
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
                {-0.5, -0.375, -0.5, -0.4375, -0.125, 0.4375},
                {-0.5, -0.375, 0.4375, 0.5, -0.125, 0.5},
                {0.4375, -0.375, -0.5, 0.5, -0.125, 0.5},
                {-0.4375, -0.4375, -0.5, -0.25, -0.125, -0.4375},
                {0.25, -0.375, -0.5, 0.4375, -0.125, -0.4375},
                {-0.5, -0.375, -0.5, 0.5, -0.3125, -0.4375},
            },
        },
        paramtype = "light",
        use_texture_alpha = "clip",

        on_rightclick = function(pos, node, player, itemstack, pointed_thing)

            local pname = player:get_player_name()
            -- N.B. Removed superfluous table
--          local pos_above = {x = pos.x, y = pos.y, z = pos.z}
            local pos_cat = {x = pos.x, y = pos.y + 0.5, z = pos.z - 0.125}

            local cat_in_basket_flag
            -- (Check if already a cat in the basket)
--          for _, obj in ipairs(core.get_objects_inside_radius(pos_above, 1)) do
            for _, obj in ipairs(core.get_objects_inside_radius(pos, 1)) do

                local luaent = obj:get_luaentity()
                if luaent and luaent.name == "unilib:mob_cat_normal" then

                    cat_in_basket_flag = true
                    local rotation = obj:get_rotation()
                    local kitty_pos = obj:get_pos()

                    if rotation.y == 0 then

                        obj:set_rotation({x = 0, y = math.pi, z = 0})
                        obj:set_pos({x = kitty_pos.x, y = kitty_pos.y, z = kitty_pos.z + 0.0625})

                    else

                        obj:set_rotation({x = 0, y = 0, z = 0})
                        obj:set_pos(pos_cat)

                    end

                end

            end

            local itemstack_name = itemstack:get_name()
            if itemstack_name == "unilib:spawnegg_cat_normal" then

                if cat_in_basket_flag == true then

                    core.chat_send_player(pname, S("There is already a cat in the basket"))
                    return

                end

                if not core.is_protected(pos, pname) then

                    local luaent = unimobs.petz_api.release_mob(
                        player, itemstack, "unilib:mob_cat_normal", pos_cat
                    )
                    if luaent then

                        unimobs.mobkit_api.clear_both_queues(luaent)
                        unimobs.petz_api.send_mob_to_sleep(luaent, 2, true)

                    end

                end

                return itemstack

            end

        end,
    })
    unilib.register_craft({
        -- From petz:cat_basket
        type = "shaped",
        output = "unilib:misc_basket_cat",
        recipe = {
            {"", "", ""},
            {"group:wood", "unilib:wool_white", "group:wood"},
            {"group:wood", "group:wood", "group:wood"},
        },
    })

end
