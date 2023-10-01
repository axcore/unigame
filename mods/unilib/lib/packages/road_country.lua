---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.road_country = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cottages.add_mode

-- Supported road modes:
--      "simple": only a straight dirt road; no curves, junctions etc
--      "flat": each node is a full node; junction, t-junction and corner are included
--      "nodebox": like flat - except that each node has a nodebox that fits to that road node
--      "mesh": like nodebox - except that it uses a nice roundish model
local road_mode = unilib.cottages_road_mode
if road_mode ~= "simple" and
        road_mode ~= "flat" and
        road_mode ~= "nodebox" and
        road_mode ~= "mesh" then
    road_mode = "mesh"
end
local dirt_img = "unilib_dirt_ordinary.png" -- Replaces "default_dirt.png"
local dirt_grass_img = "unilib_dirt_ordinary.png^unilib_turf_ordinary_side_overlay.png"
                                            -- Replaces "default_dirt.png^default_grass_side.png"
local grass_img = "unilib_turf_ordinary_top.png"
                                            -- Replaces "default_grass.png"

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function register_recipes(include_end_flag)

    local c_straight = "unilib:road_country_straight"

    unilib.register_craft({
        -- From cottages:feldweg_crossing
        output = "unilib:road_country_crossing 5",
        recipe = {
            {"", c_straight, ""},
            {c_straight, c_straight, c_straight},
            {"", c_straight, ""},
        },
    })

    unilib.register_craft({
        -- From cottages:feldweg_t_junction
        output = "unilib:road_country_junction 5",
        recipe = {
            {"", c_straight, ""},
            {"", c_straight, ""},
            {c_straight, c_straight, c_straight}

        },
    })

    unilib.register_craft({
        -- From cottages:feldweg_curve
        output = "unilib:road_country_curve 5",
        recipe = {
            {c_straight, "", ""},
            {c_straight, "", ""},
            {c_straight, c_straight, c_straight}
        },
    })

    if include_end_flag then

        unilib.register_craft({
            -- From cottages:feldweg_end
            output = "unilib:road_country_end 5",
            recipe = {
                {c_straight, "", c_straight },
                {c_straight, c_straight, c_straight}
            },
        })

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.road_country.init()

    return {
        description = "Country roads",
    }

end

function unilib.pkg.road_country.exec()

    local c_straight = "unilib:road_country_straight"

    if road_mode == "simple" or road_mode == "flat" then

        unilib.register_node("unilib:road_country_straight", "cottages:feldweg", mode, {
            -- From cottages:feldweg
            description = S("Straight Country Road"),
            tiles = {
                "unilib_road_country_straight.png",
                dirt_img,
                dirt_grass_img,
            },
            groups = {crumbly = 3},
            sounds = unilib.sound_table.dirt,

            is_ground_content = false,
            paramtype2 = "facedir",
        })
        unilib.register_stairs("unilib:road_country_straight")

    end

    if road_mode == "flat" then

        unilib.register_node("unilib:road_country_crossing", "cottages:feldweg_crossing", mode, {
            -- From cottages:feldweg_crossing
            description = S("Country Road Crossing"),
            tiles = {
                "unilib_road_country_crossing.png",
                dirt_img,
                dirt_grass_img,
            },
            groups = {crumbly = 3},
            sounds = unilib.sound_table.dirt,

            is_ground_content = false,
            paramtype2 = "facedir",
        })

        unilib.register_node("unilib:road_country_junction", "cottages:feldweg_t_junction", mode, {
            -- From cottages:feldweg_t_junction
            description = S("Country Road Junction"),
            tiles = {
                "unilib_road_country_junction.png^[transform2",
                dirt_img,
                dirt_grass_img,
            },
            groups = {crumbly = 3},
            sounds = unilib.sound_table.dirt,

            is_ground_content = false,
            paramtype2 = "facedir",
        })

        unilib.register_node("unilib:road_country_curve", "cottages:feldweg_curve", mode, {
            -- From cottages:feldweg_curve
            description = S("Curved Country Road"),
            tiles = {
                "unilib_road_country_curve.png^[transform2",
                dirt_img,
                dirt_grass_img,
            },
            groups = {crumbly = 3},
            sounds = unilib.sound_table.dirt,

            is_ground_content = false,
            paramtype2 = "facedir",
        })

        register_recipes(false)

    elseif road_mode == "nodebox" then

        unilib.register_node("unilib:road_country_straight", "cottages:feldweg", mode, {
            -- From cottages:feldweg
            description = S("Straight Country Road"),
            tiles = {
                "unilib_road_country_straight.png",
                dirt_img,
                dirt_grass_img,
            },
            groups = {crumbly = 3},
            sounds = unilib.sound_table.dirt,

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
        unilib.register_stairs("unilib:road_country_straight")

        unilib.register_node("unilib:road_country_crossing", "cottages:feldweg_crossing", mode, {
            -- From cottages:feldweg_crossing
            description = S("Country Road Crossing"),
            tiles = {
                "unilib_road_country_crossing.png",
                dirt_img,
                dirt_grass_img,
            },
            groups = {crumbly = 3},
            sounds = unilib.sound_table.dirt,

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

        unilib.register_node("unilib:road_country_junction", "cottages:feldweg_t_junction", mode, {
            -- From cottages:feldweg_t_junction
            description = S("Country Road Junction"),
            tiles = {
                "unilib_road_country_junction.png^[transform2",
                dirt_img,
                dirt_grass_img,
            },
            groups = {crumbly = 3},
            sounds = unilib.sound_table.dirt,

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

        unilib.register_node("unilib:road_country_curve", "cottages:feldweg_curve", mode, {
            -- From cottages:feldweg_curve
            description = S("Curved Country Road"),
            tiles = {
                "unilib_road_country_curve.png^[transform2",
                dirt_img,
                dirt_grass_img,
            },
            groups = {crumbly = 3},
            sounds = unilib.sound_table.dirt,

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

        register_recipes(false)

    elseif road_mode == "mesh" then

        unilib.register_node("unilib:road_country_straight", "cottages:feldweg", mode, {
            -- From cottages:feldweg
            description = S("Straight Country Road"),
            tiles = {
                "unilib_road_country_end.png",
                dirt_grass_img,
                dirt_img,
                grass_img,
                "unilib_road_country_surface.png",
                "unilib_road_country_surface.png^unilib_road_country_edges_overlay.png",
            },
            groups = {crumbly = 3},
            sounds = unilib.sound_table.dirt,

            drawtype = "mesh",
            is_ground_content = false,
            mesh = "unilib_road_country_straight.obj",
            paramtype = "light",
            paramtype2 = "facedir",
        })
        unilib.register_stairs("unilib:road_country_straight")

        unilib.register_node("unilib:road_country_crossing", "cottages:feldweg_crossing", mode, {
            -- From cottages:feldweg_crossing
            description = S("Country Road Crossing"),
            tiles = {
                "unilib_road_country_end.png",
                dirt_img,
                grass_img,
                "unilib_road_country_surface.png",
                "unilib_road_country_surface.png^unilib_road_country_edges_overlay.png",
            },
            groups = {crumbly = 3},
            sounds = unilib.sound_table.dirt,

            drawtype = "mesh",
            is_ground_content = false,
            mesh = "unilib_road_country_crossing.obj",
            paramtype = "light",
            paramtype2 = "facedir",
        })

        unilib.register_node("unilib:road_country_junction", "cottages:feldweg_t_junction", mode, {
            -- From cottages:feldweg_t_junction
            description = S("Country Road Junction"),
            tiles = {
                "unilib_road_country_end.png",
                dirt_grass_img,
                dirt_img,
                grass_img,
                "unilib_road_country_surface.png",
                "unilib_road_country_surface.png^unilib_road_country_edges_overlay.png",
            },
            groups = {crumbly = 3},
            sounds = unilib.sound_table.dirt,

            drawtype = "mesh",
            is_ground_content = false,
            mesh = "unilib_road_country_junction.obj",
            paramtype = "light",
            paramtype2 = "facedir",
        })

        unilib.register_node("unilib:road_country_curve", "cottages:feldweg_curve", mode, {
            -- From cottages:feldweg_curve
            description = S("Curved Country Road"),
            tiles = {
                dirt_grass_img,
                grass_img,
                dirt_grass_img,
                "unilib_road_country_surface.png",
                dirt_img,
                "unilib_road_country_surface.png^unilib_road_country_edges_overlay.png",
            },
            groups = {crumbly = 3},
            sounds = unilib.sound_table.dirt,

            drawtype = "mesh",
            is_ground_content = false,
            mesh = "unilib_road_country_curve.obj",
            paramtype = "light",
            paramtype2 = "facedir",
        })

        unilib.register_node("unilib:road_country_end", "cottages:feldweg_end", mode, {
            -- From cottages:feldweg_end
            description = S("End of Country Road"),
            tiles = {
                "unilib_road_country_end.png",
                dirt_grass_img,
                dirt_img,
                grass_img,
                "unilib_road_country_surface.png^unilib_road_country_edges_overlay.png",
                "unilib_road_country_surface.png",
            },
            groups = {crumbly = 3},
            sounds = unilib.sound_table.dirt,

            drawtype = "mesh",
            is_ground_content = false,
            mesh = "unilib_road_country_end.obj",
            paramtype = "light",
            paramtype2 = "facedir",
        })

        register_recipes(true)

    end

    if road_mode == "nodebox" or road_mode == "mesh" then

        local slope_table = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
                {-0.5, -0.25, -0.25, 0.5, 0, 0.5},
                {-0.5, 0, 0, 0.5, 0.25, 0.5},
                {-0.5, 0.25, 0.25, 0.5, 0.5, 0.5},
            }
        }

        local long_slope_table = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -1.5, 0.5, -0.10, 0.5},
                {-0.5, -0.25, -1.3, 0.5, -0.25, 0.5},
                {-0.5, -0.25, -1.0, 0.5, 0, 0.5},
                {-0.5, 0, -0.5, 0.5, 0.25, 0.5},
                {-0.5, 0.25, 0, 0.5, 0.5, 0.5},
            }
        }

        unilib.register_node("unilib:road_country_slope", "cottages:feldweg_slope", mode, {
            -- From cottages:feldweg_slope
            description = S("Country Road Slope"),
            tiles = {
                "unilib_road_country_end.png",
                dirt_grass_img,
                dirt_img,
                grass_img,
                "unilib_road_country_surface.png",
                "unilib_road_country_surface.png^unilib_road_country_edges_overlay.png",
            },
            groups = {crumbly = 3},
            sounds = unilib.sound_table.dirt,

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
            output = "unilib:road_country_slope 3",
            recipe = {
                {c_straight, "", "" },
                {c_straight, c_straight, ""}
            },
        })

        unilib.register_node(
            -- From cottages:feldweg_slope_long
            "unilib:road_country_slope_long",
            "cottages:feldweg_slope_long",
            mode,
            {
                description = S("Country Road Long Slope"),
                tiles = {
                    "unilib_road_country_end.png",
                    dirt_grass_img,
                    dirt_img,
                    grass_img,
                    "unilib_road_country_surface.png",
                    "unilib_road_country_surface.png^unilib_road_country_edges_overlay.png",
                },
                groups = {crumbly = 3},
                sounds = unilib.sound_table.dirt,

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
            output = "unilib:road_country_slope_long 4",
            recipe = {
                {c_straight, "", "" },
                {c_straight, c_straight, c_straight}
            },
        })

    end

end
