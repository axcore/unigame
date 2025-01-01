---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    fireflies
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_firefly = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.fireflies.add_mode

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

-- Lists of fireflies that were actually created, for any package that wants to create new
--      decorations. Note that the decorations created by this package use the hidden fireflies,
--      not the visible ones
unilib.pkg.misc_firefly.visible_firefly_list = {}
unilib.pkg.misc_firefly.hidden_firefly_list = {}

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_firefly.setup_node_timers(low_deco_name, high_deco_name)

    -- Depending on whether any firefly decorations are added, set up the nodetimers
    -- This is a shared function for the benefit of any packages that want to create new
    --      decorations
    -- It should be called by the decoration package, after the call to
    --      unilib.register_decoration_complete(), and inside a core.register_on_mods_loaded()
    --      function (see the code example in the "deco_fireflies_misc_firefly" package)
    --
    -- The "high_deco_name" argument is optional

    -- Get decoration IDs
    local fireflies_low, fireflies_high
    fireflies_low = core.get_decoration_id(low_deco_name)
    if high_deco_name ~= nil then
        fireflies_high = core.get_decoration_id(high_deco_name)
    end

    if fireflies_low ~= nil then

        if high_deco_name == nil then
            core.set_gen_notify({decoration = true}, {fireflies_low})
        else
            core.set_gen_notify({decoration = true}, {fireflies_low, fireflies_high})
        end

        -- Start nodetimers to convert fireflies (at night) into hidden fireflies (during the
        --      day)
        core.register_on_generated(function(minp, maxp, blockseed)

            local gennotify = core.get_mapgen_object("gennotify")
            local poslist = {}

            for _, pos in ipairs(gennotify["decoration#" .. fireflies_low] or {}) do

                local firefly_low_pos = {x = pos.x, y = pos.y + 3, z = pos.z}
                table.insert(poslist, firefly_low_pos)

            end

            if high_deco_name ~= nil then

                for _, pos in ipairs(gennotify["decoration#" .. fireflies_high] or {}) do

                    local firefly_high_pos = {x = pos.x, y = pos.y + 4, z = pos.z}
                    table.insert(poslist, firefly_high_pos)

                end

            end

            if #poslist ~= 0 then

                for i = 1, #poslist do

                    local pos = poslist[i]
                    core.get_node_timer(pos):start(1)

                end

            end

        end)

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_firefly.init()

    return {
        description = "Fireflies",
        notes = "Only visible at night. Can be caught with a bug net and placed in a bottle to" ..
                " create a light source. When the Minetest tweak setting is enabled, an extended" ..
                " set of 4 coloured fireflies is availabe",
    }

end

function unilib.pkg.misc_firefly.exec()

    local firefly_list = {
        {"yellow",      true,       S("Yellow Firefly")},
    }

    if unilib.setting.mtgame_tweak_flag then

        table.insert(firefly_list, {"orange",      false,      S("Orange Firefly")})
        table.insert(firefly_list, {"red",         false,      S("Red Firefly")})
        table.insert(firefly_list, {"white",       false,      S("White Firefly")})

    end

    -- Register nodes
    for i in ipairs (firefly_list) do

        local part_name = firefly_list[i][1]
        local orig_flag = firefly_list[i][2]
        local description = firefly_list[i][3]

        local visible_orig_name = nil
        local hidden_orig_name = nil
        if orig_flag then

            visible_orig_name = "fireflies:firefly"
            hidden_orig_name = "fireflies:hidden_firefly"

        end

        local img = "unilib_misc_firefly_" .. part_name .. ".png"

        unilib.register_node("unilib:misc_firefly_" .. part_name, visible_orig_name, mode, {
            -- From fireflies:firefly
            description = description,
            tiles = {{
                name = "unilib_misc_firefly_" .. part_name .. "_animated.png",
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 1.5
                },
            }},
            -- N.B. firefly = 1 not in original code
            groups = {catchable = 1, firefly = 1},
            -- (no sounds)

            buildable_to = true,
            drawtype = "plantlike",
            floodable = true,
            inventory_image = img,
            light_source = 6,
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
            },
            sunlight_propagates = true,
            walkable = false,
            waving = 1,
            wield_image = img,

            on_construct = function(pos)
                core.get_node_timer(pos):start(1)
            end,

            --[[
            on_place = function(itemstack, placer, pointed_thing)

                local player_name = placer:get_player_name()
                local pos = pointed_thing.above

                if not core.is_protected(pos, player_name) and
                        not core.is_protected(pointed_thing.under, player_name) and
                        core.get_node(pos).name == "air" then

                    core.set_node(pos, {name = "unilib:misc_firefly_" .. part_name})
                    core.get_node_timer(pos):start(1)
                    itemstack:take_item()

                end

                return itemstack

            end,
            ]]--

            on_timer = function(pos, elapsed)

                if core.get_node_light(pos) > 11 then
                    core.set_node(pos, {name = "unilib:misc_firefly_" .. part_name .. "_hidden"})
                end

                core.get_node_timer(pos):start(30)

            end,
        })

        table.insert(
            unilib.pkg.misc_firefly.visible_firefly_list,
            "unilib:misc_firefly_" .. part_name
        )

        unilib.register_node(
            -- From fireflies:hidden_firefly
            "unilib:misc_firefly_" .. part_name .. "_hidden",
            hidden_orig_name,
            mode,
            {
                -- (no description)
                -- (no tiles)
                groups = {not_in_creative_inventory = 1},
                -- (no sounds)

                buildable_to = true,
                diggable = false,
                drawtype = "airlike",
                drop = "",
                floodable = true,
                inventory_image = img .. "^unilib_invisible_node_overlay.png",
                paramtype = "light",
                pointable = false,
                sunlight_propagates = true,
                walkable = false,
                wield_image = img .. "^unilib_invisible_node_overlay.png",

                on_construct = function(pos)
                    core.get_node_timer(pos):start(1)
                end,

                --[[
                on_place = function(itemstack, placer, pointed_thing)

                    local player_name = placer:get_player_name()
                    local pos = pointed_thing.above

                    if not core.is_protected(pos, player_name) and
                            not core.is_protected(pointed_thing.under, player_name) and
                            core.get_node(pos).name == "air" then

                        core.set_node(
                            pos,
                            {name = "unilib:misc_firefly_" .. part_name .. "_hidden"}
                        )
                        core.get_node_timer(pos):start(1)
                        itemstack:take_item()

                    end

                    return itemstack

                end,
                ]]--

                on_timer = function(pos, elapsed)

                    if core.get_node_light(pos) <= 11 then
                        core.set_node(pos, {name = "unilib:misc_firefly_" .. part_name})
                    end

                    core.get_node_timer(pos):start(30)

                end
            }
        )

        table.insert(
            unilib.pkg.misc_firefly.hidden_firefly_list,
            "unilib:misc_firefly_" .. part_name .. "_hidden"
        )

    end

    -- Register decorations
    unilib.register_decoration_generic("fireflies_misc_firefly_low", {
        -- From fireflies/init.lua
        deco_type = "simple",
        decoration = unilib.pkg.misc_firefly.hidden_firefly_list,

        fill_ratio = 0.0005,
        place_offset_y = 2,
        sidelen = 80,
    })

    unilib.register_decoration_generic("fireflies_misc_firefly_high", {
        -- From fireflies/init.lua
        deco_type = "simple",
        decoration = unilib.pkg.misc_firefly.hidden_firefly_list,

        fill_ratio = 0.0005,
        place_offset_y = 3,
        sidelen = 80,
    })

end
