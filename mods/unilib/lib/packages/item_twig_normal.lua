---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/trunks
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_twig_normal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.trunks.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function check_buildable_to(pos)

    local node = minetest.get_node(pos)
    local def_table = minetest.registered_nodes[node.name]
    if def_table then
        return def_table.buildable_to
    end

end

local function place_func(pos)

    local twig_size = math.random(1, 27)

    local right_here = {x = pos.x, y = pos.y + 1, z = pos.z}
    local north = {x = pos.x, y = pos.y + 1, z = pos.z + 1}
    local north_east = {x = pos.x + 1, y = pos.y + 1, z = pos.z + 1}
    local east = {x = pos.x + 1, y = pos.y + 1, z = pos.z}
    local south_east = {x = pos.x + 1, y = pos.y + 1, z = pos.z - 1}
    local south = {x = pos.x, y = pos.y + 1, z = pos.z - 1}
    local south_west = {x = pos.x - 1, y = pos.y + 1, z = pos.z - 1}
    local west = {x = pos.x - 1, y = pos.y + 1, z = pos.z}
    local north_west = {x = pos.x - 1, y = pos.y + 1, z = pos.z + 1}

    -- Small twigs (unilib:item_twig_normal_1 to unilib:item_twig_normal_4)
    if twig_size <= 16 then

        minetest.swap_node(
            right_here,
            {name = "unilib:item_twig_normal_" .. math.random(1, 4), param2 = math.random(0, 3)}
        )


    -- Big twigs (larger than one node, unilib:item_twig_normal_5 to unilib:item_twig_normal_12)
    elseif twig_size == 17 then

        if not (
            check_buildable_to({x = pos.x + 1, y = pos.y, z = pos.z + 1}) or
            check_buildable_to({x = pos.x + 1, y = pos.y, z = pos.z})
        ) then

            if check_buildable_to(right_here) then
                minetest.swap_node(right_here, {name = "unilib:item_twig_normal_5"})
            end

            if check_buildable_to(north_east) then
                minetest.swap_node(north_east, {name = "unilib:item_twig_normal_6"})
            end

            if check_buildable_to(east) then
                minetest.swap_node(east, {name = "unilib:item_twig_normal_7"})
            end

        end

    elseif twig_size == 18 then

        if not (
            check_buildable_to({x = pos.x + 1, y = pos.y, z = pos.z - 1}) or
            check_buildable_to({x = pos.x, y = pos.y, z = pos.z - 1})
        ) then

            if check_buildable_to(right_here) then
                minetest.swap_node(right_here, {name = "unilib:item_twig_normal_5", param = 1})
            end

            if check_buildable_to(south_east) then
                minetest.swap_node(south_east, {name = "unilib:item_twig_normal_6", param = 1})
            end

            if check_buildable_to(south) then
                minetest.swap_node(south, {name = "unilib:item_twig_normal_7", param = 1})
            end

        end

    elseif twig_size == 19 then

        if not (
            check_buildable_to({x = pos.x + 1, y = pos.y, z = pos.z - 1}) or
            check_buildable_to({x = pos.x - 1, y = pos.y, z = pos.z})
        ) then

            if check_buildable_to(right_here) then
                minetest.swap_node(right_here, {name = "unilib:item_twig_normal_5", param = 2})
            end

            if check_buildable_to(south_west) then
                minetest.swap_node(south_west, {name = "unilib:item_twig_normal_6", param = 2})
            end

            if check_buildable_to(west) then
                minetest.swap_node(west, {name = "unilib:item_twig_normal_7", param = 2})
            end

        end

    elseif twig_size == 20 then

        if not (
            check_buildable_to({x = pos.x - 1, y = pos.y, z = pos.z + 1}) or
            check_buildable_to({x = pos.x, y = pos.y, z = pos.z + 1})
        ) then

            if check_buildable_to(right_here) then
                minetest.swap_node(right_here, {name = "unilib:item_twig_normal_5", param = 3})
            end

            if check_buildable_to(north_west) then
                minetest.swap_node(north_west, {name = "unilib:item_twig_normal_6", param = 3})
            end

            if check_buildable_to(north) then
                minetest.swap_node(north, {name = "unilib:item_twig_normal_7", param = 3})
            end

        end

    elseif twig_size == 21 then

        if not (
            check_buildable_to({x = pos.x, y = pos.y, z = pos.z + 1}) or
            check_buildable_to({x = pos.x + 1, y = pos.y, z = pos.z + 1})
        ) then

            if check_buildable_to(right_here) then
                minetest.swap_node(right_here, {name = "unilib:item_twig_normal_8"})
            end

            if check_buildable_to(north) then
                minetest.swap_node(north, {name = "unilib:item_twig_normal_9"})
            end

            if check_buildable_to(north_east) then
                minetest.swap_node(north_east, {name = "unilib:item_twig_normal_10"})
            end

        end

    elseif twig_size == 22 then

        if not (
            check_buildable_to({x = pos.x + 1, y = pos.y, z = pos.z}) or
            check_buildable_to({x = pos.x + 1, y = pos.y, z = pos.z - 1})
        ) then

            if check_buildable_to(right_here) then
                minetest.swap_node(right_here, {name = "unilib:item_twig_normal_8", param = 1})
            end

            if check_buildable_to(east) then
                minetest.swap_node(east, {name = "unilib:item_twig_normal_9", param = 1})
            end

            if check_buildable_to(south_east) then
                minetest.swap_node(south_east, {name = "unilib:item_twig_normal_10", param = 1})
            end

        end

    elseif twig_size == 23 then

        if not (
            check_buildable_to({x = pos.x, y = pos.y, z = pos.z - 1}) or
            check_buildable_to({x = pos.x - 1, y = pos.y, z = pos.z - 1})
        ) then

            if check_buildable_to(right_here) then
                minetest.swap_node(right_here, {name = "unilib:item_twig_normal_8", param = 2})
            end

            if check_buildable_to(south) then
                minetest.swap_node(south, {name = "unilib:item_twig_normal_9", param = 2})
            end

            if check_buildable_to(south_west) then
                minetest.swap_node(south_west, {name = "unilib:item_twig_normal_10", param = 2})
            end

        end

    elseif twig_size == 24 then

        if not (
            check_buildable_to({x = pos.x - 1, y = pos.y, z = pos.z}) or
            check_buildable_to({x = pos.x - 1, y = pos.y, z = pos.z + 1})
        ) then

            if check_buildable_to(right_here) then
                minetest.swap_node(right_here, {name = "unilib:item_twig_normal_8", param = 3})
            end

            if check_buildable_to(west) then
                minetest.swap_node(west, {name = "unilib:item_twig_normal_9", param = 3})
            end

            if check_buildable_to(north_west) then
                minetest.swap_node(north_west, {name = "unilib:item_twig_normal_10", param = 3})
            end

        end

    elseif twig_size <= 25 then

        minetest.swap_node(
            right_here,
            {name = "unilib:item_twig_normal_" .. math.random(11, 12), param2 = math.random(0, 3)}
        )

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_twig_normal.init()

    return {
        description = "Normal twigs",
        notes = "Individual twigs can be used to craft twig blocks",
        optional = {"bush_branching_yellow", "bush_branching_green", "item_stick_ordinary"},
    }

end

function unilib.pkg.item_twig_normal.exec()

    for i = 1, 12 do

        -- (In original code, twig #6 was just an empty texture with no accompanying node)
        local orig_i = i
        if i > 5 then
            orig_i = orig_i + 1
        end

        local group_table = {
            attached_node = 1, choppy = 2, flammable = 3, oddly_breakable_by_hand = 2,
        }
        if i > 1 then
            group_table.not_in_creative_inventory = 1
        end

        local img = "unilib_item_twig_normal_" .. i .. ".png"

        unilib.register_node("unilib:item_twig_normal_" .. i, "trunks:twig_" .. orig_i, mode, {
            -- From trunks:twig_1, etc
            description = S("Normal Twig"),
            tiles = {
                img,
                img .. "^[transformFY",
                "unilib_item_twig_normal_empty.png",
            },
            groups = group_table,
            sounds = unilib.sound_table.leaves,

            buildable_to = true,
            drawtype = "nodebox",
            drop = "unilib:item_twig_normal_1",
            inventory_image = img,
            liquids_pointable = true,
            node_box = {
                type = "fixed",
                fixed = {
                    -1/2, -1/2, -1/2, 1/2, -7/16, 1/2,
                },
            },
            paramtype = "light",
            paramtype2 = "facedir",
            sunlight_propagates = true,
            use_texture_alpha = "clip",
            walkable = false,
            wield_image = img,

            on_place = function(itemstack, placer, pointed_thing)

                local pt = pointed_thing

                if not placer then
                    return
                end

                local playername = placer:get_player_name()
                if minetest.is_protected(pt.above, playername) then

                    minetest.record_protection_violation(pt.above, playername)
                    return

                end

                local direction = minetest.dir_to_facedir(placer:get_look_dir())
                if minetest.get_node(pt.above).name == "air" then

                    minetest.swap_node(
                        pt.above,
                        {name = "unilib:item_twig_normal_" .. math.random(1, 4), param2 = direction}
                    )

                    if not minetest.setting_getbool("creative_mode") then
                        itemstack:take_item()
                    end

                    return itemstack

                end
            end,
        })

    end

    if unilib.pkg_executed_table["bush_branching_yellow"] ~= nil then

        unilib.register_craft({
            -- From trunks:twig_1
            output = "unilib:item_twig_normal_1 2",
            recipe = {
                {"unilib:bush_branching_yellow_leaves"},
            },
        })
        unilib.register_craft({
            -- From trunks:twig_1
            output = "unilib:item_twig_normal_1 4",
            recipe = {
                {"unilib:bush_branching_yellow_stem"},
            },
        })
        unilib.register_craft({
            -- From trunks:twig_1
            output = "unilib:item_twig_normal_1 4",
            recipe = {
                {"unilib:bush_branching_yellow_arm"},
            },
        })

    end
    if unilib.pkg_executed_table["bush_branching_green"] ~= nil then

        unilib.register_craft({
            -- From trunks:twig_1
            output = "unilib:item_twig_normal_1 2",
            recipe = {
                {"unilib:bush_branching_green_leaves"},
            },
        })
        unilib.register_craft({
            -- From trunks:twig_1
            output = "unilib:item_twig_normal_1 4",
            recipe = {
                {"unilib:bush_branching_green_stem"},
            },
        })
        unilib.register_craft({
            -- From trunks:twig_1
            output = "unilib:item_twig_normal_1 4",
            recipe = {
                {"unilib:bush_branching_green_arm"},
            },
        })

    end
    if unilib.pkg_executed_table["item_stick_ordinary"] ~= nil then

        unilib.register_craft({
            -- From trunks:twig_1
            output = "unilib:item_stick_ordinary",
            recipe = {
                {"unilib:item_twig_normal_1"},
            },
        })

    end
    unilib.register_node("unilib:item_twig_normal_block", "trunks:twigs", mode, {
        -- From trunks:twigs
        description = S("Block of Normal Twigs"),
        tiles = {
            "unilib_item_twig_normal_block_top.png",
            "unilib_item_twig_normal_block_top.png",
            "unilib_item_twig_normal_block.png",
        },
        groups = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
        sounds = unilib.sound_table.wood,

        paramtype2 = "facedir",
    })
    -- (A pile of twigs should only be able to make basic stair shapes and optionally the roof
    --      corners from plantlife; as in the original code)
    unilib.register_stairs("unilib:item_twig_normal_block", {
        basic_flag = true,
    })
    unilib.register_craft({
        -- From trunks:twigs
        output = "unilib:item_twig_normal_block",
        recipe = {
            {"unilib:item_twig_normal_1", "unilib:item_twig_normal_1", "unilib:item_twig_normal_1"},
            {"unilib:item_twig_normal_1", "", "unilib:item_twig_normal_1"},
            {"unilib:item_twig_normal_1", "unilib:item_twig_normal_1", "unilib:item_twig_normal_1"},
        }
    })
    unilib.register_craft({
        -- From trunks:twigs
        output = "unilib:item_twig_normal_1 8",
        recipe = {
            {"unilib:item_twig_normal_block"},
        },
    })

    -- N.B. These twigs are placed as decorations, but much, much more rarely than in original code
    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_item_twig_normal_on_ground"
        part_name = "item_twig_normal_on_ground",
        convert_func = place_func,
        replace_mode = mode,

        generic_def_table = {
            fill_ratio = unilib.convert_biome_lib({
                rarity = 66,
                plantlife_limit = -0.9,
            }),
        },
    })
    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_item_twig_normal_on_water"
        part_name = "item_twig_normal_on_water",
        convert_func = place_func,
        replace_mode = mode,

        generic_def_table = {
            fill_ratio = unilib.convert_biome_lib({
                rarity = 33,
                plantlife_limit = -0.9,
            }),
        },
    })

    -- This package provides deliberate craft recipe conflicts
    unilib.register_craft_conflicts(
        {"unilib:tree_palm_leaves", "unilib:item_twig_normal_1 2"},
        {"unilib:tree_palm_date_leaves", "unilib:item_twig_normal_1 2"},
        {"unilib:tree_bamboo_exotic_trunk_leafy", "unilib:item_twig_normal_1 2"},
        {"unilib:dye_yellow 4", "unilib:item_twig_normal_1 2"},
        {"unilib:tree_bamboo_exotic_wood 4", "unilib:item_twig_normal_1 2"},
        {"unilib:item_twig_normal_1 2", "unilib:item_twig_normal_1 4"},
        {"unilib:item_stick_ordinary 4", "unilib:item_twig_normal_1 8"}
    )

end

function unilib.pkg.item_twig_normal.post()

    -- N.B. Original code used the "leafdecay" group, but that applies to fruits as well, so here we
    --      use the "leaves" group
    unilib.register_craft({
        -- From trunks:twig_1
        output = "unilib:item_twig_normal_1 2",
        recipe = {
            {"group:leaves"},
        },
    })

    -- Palm tree leaves do not produce twigs
    for _, part_name in pairs({
        "tree_palm",
        "tree_palm_caribbean",
        "tree_palm_date",
        "tree_palm_desert",
        "tree_palm_desert_ancient",
        "tree_palm_desert_mature",
        "tree_palm_exotic",
        "tree_palm_exposed",
        "tree_palm_fan",
        "tree_palm_jungle",
        "tree_palm_nikau",
        "tree_palm_plain",
    }) do

        local c_leaves = "unilib:" .. part_name .. "_leaves"
        if minetest.registered_nodes[c_leaves] ~= nil then

            unilib.register_craft({
                -- From trunks:twig_1
                output = "unilib:tree_palm_leaves",
                recipe = {
                    {"unilib:tree_palm_leaves"},
                },
            })

        end

    end
    if unilib.pkg_executed_table["tree_palm_date"] ~= nil then

        unilib.register_craft({
            -- From trunks:twig_1
            output = "unilib:tree_palm_date_leaves",
            recipe = {
                {"unilib:tree_palm_date_leaves"},
            },
        })

    end

end
