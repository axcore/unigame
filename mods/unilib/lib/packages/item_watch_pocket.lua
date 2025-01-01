---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    24hr_clock
-- Code:    WTFPL/CC0
-- Media:   CC BY-SA
---------------------------------------------------------------------------------------------------

unilib.pkg.item_watch_pocket = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table["24hr_clock"].add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_watch_pocket.init()

    return {
        description = "Pocket watch",
        depends = {"glass_ordinary", "metal_copper", "metal_tin"},
    }

end

function unilib.pkg.item_watch_pocket.exec()

    core.register_globalstep(function(dtime)

        local players = core.get_connected_players()
        for i,player in ipairs(players) do

            local got_clock = false
            local wielded = false
            local active_inv = nil
            local stack_idx = 0
            local wielded_item = player:get_wielded_item():get_name()
            local active_width = player:hud_get_hotbar_itemcount()

            if string.sub(wielded_item, 0, 24) == "unilib:item_watch_pocket" then

                wielded = true
                stack_idx = player:get_wield_index()
                got_clock = true

            else

                if player:get_inventory() then

                    for i,stack in ipairs(player:get_inventory():get_list("main")) do

                        if i <= active_width and
                            string.sub(stack:get_name(), 0, 24) == "unilib:item_watch_pocket" then

                            active_inv = stack
                            stack_idx = i
                            got_clock = true
                            break

                        end

                    end

                end

            end

            if got_clock then

                local clock_img = math.floor(24 * core.get_timeofday())

                if wielded then

                    player:set_wielded_item("unilib:item_watch_pocket_" .. clock_img)

                elseif active_inv then

                    player:get_inventory():set_stack(
                        "main", stack_idx, "unilib:item_watch_pocket_" .. clock_img
                    )

                end

            end

        end

    end)

    -- N.B. Tweaked original code so that the time shown in the watch in the player's inventory is
    --      12:00
    for i = 0, 23 do

        local img = "unilib_item_watch_pocket_" .. i .. ".png"
        local inv = 1
        if i == 12 then
            inv = 0
        end

        -- N.B. In original code, core.register_tool() was used
        unilib.register_craftitem("unilib:item_watch_pocket_" .. i, "24hr_clock:clock" .. i, mode, {
            -- From 24hr_clock:clock0, etc
            description = S("Pocket Watch"),
            inventory_image = img,
            groups = {not_in_creative_inventory = inv},

            wield_image = img,
        })

    end

    unilib.register_craft({
        -- From 24hr_clock:clock12
        output = "unilib:item_watch_pocket_12",
        recipe = {
            {"", "unilib:metal_tin_ingot", ""},
            {"unilib:metal_copper_ingot", "unilib:glass_ordinary", "unilib:metal_copper_ingot"},
            {"", "unilib:metal_copper_ingot", ""},
        },
    })

end
