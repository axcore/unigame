---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unimobs
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_ordinary_with_turf_racing = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.unimobs.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_ordinary_with_turf_racing.init()

    return {
        description = "Dirt-with-turf nodes for pony racing",
        notes = "By default, pony racing is not much fun, as ponies with maximum speeds will" ..
                " all cross the finish line at the same time. When ponies are ridden over these" ..
                " nodes, their speed will increase or decrease slightly. You can make a fun" ..
                " race course by placing these nodes at random positions all over the course." ..
                " The complete list of nodes that affect a mounted mob's velocity is specified" ..
                " by the racing_nodes.csv file in the remix (generally including the nodes" ..
                " defined by this package); see comments in the \"lqb_obey_driver\" package for" ..
                " further details",
    }

end

function unilib.pkg.dirt_ordinary_with_turf_racing.exec()

    local c_dirt = "unilib:dirt_ordinary"

    unilib.register_node("unilib:dirt_ordinary_with_turf_racing_wet", nil, mode, {
        -- Original to unimobs
        description = S("Ordinary Dirt with Wet Racing Turf"),
        tiles = {
            "unilib_dirt_ordinary_with_turf_racing_wet.png",
            "unilib_dirt_ordinary.png",
            "unilib_dirt_ordinary.png^unilib_turf_ordinary_side_overlay.png",
        },
        groups = {covered_dirt = 1, crumbly = 3, soil = 1},
        sounds = unilib.sound.generate_dirt({
            footstep = {name = "unilib_grass_footstep", gain = 0.4},
        }),

        is_ground_content = false,
    })
    -- N.B. Craft recipe appears below

    unilib.register_node("unilib:dirt_ordinary_with_turf_racing_dry", nil, mode, {
        -- Original to unimobs
        description = S("Ordinary Dirt with Dry Racing Turf"),
        tiles = {
            "unilib_dirt_ordinary_with_turf_racing_dry.png",
            "unilib_dirt_ordinary.png",
            "unilib_dirt_ordinary.png^unilib_turf_ordinary_side_overlay.png",
        },
        groups = {covered_dirt = 1, crumbly = 3, soil = 1},
        sounds = unilib.sound.generate_dirt({
            footstep = {name = "unilib_grass_footstep", gain = 0.4},
        }),

        is_ground_content = false,
    })
    unilib.register_craft({
        -- Original to unimobs
        output = "unilib:dirt_ordinary_with_turf_racing_dry 3",
        recipe = {
            {"group:grass", "group:sand", "group:grass"},
            {c_dirt, c_dirt, c_dirt},
        },
    })

end

function unilib.pkg.dirt_ordinary_with_turf_racing.post()

    local c_dirt = "unilib:dirt_ordinary"

    -- Generate craft recipes
    for bucket_type, _ in pairs(unilib.global.generic_bucket_table) do

        local c_water_bucket = "unilib:" .. bucket_type .. "_with_water_ordinary"
        local c_empty_bucket = "unilib:" .. bucket_type .. "_empty"

        unilib.register_craft({
            -- Original to unimobs
            output = "unilib:dirt_ordinary_with_turf_racing_wet 3",
            recipe = {
                {"group:grass", c_water_bucket, "group:grass"},
                {c_dirt, c_dirt, c_dirt},
            },
            replacements = {
                {c_water_bucket, c_empty_bucket},
            },
        })

    end

end
