---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    butterflies
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_butterfly = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.butterflies.add_mode

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

-- A list of butterflies that were actually created, for any package that wants to create new
--      decorations
unilib.pkg.misc_butterfly.butterfly_list = {}

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_butterfly.setup_node_timers(deco_name)

    -- Depending on whether any butterfly decorations are added, set up the nodetimers
    -- This is a shared function for the benefit of any packages that want to create new
    --      decorations
    -- It should be called by the decoration package, after the call to
    --      unilib.register_decoration_complete(), and inside a core.register_on_mods_loaded()
    --      function (see the code example in the "deco_butterflies_misc_butterfly" package)

    -- Get decoration ID
    local butterflies = core.get_decoration_id(deco_name)
    if butterflies ~= nil then

        core.set_gen_notify({decoration = true}, {butterflies})

        -- Start nodetimers to convert butterflies (during the day) into hidden butterflies (at
        --      night)
        core.register_on_generated(function(minp, maxp, blockseed)

            local gennotify = core.get_mapgen_object("gennotify")
            local poslist = {}

            for _, pos in ipairs(gennotify["decoration#" .. butterflies] or {}) do

                local deco_pos = {x = pos.x, y = pos.y + 3, z = pos.z}
                table.insert(poslist, deco_pos)

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

function unilib.pkg.misc_butterfly.init()

    return {
        description = "Butterflies",
        notes = "Only visible during the day. Can be caught in a bug net. When the Minetest" ..
                " tweak setting is enabled, a full set of 15 coloured butterflies is available",
    }

end

function unilib.pkg.misc_butterfly.exec()

    local butterfly_list = {
        {"red",         "red",      S("Red Butterfly")},
        {"violet",      "violet",   S("Violet Butterfly")},
        {"white",       "white",    S("White Butterfly")},
    }

    if unilib.setting.mtgame_tweak_flag then

        table.insert(butterfly_list, {"black",          "",  S("Black Butterfly")})
        table.insert(butterfly_list, {"blue",           "",  S("Blue Butterfly")})
        table.insert(butterfly_list, {"brown",          "",  S("Brown Butterfly")})
        table.insert(butterfly_list, {"cyan",           "",  S("Cyan Butterfly")})
        table.insert(butterfly_list, {"green",          "",  S("Green Butterfly")})
        table.insert(butterfly_list, {"green_dark",     "",  S("Dark Green Butterfly")})
        table.insert(butterfly_list, {"grey",           "",  S("Grey Butterfly")})
        table.insert(butterfly_list, {"grey_dark",      "",  S("Dark Grey Butterfly")})
        table.insert(butterfly_list, {"magenta",        "",  S("Magenta Butterfly")})
        table.insert(butterfly_list, {"orange",         "",  S("Orange Butterfly")})
        table.insert(butterfly_list, {"pink",           "",  S("Pink Butterfly")})
        table.insert(butterfly_list, {"yellow",         "",  S("Yellow Butterfly")})

    end

    -- Register nodes
    for i in ipairs (butterfly_list) do

        local part_name = butterfly_list[i][1]
        local orig_part_name = butterfly_list[i][2]
        local description = butterfly_list[i][3]

        local visible_orig_name = nil
        local hidden_orig_name = nil
        if orig_part_name ~= nil then

            visible_orig_name = "butterflies:butterfly_" .. orig_part_name
            hidden_orig_name = "butterflies:hidden_butterfly_" .. part_name

        end

        local img = "unilib_misc_butterfly_" .. part_name .. ".png"

        unilib.register_node("unilib:misc_butterfly_" .. part_name, visible_orig_name, mode, {
            -- From butterflies:butterfly_red, etc
            description = description,
            tiles = {{
                name = "unilib_misc_butterfly_" .. part_name .. "_animated.png",
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 3
                },
            }},
            -- N.B. butterfly = 1 not in original code
            groups = {butterfly = 1, catchable = 1},
            -- (no sounds)

            buildable_to = true,
            drawtype = "plantlike",
            floodable = true,
            inventory_image = img,
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

                local player_name = placer and placer:get_player_name() or ""
                local pos = pointed_thing.above

                if not core.is_protected(pos, player_name) and
                        not core.is_protected(pointed_thing.under, player_name) and
                        core.get_node(pos).name == "air" then

                    core.set_node(pos, {name = "unilib:misc_butterfly_" .. part_name})
                    core.get_node_timer(pos):start(1)
                    itemstack:take_item()

                end

                return itemstack

            end,
            ]]--

            on_timer = function(pos, elapsed)

                if core.get_node_light(pos) < 11 then
                    core.set_node(pos, {name = "unilib:misc_butterfly_" .. part_name .. "_hidden"})
                end

                core.get_node_timer(pos):start(30)

            end,
        })

        table.insert(
            unilib.pkg.misc_butterfly.butterfly_list,
            "unilib:misc_butterfly_" .. part_name
        )

        unilib.register_node(
            -- From butterflies:hidden_butterfly_red, etc
            "unilib:misc_butterfly_" .. part_name .. "_hidden",
            hidden_orig_name,
            mode,
            {
                -- (no description)
                -- (no tiles)
                groups = {not_in_creative_inventory = 1},
                -- (no sounds)

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

                    local player_name = placer and placer:get_player_name() or ""
                    local pos = pointed_thing.above

                    if not core.is_protected(pos, player_name) and
                            not core.is_protected(pointed_thing.under, player_name) and
                            core.get_node(pos).name == "air" then

                        core.set_node(
                            pos,
                            {name = "unilib:misc_butterfly_" .. part_name .. "_hidden"}
                        )
                        core.get_node_timer(pos):start(1)
                        itemstack:take_item()

                    end

                    return itemstack

                end,
                ]]--

                on_timer = function(pos, elapsed)

                    if core.get_node_light(pos) >= 11 then
                        core.set_node(pos, {name = "unilib:misc_butterfly_" .. part_name})
                    end

                    core.get_node_timer(pos):start(30)

                end
            }
        )

    end

    -- Register decorations
    unilib.register_decoration_generic("butterflies_misc_butterfly", {
        -- From butterflies:butterfly_red, etc
        deco_type = "simple",
        decoration = unilib.pkg.misc_butterfly.butterfly_list,

        -- N.B. In the "mtgame" remix, butterflies do not spawn at anything like the same rate they
        --      do in minetest_game; the reasons are unknown (see the "unresolved bugs" section of
        --      the README). As a temporary measure, increase the .fill_ratio by a factor of 10
--      fill_ratio = 0.005,
        fill_ratio = 0.05,
        place_offset_y = 2,
        sidelen = 80,
    })

end
