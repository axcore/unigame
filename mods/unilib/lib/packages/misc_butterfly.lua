---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    butterflies
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_butterfly = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.butterflies.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_butterfly.init()

    return {
        description = "Butterflies",
        notes = "Only visible during the day. Can be caught in a bug net",
    }

end

function unilib.pkg.misc_butterfly.exec()

    local butterfly_list = {
        {"red",    S("Red Butterfly")},
        {"violet", S("Violet Butterfly")},
        {"white",  S("White Butterfly")},
    }

    -- Register nodes
    for i in ipairs (butterfly_list) do

        local part_name = butterfly_list[i][1]
        local description = butterfly_list[i][2]

        unilib.register_node(
            -- From butterflies:butterfly_red, etc
            "unilib:misc_butterfly_" .. part_name,
            "butterflies:butterfly_" .. part_name,
            mode,
            {
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
                groups = {catchable = 1},
                -- (no sounds)

                buildable_to = true,
                drawtype = "plantlike",
                floodable = true,
                inventory_image = "unilib_misc_butterfly_" .. part_name .. ".png",
                paramtype = "light",
                selection_box = {
                    type = "fixed",
                    fixed = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
                },
                sunlight_propagates = true,
                walkable = false,
                waving = 1,
                wield_image = "unilib_misc_butterfly_" .. part_name .. ".png",

                on_place = function(itemstack, placer, pointed_thing)

                    local player_name = placer:get_player_name()
                    local pos = pointed_thing.above

                    if not minetest.is_protected(pos, player_name) and
                            not minetest.is_protected(pointed_thing.under, player_name) and
                            minetest.get_node(pos).name == "air" then

                        minetest.set_node(pos, {name = "unilib:misc_butterfly_" .. part_name})
                        minetest.get_node_timer(pos):start(1)
                        itemstack:take_item()

                    end

                    return itemstack

                end,

                on_timer = function(pos, elapsed)

                    if minetest.get_node_light(pos) < 11 then

                        minetest.set_node(
                            pos,
                            {name = "unilib:misc_butterfly_" .. part_name .. "_hidden"}
                        )

                    end

                    minetest.get_node_timer(pos):start(30)

                end,
            }
        )

        unilib.register_node(
            -- From butterflies:hidden_butterfly_red, etc
            "unilib:misc_butterfly_" .. part_name .. "_hidden",
            "butterflies:hidden_butterfly_" .. part_name,
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
                inventory_image = "unilib_misc_butterfly_" .. part_name ..
                        ".png^unilib_invisible_node_overlay.png",
                paramtype = "light",
                pointable = false,
                sunlight_propagates = true,
                walkable = false,
                wield_image = "unilib_misc_butterfly_" .. part_name ..
                        ".png^unilib_invisible_node_overlay.png",

                on_place = function(itemstack, placer, pointed_thing)

                    local player_name = placer:get_player_name()
                    local pos = pointed_thing.above

                    if not minetest.is_protected(pos, player_name) and
                            not minetest.is_protected(pointed_thing.under, player_name) and
                            minetest.get_node(pos).name == "air" then

                        minetest.set_node(
                            pos,
                            {name = "unilib:misc_butterfly_" .. part_name .. "_hidden"}
                        )
                        minetest.get_node_timer(pos):start(1)
                        itemstack:take_item()

                    end

                    return itemstack

                end,

                on_timer = function(pos, elapsed)

                    if minetest.get_node_light(pos) >= 11 then
                        minetest.set_node(pos, {name = "unilib:misc_butterfly_" .. part_name})
                    end
                    minetest.get_node_timer(pos):start(30)

                end
            }
        )

    end

    -- Register decorations
    unilib.register_decoration("butterflies_misc_butterfly", {
        -- From butterflies:butterfly_red, etc
        deco_type = "simple",
        decoration = {
            "unilib:misc_butterfly_red",
            "unilib:misc_butterfly_violet",
            "unilib:misc_butterfly_white",
        },

        fill_ratio = 0.005,
        place_offset_y = 2,
        sidelen = 80,
    })

end

function unilib.pkg.misc_butterfly.post()

    -- Depending on whether any butterfly decorations are added, set up the nodetimers

    -- Get decoration ID
    local butterflies = minetest.get_decoration_id("unilib:misc_butterfly")
    if butterflies ~= nil then

        minetest.set_gen_notify({decoration = true}, {butterflies})

        -- Start nodetimers to convert butterflies (during the day) into hidden butterflies (at
        --      night)
        minetest.register_on_generated(function(minp, maxp, blockseed)

            local gennotify = minetest.get_mapgen_object("gennotify")
            local poslist = {}

            for _, pos in ipairs(gennotify["decoration#" .. butterflies] or {}) do

                local deco_pos = {x = pos.x, y = pos.y + 3, z = pos.z}
                table.insert(poslist, deco_pos)

            end

            if #poslist ~= 0 then

                for i = 1, #poslist do

                    local pos = poslist[i]
                    minetest.get_node_timer(pos):start(1)

                end

            end

        end)

    end

end
