---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    realcompass
-- Code:    WTFPL/CC0
-- Media:   CC BY-SA
---------------------------------------------------------------------------------------------------

unilib.pkg.item_compass_magnetic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.realcompass.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_compass_magnetic.init()

    return {
        description = "Magnetic compass",
        notes = "Points due north",
        depends = {"glass_ordinary", "metal_copper", "metal_steel"},
    }

end

function unilib.pkg.item_compass_magnetic.exec()

    core.register_globalstep(function(dtime)

        local players = core.get_connected_players()
        for i,player in ipairs(players) do

            local got_compass = false
            local wielded = false
            local active_inv = nil
            local stack_idx = 0
            local active_width = player:hud_get_hotbar_itemcount()

            -- First check to see if the user has a magnetic compass because, if they don't, there
            --      is no reason to waste time calculating bookmarks or spawnpoints
            local wielded_item = player:get_wielded_item():get_name()
            if string.sub(wielded_item, 0, 28) == "unilib:item_compass_magnetic" then

                -- If the player is wielding a compass, change the wielded image
                wielded = true
                stack_idx = player:get_wield_index()
                got_compass = true

            else

                -- Check to see if compass is in active inventory
                if player:get_inventory() then

                    for i,stack in ipairs(player:get_inventory():get_list("main")) do

                        if i <= active_width and
                                string.sub(stack:get_name(), 0, 28) ==
                                        "unilib:item_compass_magnetic" then

                            -- Store the stack so we can update it later with new image
                            active_inv = stack
                            -- Store the index so we can add image at correct location
                            stack_idx = i
                            got_compass = true
                            break

                        end

                    end

                end

            end

            if got_compass then

                local dir = player:get_look_horizontal()
                local angle_relative = math.deg(dir)
                -- N.B. In original code, there were only 16 textures (and thus 16 compass variants)
                local compass_img = math.floor((angle_relative / 11.25) + 0.5) % 32
                local full_name = "unilib:item_compass_magnetic_" .. compass_img

                -- Update compass image to point at target
                if wielded then
                    player:set_wielded_item(full_name)
                elseif active_inv then
                    player:get_inventory():set_stack("main", stack_idx, full_name)
                end

            end
        end
    end)

    for i = 0, 31 do

        local img = "unilib_item_compass_magnetic_" .. i .. ".png"
        local inv = 1
        if i == 0 then
            inv = 0
        end

        -- N.B. In original code, core.register_tool() was used
        unilib.register_craftitem("unilib:item_compass_magnetic_" .. i, "realcompass:" .. i, mode, {
            -- From realcompass:0, etc
            description = S("Magnetic Compass"),
            inventory_image = img,
            -- N.B. In the original code, only .not_in_creative_inventory was used. Added more
            --      groups to match other unilib compasses
            groups = {
                disable_repair = 1, not_in_creative_inventory = inv, magnetic_compass = i, tool = 1,
            },

            -- N.B. no stack_max in original code
            stack_max = 1,
            wield_image = img,
        })

    end

    unilib.register_craft({
        -- From realcompass:0
        output = "unilib:item_compass_magnetic_0",
        recipe = {
            {"", "unilib:metal_steel_ingot", ""},
            {"unilib:metal_copper_ingot", "unilib:glass_ordinary", "unilib:metal_copper_ingot"},
            {"", "unilib:metal_copper_ingot", ""},
        },
    })

end
