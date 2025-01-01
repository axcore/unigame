---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.road_country = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cottages.add_mode

-- Supported road modes:
--      "simple": only a straight dirt road; no curves, junctions etc
--      "flat": each node is a full node; junction, t-junction and corner are included
--      "nodebox": like flat - except that each node has a nodebox that fits to that road node
--      "mesh": like nodebox - except that it uses a nice roundish model
local road_mode = unilib.setting.cottages_road_mode
if road_mode ~= "simple" and
        road_mode ~= "flat" and
        road_mode ~= "nodebox" and
        road_mode ~= "mesh" then
    road_mode = "mesh"
end

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function register_recipes(full_name, include_end_flag)

    local c_straight = full_name .. "_with_road_country_straight"

    unilib.register_craft({
        -- From cottages:feldweg_crossing
        output = full_name .. "_with_road_country_crossing 5",
        recipe = {
            {"", c_straight, ""},
            {c_straight, c_straight, c_straight},
            {"", c_straight, ""},
        },
    })

    unilib.register_craft({
        -- From cottages:feldweg_t_junction
        output = full_name .. "_with_road_country_junction 5",
        recipe = {
            {"", c_straight, ""},
            {"", c_straight, ""},
            {c_straight, c_straight, c_straight}

        },
    })

    unilib.register_craft({
        -- From cottages:feldweg_curve
        output = full_name .. "_with_road_country_curve 5",
        recipe = {
            {c_straight, "", ""},
            {c_straight, "", ""},
            {c_straight, c_straight, c_straight}
        },
    })

    if include_end_flag then

        unilib.register_craft({
            -- From cottages:feldweg_end
            output = full_name .. "_with_road_country_end 5",
            recipe = {
                {c_straight, "", c_straight },
                {c_straight, c_straight, c_straight}
            },
        })

    end

end

local function do_road(dirt_part_name, full_name)

    local c_straight = full_name .. "_with_road_country_straight"

    -- e.g. "dirt_ordinary"
    local dirt_full_name = unilib.global.fertile_dirt_table[dirt_part_name]
    if dirt_full_name == nil then
        return
    end

    local dirt_def_table = core.registered_nodes[dirt_full_name]
    if dirt_def_table == nil then
        return
    end

    -- Replaces "default_dirt.png"
    local dirt_img = dirt_def_table["tiles"][1]

    -- e.g. "unilib:dirt_ordinary_with_turf"
    local turf_def_table = core.registered_nodes[full_name]
    if turf_def_table == nil then
        return
    end

    -- Replaces "default_grass.png"
    local grass_img = turf_def_table["tiles"][1]
    -- Replaces "default_dirt.png^default_grass_side.png"
    local dirt_grass_img = turf_def_table["tiles"][3]

    local straight_orig_name, crossing_orig_name, junction_orig_name, curve_orig_name,
            end_orig_name, slope_orig_name, long_slope_orig_name
    if full_name == "unilib:dirt_ordinary_with_turf" then

        straight_orig_name = "cottages:feldweg"
        crossing_orig_name = "cottages:feldweg_crossing"
        junction_orig_name = "cottages:feldweg_t_junction"
        curve_orig_name = "cottages:feldweg_curve"
        end_orig_name = "cottages:feldweg_end"
        slope_orig_name = "cottages:feldweg_slope"
        long_slope_orig_name = "cottages:feldweg_slope_long"

    end

    if road_mode == "simple" or road_mode == "flat" then

        unilib.register_node(full_name .. "_with_road_country_straight", straight_orig_name, mode, {
            -- From cottages:feldweg
            description =
                    unilib.utils.brackets(turf_def_table.description, S("Straight Country Road")),
            tiles = {
                unilib.utils.concat_img(grass_img, "unilib_road_country_straight_overlay.png"),
                dirt_img,
                dirt_grass_img,
            },
            groups = {crumbly = 3},
            sounds = unilib.global.sound_table.dirt,

            is_ground_content = false,
            paramtype2 = "facedir",
        })
        unilib.register_stairs(full_name .. "_with_road_country_straight")

    end

    if road_mode == "flat" then

        unilib.register_node(full_name .. "_with_road_country_crossing", crossing_orig_name, mode, {
            -- From cottages:feldweg_crossing
            description =
                    unilib.utils.brackets(turf_def_table.description, S("Country Road Crossing")),
            tiles = {
                unilib.utils.concat_img(grass_img, "unilib_road_country_crossing_overlay.png"),
                dirt_img,
                dirt_grass_img,
            },
            groups = {crumbly = 3},
            sounds = unilib.global.sound_table.dirt,

            is_ground_content = false,
            paramtype2 = "facedir",
        })

        unilib.register_node(full_name .. "_with_road_country_junction", junction_orig_name, mode, {
            -- From cottages:feldweg_t_junction
            description =
                    unilib.utils.brackets(turf_def_table.description, S("Country Road Junction")),
            tiles = {
                unilib.utils.concat_img(
                    grass_img, "unilib_road_country_junction_overlay.png^[transform2"
                ),
                dirt_img,
                dirt_grass_img,
            },
            groups = {crumbly = 3},
            sounds = unilib.global.sound_table.dirt,

            is_ground_content = false,
            paramtype2 = "facedir",
        })

        unilib.register_node(full_name .. "_with_road_country_curve", curve_orig_name, mode, {
            -- From cottages:feldweg_curve
            description =
                    unilib.utils.brackets(turf_def_table.description, S("Curved Country Road")),
            tiles = {
                unilib.utils.concat_img(
                    grass_img, "unilib_road_country_curve_overlay.png^[transform2"
                ),
                dirt_img,
                dirt_grass_img,
            },
            groups = {crumbly = 3},
            sounds = unilib.global.sound_table.dirt,

            is_ground_content = false,
            paramtype2 = "facedir",
        })

        register_recipes(full_name, false)

    elseif road_mode == "nodebox" then

        unilib.register_node(full_name .. "_with_road_country_straight", straight_orig_name, mode, {
            -- From cottages:feldweg
            description =
                    unilib.utils.brackets(turf_def_table.description, S("Straight Country Road")),
            tiles = {
                unilib.utils.concat_img(grass_img, "unilib_road_country_straight_overlay.png"),
                dirt_img,
                dirt_grass_img,
            },
            groups = {crumbly = 3},
            sounds = unilib.global.sound_table.dirt,

            drawtype = "nodebox",
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.5, 0.5, 0.5-2/16, 0.5},
                    {-0.5, 0.5-2/16, -0.5, -0.5+3/16, 0.5, 0.5},
                    {0.5-3/16, 0.5-2/16, -0.5, 0.5, 0.5, 0.5},
                    {-0.5+3/16, 0.5-2/16, -0.5, -0.5+4/16, 0.5-1/16, 0.5},
                    {0.5-4/16, 0.5-2/16, -0.5, 0.5-3/16, 0.5-1/16, 0.5},
                },
            },
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
                },
            },
        })
        unilib.register_stairs(full_name .. "_with_road_country_straight")

        unilib.register_node(full_name .. "_with_road_country_crossing", crossing_orig_name, mode, {
            -- From cottages:feldweg_crossing
            description =
                    unilib.utils.brackets(turf_def_table.description, S("Country Road Crossing")),
            tiles = {
                unilib.utils.concat_img(grass_img, "unilib_road_country_crossing_overlay.png"),
                dirt_img,
                dirt_grass_img,
            },
            groups = {crumbly = 3},
            sounds = unilib.global.sound_table.dirt,

            drawtype = "nodebox",
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.5, 0.5, 0.5-2/16, 0.5},
                    {-0.5, 0.5-2/16, -0.5, -0.5+3/16, 0.5, -0.5+3/16},
                    {0.5-3/16, 0.5-2/16, -0.5, 0.5, 0.5, -0.5+3/16},
                    {-0.5, 0.5-2/16, 0.5-3/16, -0.5+3/16, 0.5, 0.5},
                    {0.5-3/16, 0.5-2/16, 0.5-3/16, 0.5, 0.5, 0.5},
                    {-0.5+3/16, 0.5-2/16, -0.5, -0.5+4/16, 0.5-1/16, -0.5+4/16},
                    {0.5-4/16, 0.5-2/16, -0.5, 0.5-3/16, 0.5-1/16, -0.5+4/16},
                    {-0.5+3/16, 0.5-2/16, 0.5-4/16, -0.5+4/16, 0.5-1/16, 0.5},
                    {0.5-4/16, 0.5-2/16, 0.5-4/16, 0.5-3/16, 0.5-1/16, 0.5},
                    {-0.5, 0.5-2/16, -0.5+3/16, -0.5+3/16, 0.5-1/16, -0.5+4/16},
                    {0.5-3/16, 0.5-2/16, -0.5+3/16, 0.5, 0.5-1/16, -0.5+4/16},
                    {-0.5, 0.5-2/16, 0.5-4/16, -0.5+3/16, 0.5-1/16, 0.5-3/16},
                    {0.5-3/16, 0.5-2/16, 0.5-4/16, 0.5, 0.5-1/16, 0.5-3/16},
                },
            },
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
                },
            },
        })

        unilib.register_node(full_name .. "_with_road_country_junction", junction_orig_name, mode, {
            -- From cottages:feldweg_t_junction
            description =
                    unilib.utils.brackets(turf_def_table.description, S("Country Road Junction")),
            tiles = {
                unilib.utils.concat_img(
                    grass_img, "unilib_road_country_junction_overlay.png^[transform2"
                ),
                dirt_img,
                dirt_grass_img,
            },
            groups = {crumbly = 3},
            sounds = unilib.global.sound_table.dirt,

            drawtype = "nodebox",
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.5,  0.5, 0.5-2/16, 0.5},
                    {-0.5, 0.5-2/16, -0.5, -0.5+3/16, 0.5, -0.5+3/16},
                    {-0.5, 0.5-2/16, 0.5-3/16, -0.5+3/16, 0.5, 0.5},
                    {0.5-3/16, 0.5-2/16, -0.5, 0.5, 0.5, 0.5},
                    {-0.5+3/16, 0.5-2/16, -0.5, -0.5+4/16, 0.5-1/16, -0.5+4/16},
                    {-0.5+3/16, 0.5-2/16, 0.5-4/16, -0.5+4/16, 0.5-1/16, 0.5},
                    {-0.5, 0.5-2/16, -0.5+3/16, -0.5+3/16, 0.5-1/16, -0.5+4/16},
                    {-0.5, 0.5-2/16, 0.5-4/16, -0.5+3/16, 0.5-1/16, 0.5-3/16},
                    {0.5-4/16, 0.5-2/16, -0.5, 0.5-3/16, 0.5-1/16, 0.5},
                },
            },
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
                },
            },
        })

        unilib.register_node(full_name .. "_with_road_country_curve", curve_orig_name, mode, {
            -- From cottages:feldweg_curve
            description =
                    unilib.utils.brackets(turf_def_table.description, S("Curved Country Road")),
            tiles = {
                unilib.utils.concat_img(
                    grass_img, "unilib_road_country_curve_overlay.png^[transform2"
                ),
                dirt_img,
                dirt_grass_img,
            },
            groups = {crumbly = 3},
            sounds = unilib.global.sound_table.dirt,

            drawtype = "nodebox",
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.5, 0.5, 0.5-2/16, 0.5},
                    {-0.5, 0.5-2/16, -0.5, 0.5-3/16, 0.5, -0.5+3/16},
                    {-0.5, 0.5-2/16, 0.5-3/16, -0.5+3/16, 0.5, 0.5},
                    {0.5-3/16, 0.5-2/16, -0.5, 0.5, 0.5, 0.5},
                    {-0.5+3/16, 0.5-2/16, 0.5-4/16, -0.5+4/16, 0.5-1/16, 0.5},
                    {-0.5, 0.5-2/16, -0.5+3/16, 0.5-3/16, 0.5-1/16, -0.5+4/16},
                    {-0.5, 0.5-2/16, 0.5-4/16, -0.5+3/16, 0.5-1/16, 0.5-3/16},
                    {0.5-4/16, 0.5-2/16, -0.5, 0.5-3/16, 0.5-1/16, 0.5},
                },
            },
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
                },
            },
        })

        register_recipes(full_name, false)

    elseif road_mode == "mesh" then

        unilib.register_node(full_name .. "_with_road_country_straight", straight_orig_name, mode, {
            -- From cottages:feldweg
            description =
                    unilib.utils.brackets(turf_def_table.description, S("Straight Country Road")),
            tiles = {
                unilib.utils.concat_img(dirt_grass_img, "unilib_road_country_end_overlay.png"),
                dirt_grass_img,
                dirt_img,
                grass_img,
                "unilib_road_country_surface.png",
--              "unilib_road_country_surface.png^unilib_road_country_edges_overlay.png",
                unilib.utils.concat_img(grass_img, "unilib_road_country_edges_overlay.png"),
            },
            groups = {crumbly = 3},
            sounds = unilib.global.sound_table.dirt,

            drawtype = "mesh",
            is_ground_content = false,
            mesh = "unilib_road_country_straight.obj",
            paramtype = "light",
            paramtype2 = "facedir",
        })
        unilib.register_stairs(full_name .. "_with_road_country_straight")

        unilib.register_node(full_name .. "_with_road_country_crossing", crossing_orig_name, mode, {
            -- From cottages:feldweg_crossing
            description =
                    unilib.utils.brackets(turf_def_table.description, S("Country Road Crossing")),
            tiles = {
                unilib.utils.concat_img(dirt_grass_img, "unilib_road_country_end_overlay.png"),
                dirt_img,
                grass_img,
                "unilib_road_country_surface.png",
--              "unilib_road_country_surface.png^unilib_road_country_edges_overlay.png",
                unilib.utils.concat_img(grass_img, "unilib_road_country_edges_overlay.png"),
            },
            groups = {crumbly = 3},
            sounds = unilib.global.sound_table.dirt,

            drawtype = "mesh",
            is_ground_content = false,
            mesh = "unilib_road_country_crossing.obj",
            paramtype = "light",
            paramtype2 = "facedir",
        })

        unilib.register_node(full_name .. "_with_road_country_junction", junction_orig_name, mode, {
            -- From cottages:feldweg_t_junction
            description =
                    unilib.utils.brackets(turf_def_table.description, S("Country Road Junction")),
            tiles = {
                unilib.utils.concat_img(dirt_grass_img, "unilib_road_country_end_overlay.png"),
                dirt_grass_img,
                dirt_img,
                grass_img,
                "unilib_road_country_surface.png",
--              "unilib_road_country_surface.png^unilib_road_country_edges_overlay.png",
                unilib.utils.concat_img(grass_img, "unilib_road_country_edges_overlay.png"),
            },
            groups = {crumbly = 3},
            sounds = unilib.global.sound_table.dirt,

            drawtype = "mesh",
            is_ground_content = false,
            mesh = "unilib_road_country_junction.obj",
            paramtype = "light",
            paramtype2 = "facedir",
        })

        unilib.register_node(full_name .. "_with_road_country_curve", curve_orig_name, mode, {
            -- From cottages:feldweg_curve
            description =
                    unilib.utils.brackets(turf_def_table.description, S("Curved Country Road")),
            tiles = {
                dirt_grass_img,
                grass_img,
                dirt_grass_img,
                "unilib_road_country_surface.png",
                dirt_img,
--              "unilib_road_country_surface.png^unilib_road_country_edges_overlay.png",
                unilib.utils.concat_img(grass_img, "unilib_road_country_edges_overlay.png"),
            },
            groups = {crumbly = 3},
            sounds = unilib.global.sound_table.dirt,

            drawtype = "mesh",
            is_ground_content = false,
            mesh = "unilib_road_country_curve.obj",
            paramtype = "light",
            paramtype2 = "facedir",
        })

        unilib.register_node(full_name .. "_with_road_country_end", end_orig_name, mode, {
            -- From cottages:feldweg_end
            description =
                    unilib.utils.brackets(turf_def_table.description, S("End of Country Road")),
            tiles = {
                unilib.utils.concat_img(dirt_grass_img, "unilib_road_country_end_overlay.png"),
                dirt_grass_img,
                dirt_img,
                grass_img,
--                "unilib_road_country_surface.png^unilib_road_country_edges_overlay.png",
                unilib.utils.concat_img(grass_img, "unilib_road_country_edges_overlay.png"),
                "unilib_road_country_surface.png",
            },
            groups = {crumbly = 3},
            sounds = unilib.global.sound_table.dirt,

            drawtype = "mesh",
            is_ground_content = false,
            mesh = "unilib_road_country_end.obj",
            paramtype = "light",
            paramtype2 = "facedir",
        })

        register_recipes(full_name, true)

    end

    if road_mode == "nodebox" or road_mode == "mesh" then

        local slope_table = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
                {-0.5, -0.25, -0.25, 0.5, 0, 0.5},
                {-0.5, 0, 0, 0.5, 0.25, 0.5},
                {-0.5, 0.25, 0.25, 0.5, 0.5, 0.5},
            },
        }

        local long_slope_table = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -1.5, 0.5, -0.10, 0.5},
                {-0.5, -0.25, -1.3, 0.5, -0.25, 0.5},
                {-0.5, -0.25, -1.0, 0.5, 0, 0.5},
                {-0.5, 0, -0.5, 0.5, 0.25, 0.5},
                {-0.5, 0.25, 0, 0.5, 0.5, 0.5},
            },
        }

        unilib.register_node(full_name .. "_with_road_country_slope", slope_orig_name, mode, {
            -- From cottages:feldweg_slope
            description =
                    unilib.utils.brackets(turf_def_table.description, S("Country Road Slope")),
            tiles = {
                unilib.utils.concat_img(dirt_grass_img, "unilib_road_country_end_overlay.png"),
                dirt_grass_img,
                dirt_img,
                grass_img,
                "unilib_road_country_surface.png",
--              "unilib_road_country_surface.png^unilib_road_country_edges_overlay.png",
                unilib.utils.concat_img(grass_img, "unilib_road_country_edges_overlay.png"),
            },
            groups = {crumbly = 3},
            sounds = unilib.global.sound_table.dirt,

            collision_box = slope_table,
            drawtype = "mesh",
            is_ground_content = false,
            mesh = "unilib_road_country_slope.obj",
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = slope_table,
        })
        unilib.register_craft({
            -- From cottages:feldweg_slope
            output = full_name .. "_with_road_country_slope 3",
            recipe = {
                {c_straight, "", "" },
                {c_straight, c_straight, ""},
            },
        })

        unilib.register_node(
            -- From cottages:feldweg_slope_long
            full_name .. "_with_road_country_slope_long",
            long_slope_orig_name,
            mode,
            {
                description = unilib.utils.brackets(
                    turf_def_table.description, S("Country Road Long Slope")
                ),
                tiles = {
                    unilib.utils.concat_img(dirt_grass_img, "unilib_road_country_end_overlay.png"),
                    dirt_grass_img,
                    dirt_img,
                    grass_img,
                    "unilib_road_country_surface.png",
--                  "unilib_road_country_surface.png^unilib_road_country_edges_overlay.png",
                    unilib.utils.concat_img(grass_img, "unilib_road_country_edges_overlay.png"),
                },
                groups = {crumbly = 3},
                sounds = unilib.global.sound_table.dirt,

                collision_box = long_slope_table,
                drawtype = "mesh",
                is_ground_content = false,
                mesh = "unilib_road_country_slope_long.obj",
                paramtype = "light",
                paramtype2 = "facedir",
                selection_box = long_slope_table,
            }
        )
        unilib.register_craft({
            -- From cottages:feldweg_slope_long
            output = full_name .. "_with_road_country_slope_long 4",
            recipe = {
                {c_straight, "", "" },
                {c_straight, c_straight, c_straight}
            },
        })

    end

    -- Basic crafting recipe. Run a wagon wheel over dirt, and retain the wheel afterwards
    unilib.register_craft({
        -- From cottages:wagon_wheel
        output = c_straight .. " 4",
        recipe = {
            {"", "unilib:misc_wheel_wagon", ""},
            {full_name, full_name, full_name}
        },
        replacements = {
            {"unilib:misc_wheel_wagon", "unilib:misc_wheel_wagon"},
        },
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.road_country.init()

    return {
        description = "Country roads",
        notes = "Cuts country roads into dirt-with-turf nodes, using all available super dirts." ..
                " The number of roads available, as well as their appearance, depends on a" ..
                " Minetest setting",
        depends = "misc_wheel_wagon",
    }

end

function unilib.pkg.road_country.post()

    for dirt_part_name, _ in pairs(unilib.global.super_dirt_table) do

        if unilib.global.dirt_with_turf_reverse_table[dirt_part_name] ~= nil then

            for _, full_name in pairs(unilib.global.dirt_with_turf_reverse_table[dirt_part_name]) do
                do_road(dirt_part_name, full_name)
            end

        end

    end

end
