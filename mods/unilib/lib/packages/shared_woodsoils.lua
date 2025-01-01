---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/woodsoils
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_woodsoils = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.woodsoils.add_mode

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
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_dirt(pos)

    -- Convert a dirt-with-turf node at the specified position into its parent dirt

    local node = core.get_node(pos)
    local data_table = unilib.global.dirt_with_turf_table[node.name]
    if data_table == nil then
        return
    else
        return unilib.global.fertile_dirt_table[data_table.dirt_part_name]
    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_woodsoils.get_soil_table(dirt_def_table, full_name)

    local soil_table = nil
    if dirt_def_table.soil ~= nil then

        soil_table = {
            base = full_name,
            dry = dirt_def_table.soil.dry,
            wet = dirt_def_table.soil.wet,
        }

    end

    return soil_table

end

function unilib.pkg.shared_woodsoils.place_litter(pos, replacement_dirt, replacement_turf)

    -- N.B. When the "replacement_dirt" and "replacement_turf" arguments are specified, only the
    --      forest litters based on them are used as replacement nodes (as in the original code)
    -- N.B. Modified original code to prevent woodsoils being placed around logs (param2 < 6 is
    --      based on how minetest_game places logs)

    if (
        core.get_item_group(
            core.get_node({x = pos.x, y = pos.y - 1, z = pos.z}).name,
            "soil"
        ) > 0 or core.get_item_group(
            core.get_node({x = pos.x, y = pos.y - 2, z = pos.z}).name,
            "soil"
        ) > 0
    ) and core.get_node(pos).param2 < 6 then

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

            local node_1a = core.get_node(radius_1a)
            local node_1b = core.get_node(radius_1b)
            local node_2a = core.get_node(radius_2a)
            local node_2b = core.get_node(radius_2b)
            local node_3a = core.get_node(radius_3a)
            local node_3b = core.get_node(radius_3b)

            -- (Close to the tree, replace dirt, soil and grass)
            -- N.B. Original code replaces existing litter, for example in jungle. This version
            --      doesn't do that
            -- N.B. Original code doesn't use heavy litter for anything; it is a nice effect on
            --      non-level surfaces
            if core.get_item_group(node_1a.name, "soil") > 0 and
                    not string.find(node_1a.name, "litter") then

                local this_dirt = replacement_dirt or get_dirt(radius_1a)
                if this_dirt ~= nil then

                    local this_litter = this_dirt .. "_with_litter_forest_medium"
                    if core.registered_nodes[this_litter] ~= nil then
                        core.swap_node(radius_1a, {name = this_litter})
                    end

                end

            end

            if core.get_item_group(node_1b.name, "soil") > 0 and
                    not string.find(node_1b.name, "litter") then

                local this_dirt = replacement_dirt or get_dirt(radius_1b)
                if this_dirt ~= nil then

                    local this_litter = this_dirt .. "_with_litter_forest_heavy"
                    if core.registered_nodes[this_litter] ~= nil then
                        core.swap_node(radius_1b, {name = this_litter})
                    end

                end

            end

            -- (Further away from the tree, replace only turf)
            if unilib.global.dirt_with_turf_table[node_2a.name] ~= nil then

                local this_turf = replacement_turf or node_2a.name
                if this_turf ~= nil then

                    local this_litter = this_turf .. "_with_litter_forest_medium"
                    if core.registered_nodes[this_litter] ~= nil then
                        core.swap_node(radius_2a, {name = this_litter})
                    end

                end

            end

            if unilib.global.dirt_with_turf_table[node_2b.name] ~= nil then

                local this_turf = replacement_turf or node_2b.name
                if this_turf ~= nil then

                    local this_litter = this_turf .. "_with_litter_forest_medium"
                    if core.registered_nodes[this_litter] ~= nil then
                        core.swap_node(radius_2b, {name = this_litter})
                    end

                end

            end

            if unilib.global.dirt_with_turf_table[node_3a.name] ~= nil then

                local this_turf = replacement_turf or node_3a.name
                if this_turf ~= nil then

                    local this_litter = this_turf .. "_with_litter_forest_light"
                    if core.registered_nodes[this_litter] ~= nil then
                        core.swap_node(radius_3a, {name = this_litter})
                    end

                end

            end

            if unilib.global.dirt_with_turf_table[node_3b.name] ~= nil then

                local this_turf = replacement_turf or node_3b.name
                if this_turf ~= nil then

                    local this_litter = this_turf .. "_with_litter_forest_light"
                    if core.registered_nodes[this_litter] ~= nil then
                        core.swap_node(radius_3b, {name = this_litter})
                    end

                end

            end

        end

    end

end

function unilib.pkg.shared_woodsoils.do_dirt(dirt_full_name)

    local dirt_medium_full_name = dirt_full_name .. "_with_litter_forest_medium"
    local dirt_heavy_full_name = dirt_full_name .. "_with_litter_forest_heavy"

    local dirt_medium_orig_name, dirt_heavy_orig_name
    if dirt_full_name == "unilib:dirt_ordinary" then

        dirt_medium_orig_name = "unilib:dirt_ordinary_with_litter_forest_1"
        dirt_heavy_orig_name = "unilib:dirt_ordinary_with_litter_forest_2"

    end

    local dirt_def_table = core.registered_nodes[dirt_full_name]
    if dirt_def_table == nil then
        return
    end

    local dirt_img = dirt_def_table["tiles"][1]

    unilib.register_node(dirt_medium_full_name, dirt_medium_orig_name, mode, {
        -- From woodsoils:dirt_with_leaves_1
        description = S("@1 with Medium Forest Litter", dirt_def_table.description),
        tiles = {
            dirt_img .. "^unilib_litter_forest_medium_overlay.png",
            dirt_img,
            dirt_img .. "^unilib_litter_forest_medium_side_overlay.png",
        },
        -- N.B. not_in_creative_inventory = 1 not in original code
        groups = {crumbly = 3, not_in_creative_inventory = 1, soil = 1},
        sounds = unilib.sound.generate_dirt({
            footstep = {name = "unilib_grass_footstep", gain = 0.4},
        }),

        drop = dirt_full_name,
        is_ground_content = unilib.setting.caves_chop_dirt_flag,
        soil = unilib.pkg.shared_woodsoils.get_soil_table(dirt_def_table, dirt_medium_full_name),
    })

    unilib.register_node(dirt_heavy_full_name, dirt_heavy_orig_name, mode, {
        -- From woodsoils:dirt_with_leaves_2
        description = S("@1 with Heavy Forest Litter", dirt_def_table.description),
        tiles = {
            "unilib_litter_forest_heavy_underlay.png",
            dirt_img,
            dirt_img .. "^unilib_litter_forest_heavy_side_overlay.png",
        },
        -- N.B. not_in_creative_inventory = 1 not in original code
        groups = {crumbly = 3, not_in_creative_inventory = 1, soil = 1},
        sounds = unilib.sound.generate_dirt({
            footstep = {name = "unilib_grass_footstep", gain = 0.4},
        }),

        drop = dirt_full_name,
        is_ground_content = unilib.setting.caves_chop_dirt_flag,
        soil = unilib.pkg.shared_woodsoils.get_soil_table(dirt_def_table, dirt_heavy_full_name),
    })

    -- N.B. This code from the "sickles" mod applies only for the dirt specified by the original
    --      "woodsoils" mod code
    if dirt_full_name == "unilib:dirt_ordinary" then

        -- N.B. Fixed typos in original code, which used the wrong nodes as the first argument
        if unilib.global.pkg_executed_table["grass_dry"] ~= nil then

            unilib.tools.make_cuttable(
                dirt_medium_full_name,
                dirt_full_name,
                "unilib:grass_dry_1"
            )

            unilib.tools.make_cuttable(
                dirt_heavy_full_name,
                dirt_full_name,
                "unilib:grass_dry_1"
            )

        end

    end

end

function unilib.pkg.shared_woodsoils.do_turf(dirt_full_name, turf_full_name)

    local turf_medium_full_name = turf_full_name .. "_with_litter_forest_medium"
    local turf_light_full_name = turf_full_name .. "_with_litter_forest_light"

    local turf_medium_orig_name, turf_light_orig_name
    if turf_full_name == "unilib:dirt_ordinary_with_turf" then

        turf_medium_orig_name = "unilib:dirt_ordinary_with_litter_forest_3"
        turf_light_orig_name = "unilib:dirt_ordinary_with_litter_forest_4"

    end

    local dirt_def_table = core.registered_nodes[dirt_full_name]
    local turf_def_table = core.registered_nodes[turf_full_name]
    if dirt_def_table == nil or turf_def_table == nil then
        return
    end

    local dirt_img = dirt_def_table["tiles"][1]
    local turf_top_img = turf_def_table["tiles"][1]
    local turf_side_img = turf_def_table["tiles"][3]

    unilib.register_node(turf_medium_full_name, turf_medium_orig_name, mode, {
        -- From woodsoils:grass_with_leaves_2
        description = S("@1 with Medium Forest Litter", turf_def_table.description),
        tiles = {
            unilib.utils.concat_img(turf_top_img, "unilib_litter_forest_medium_overlay.png"),
            dirt_img,
            unilib.utils.concat_img(turf_side_img, "unilib_litter_forest_medium_side_overlay.png"),
        },
        -- N.B. not_in_creative_inventory = 1 not in original code
        groups = {crumbly = 3, not_in_creative_inventory = 1, soil = 1},
        sounds = unilib.sound.generate_dirt({
            footstep = {name = "unilib_grass_footstep", gain = 0.4},
        }),

        drop = dirt_full_name,
        is_ground_content = unilib.setting.caves_chop_dirt_flag,
        soil = unilib.pkg.shared_woodsoils.get_soil_table(dirt_def_table, turf_medium_full_name),
    })

    unilib.register_node(turf_light_full_name, turf_light_orig_name, mode, {
        -- From woodsoils:grass_with_leaves_1
        description = S("@1 with Light Forest Litter", turf_def_table.description),
        tiles = {
            unilib.utils.concat_img(turf_top_img, "unilib_litter_forest_light_overlay.png"),
            dirt_img,
            unilib.utils.concat_img(turf_side_img, "unilib_litter_forest_light_side_overlay.png"),
        },
        -- N.B. not_in_creative_inventory = 1 not in original code
        groups = {crumbly = 3, not_in_creative_inventory = 1, soil = 1},
        sounds = unilib.sound.generate_dirt({
            footstep = {name = "unilib_grass_footstep", gain = 0.4},
        }),

        drop = dirt_full_name,
        is_ground_content = unilib.setting.caves_chop_dirt_flag,
        soil = unilib.pkg.shared_woodsoils.get_soil_table(dirt_def_table, turf_light_full_name),
    })

    -- N.B. This code from the "sickles" mod applies only for the dirt specified by the original
    --      "woodsoils" mod code
    if turf_full_name == "unilib:dirt_ordinary_with_turf" then

        -- N.B. Fixed typos in original code, which used the wrong nodes as the first argument
        if unilib.global.pkg_executed_table["grass_ordinary"] ~= nil then

            unilib.tools.make_cuttable(
                turf_medium_full_name,
                dirt_full_name,
                "unilib:grass_ordinary_1"
            )

            unilib.tools.make_cuttable(
                turf_light_full_name,
                dirt_full_name,
                "unilib:grass_ordinary_1"
            )

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_woodsoils.init()

    return {
        description = "Shared functions for forest litter (from plantlife/woodsoils)",
        optional = {"grass_dry", "grass_ordinary"},
    }

end
