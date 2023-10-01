---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/woodsoils
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_ordinary_with_litter_forest = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.woodsoils.add_mode

local radius_list = {
--  we1 ns1     we2 ns2     we3 ns3
    {-1, -2,     -2, -2,     -2, -3},
    { 0, -2,     -3, -1,     -3, -2},
    { 1, -2,     -3,  0,     -4, -1},
    {-2, -1,     -3,  1,     -4,  0},
    {-1, -1,     -2,  2,     -4,  1},
    { 0, -1,     -1,  3,     -3,  2},
    { 1, -1,      0,  3,     -2,  3},
    { 2, -1,      1,  3,     -1,  4},
    {-2,  0,      2,  2,      0,  4},
    {-1,  0,      3,  1,      1,  4},
    { 0,  0,      3,  0,      2,  3},
    { 1,  0,      3, -1,      3,  2},
    { 2,  0,      2, -2,      4,  1},
    {-2,  1,      1, -3,      4,  0},
    {-1,  1,      0, -3,      4, -1},
    { 0,  1,     -1, -3,      3, -2},
    { 1,  1,      0,  0,      2, -3},
    { 2,  1,      0,  0,      1, -4},
    {-1,  2,      0,  0,      0, -4},
    { 0,  2,      0,  0,     -1, -4},
    { 1,  2,      0,  0,      0,  0},
}

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_ordinary_with_litter_forest.place_litter(pos)

    -- N.B. Modified original code to prevent woodsoils being placed around logs (param2 < 6 is
    --      based on how minetest_game places logs)
    if (
        minetest.get_item_group(
            minetest.get_node({x = pos.x, y = pos.y - 1, z = pos.z}).name,
            "soil"
        ) > 0 or minetest.get_item_group(
            minetest.get_node({x = pos.x, y = pos.y - 2, z = pos.z}).name,
            "soil"
        ) > 0
    ) and minetest.get_node(pos).param2 < 6 then

        for i in pairs(radius_list) do

            local we1 = radius_list[i][1]
            local ns1 = radius_list[i][2]
            local we2 = radius_list[i][3]
            local ns2 = radius_list[i][4]
            local we3 = radius_list[i][5]
            local ns3 = radius_list[i][6]

            local radius_1a = {x = pos.x + we1, y = pos.y - 1, z = pos.z + ns1}
            local radius_1b = {x = pos.x + we1, y = pos.y - 2, z = pos.z + ns1}
            local radius_2a = {x = pos.x + we2, y = pos.y - 1, z = pos.z + ns2}
            local radius_2b = {x = pos.x + we2, y = pos.y - 2, z = pos.z + ns2}
            local radius_3a = {x = pos.x + we3, y = pos.y - 1, z = pos.z + ns3}
            local radius_3b = {x = pos.x + we3, y = pos.y - 2, z = pos.z + ns3}

            local node_1a = minetest.get_node(radius_1a)
            local node_1b = minetest.get_node(radius_1b)
            local node_2a = minetest.get_node(radius_2a)
            local node_2b = minetest.get_node(radius_2b)
            local node_3a = minetest.get_node(radius_3a)
            local node_3b = minetest.get_node(radius_3b)

            -- (Close to the tree, replace dirt, soil and grass)
            -- N.B. Original code replaces existing litter, for example in jungle. This version
            --      doesn't do that
            -- N.B. Original code doesn't use litter #2 for anything; it is a nice effect on
            --      non-level surfaces
            --[[
            if minetest.get_item_group(minetest.get_node(radius_1a).name, "soil") > 0 then
                minetest.swap_node(radius_1a, {name = "unilib:dirt_ordinary_with_litter_forest_1"})
            end
            ]]--
            if minetest.get_item_group(node_1a.name, "soil") > 0 and
                    not string.find(node_1a.name, "litter") then
                minetest.swap_node(radius_1a, {name = "unilib:dirt_ordinary_with_litter_forest_1"})
            end

            --[[
            if minetest.get_item_group(minetest.get_node(radius_1b).name, "soil") > 0 then
                minetest.swap_node(radius_1b, {name = "unilib:dirt_ordinary_with_litter_forest_1"})
            end
            ]]--
            if minetest.get_item_group(node_1b.name, "soil") > 0 and
                    not string.find(node_1b.name, "litter") then
                minetest.swap_node(radius_1b, {name = "unilib:dirt_ordinary_with_litter_forest_2"})
            end

            -- (Further away from the tree, replace only turf)
            if string.find(node_2a.name, "dirt_ordinary_with_turf") then
                minetest.swap_node(radius_2a, {name = "unilib:dirt_ordinary_with_litter_forest_3"})
            end

            if string.find(node_2b.name, "dirt_ordinary_with_turf") then
                minetest.swap_node(radius_2b, {name = "unilib:dirt_ordinary_with_litter_forest_3"})
            end

            if string.find(node_3a.name, "dirt_ordinary_with_turf") then
                minetest.swap_node(radius_3a, {name = "unilib:dirt_ordinary_with_litter_forest_4"})
            end

            if string.find(node_3b.name, "dirt_ordinary_with_turf") then
                minetest.swap_node(radius_3b, {name = "unilib:dirt_ordinary_with_litter_forest_4"})
            end

        end
    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_ordinary_with_litter_forest.init()

    return {
        description = "Ordinary dirt with forest litter",
        notes = "Over time, an ABM replaces ordinary grass with forest litter around trees and" ..
                " ferns",
        depends = "dirt_ordinary",
        optional = {"grass_ordinary", "soil_ordinary"},
    }

end

function unilib.pkg.dirt_ordinary_with_litter_forest.exec()

    local soil_table = nil
    if unilib.pkg_executed_table["soil_ordinary"] ~= nil then

        soil_table = {
            base = "unilib:dirt_ordinary_with_litter_forest_1",
            dry = "unilib:soil_ordinary",
            wet = "unilib:soil_ordinary_wet",
        }

    end

    unilib.register_node(
        -- From woodsoils:dirt_with_leaves_1
        "unilib:dirt_ordinary_with_litter_forest_1",
        "woodsoils:dirt_with_leaves_1",
        mode,
        {
            description = S("Ordinary Dirt with Forest Litter"),
            tiles = {
                "unilib_dirt_ordinary.png^unilib_litter_forest_heavy_overlay.png",
                "unilib_dirt_ordinary.png",
                "unilib_dirt_ordinary.png^unilib_litter_forest_heavy_side_overlay.png",
            },
            -- N.B. not_in_creative_inventory = 1 not in original code
            groups = {crumbly = 3, not_in_creative_inventory = 1, soil = 1},
            sounds = unilib.node_sound_dirt_defaults({
                footstep = {name = "unilib_grass_footstep", gain = 0.4},
            }),

            drop = "unilib:dirt_ordinary",
            is_ground_content = unilib.caves_chop_dirt_flag,
            soil = soil_table,
        }
    )

    if unilib.pkg_executed_table["soil_ordinary"] ~= nil then
        soil_table.base = "unilib:dirt_ordinary_with_litter_forest_2"
    end

    unilib.register_node(
        -- From woodsoils:dirt_with_leaves_2
        "unilib:dirt_ordinary_with_litter_forest_2",
        "woodsoils:dirt_with_leaves_2",
        mode,
        {
            description = S("Ordinary Dirt with Forest Litter"),
            tiles = {
                "unilib_litter_forest_ground_underlay.png",
                "unilib_dirt_ordinary.png",
                "unilib_dirt_ordinary.png^unilib_litter_forest_ground_underlay_side_overlay.png",
            },
            -- N.B. not_in_creative_inventory = 1 not in original code
            groups = {crumbly = 3, not_in_creative_inventory = 1, soil = 1},
            sounds = unilib.node_sound_dirt_defaults({
                footstep = {name = "unilib_grass_footstep", gain = 0.4},
            }),

            drop = "unilib:dirt_ordinary",
            is_ground_content = unilib.caves_chop_dirt_flag,
            soil = soil_table,
        }
    )

    if unilib.pkg_executed_table["soil_ordinary"] ~= nil then
        soil_table.base = "unilib:dirt_ordinary_with_litter_forest_3"
    end

    unilib.register_node(
        -- From woodsoils:grass_with_leaves_2
        "unilib:dirt_ordinary_with_litter_forest_3",
        "woodsoils:grass_with_leaves_2",
        mode,
        {
            description = S("Ordinary Dirt with Forest Litter"),
            tiles = {
                "unilib_turf_ordinary_top.png^unilib_litter_forest_heavy_overlay.png",
                "unilib_dirt_ordinary.png",
                "unilib_dirt_ordinary.png^unilib_turf_ordinary_side_overlay.png" ..
                        "^unilib_litter_forest_heavy_side_overlay.png",
            },
            -- N.B. not_in_creative_inventory = 1 not in original code
            groups = {crumbly = 3, not_in_creative_inventory = 1, soil = 1},
            sounds = unilib.node_sound_dirt_defaults({
                footstep = {name = "unilib_grass_footstep", gain = 0.4},
            }),

            drop = "unilib:dirt_ordinary",
            is_ground_content = unilib.caves_chop_dirt_flag,
            soil = soil_table,
        }
    )

    if unilib.pkg_executed_table["soil_ordinary"] ~= nil then
        soil_table.base = "unilib:dirt_ordinary_with_litter_forest_4"
    end

    unilib.register_node(
        -- From woodsoils:grass_with_leaves_1
        "unilib:dirt_ordinary_with_litter_forest_4",
        "woodsoils:grass_with_leaves_1",
        mode,
        {
            description = S("Ordinary Dirt with Forest Litter"),
            tiles = {
                "unilib_turf_ordinary_top.png^unilib_litter_forest_light_overlay.png",
                "unilib_dirt_ordinary.png",
                "unilib_dirt_ordinary.png^unilib_turf_ordinary_side_overlay.png" ..
                        "^unilib_litter_forest_light_overlay_side_overlay.png",
            },
            -- N.B. not_in_creative_inventory = 1 not in original code
            groups = {crumbly = 3, not_in_creative_inventory = 1, soil = 1},
            sounds = unilib.node_sound_dirt_defaults({
                footstep = {name = "unilib_grass_footstep", gain = 0.4},
            }),

            drop = "unilib:dirt_ordinary",
            is_ground_content = unilib.caves_chop_dirt_flag,
            soil = soil_table,
        }
    )

    if unilib.pkg_executed_table["grass_ordinary"] ~= nil then

        -- N.B. Original code had two calls to sickles.register_cuttable(), for no obvious reason
        for i = 3, 4 do

            unilib.register_cuttable(
                "dirt_ordinary_with_litter_forest_" .. i,
                "unilib:dirt_ordinary",
                "unilib:grass_ordinary_1"
            )

        end

    end

    -- ABM to place woodsoils around trees/ferns grown from saplings (over time)
    unilib.register_abm({
        label = "Place woodsoils [dirt_ordinary_with_litter_forest]",
        nodenames = {"group:tree", "group:fern"},

        -- (Tree takes half an hour on average to drop litter over the surrounding soil)
        chance = 60,
        interval = 60,

        action = function(pos)
            unilib.pkg.dirt_ordinary_with_litter_forest.place_litter(pos)
        end,
    })

    -- LBM to place woodsoils around trees/ferns placed as decorations (immediately)
    unilib.register_lbm({
        label = "Place woodsoils around trees/ferns [dirt_ordinary_with_litter_forest]",
        name = "unilib:lbm_dirt_ordinary_with_litter_forest",
        nodenames = {"group:tree", "group:fern"},
        run_at_every_load = true,

        action = function(pos)
            unilib.pkg.dirt_ordinary_with_litter_forest.place_litter(pos)
        end,
    })

end
