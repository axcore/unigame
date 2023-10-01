---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beacons
-- Code:    CC0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.gadget_beacon_basic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beacons.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_node_under_light(pos)

    pos = table.copy(pos)
    local node = minetest.get_node(pos)
    local y_dist = 0

    while minetest.get_item_group(node.name, "beacon_light") ~= 0 and
            (unilib.beacons_height_max == 0 or y_dist <= unilib.beacons_height_max) do

        node = minetest.get_node(vector.subtract(pos, {x = 0, y = y_dist, z = 0}))
        y_dist = y_dist + 1

    end

    return node

end

local function beacon_on_construct(pos, colour)

    local above = vector.add(pos, {x = 0, y = 1, z = 0})
    if get_node_under_light(pos).name == ("unilib:gadget_beacon_base_" .. colour) and
            minetest.get_node(above).name == "air" then
        minetest.set_node(above, {name = "unilib:gadget_beacon_beam_" .. colour})
    end

end

local function beacon_on_destruct(pos, colour)

    local above = vector.add(pos, {x = 0, y = 1, z = 0})
    if minetest.get_node(above).name == ("unilib:gadget_beacon_beam_" .. colour) then
        minetest.remove_node(above)
    end

end

local function beacon_on_timer(pos, colour)

    beacon_on_construct(pos, colour)
    if get_node_under_light(pos).name ~= ("unilib:gadget_beacon_base_" .. colour) then
        minetest.remove_node(pos)
    end

    return true

end

local function prepare_on_construct(colour)

    return function(pos)

        minetest.get_node_timer(pos):start(1)
        return beacon_on_construct(pos, colour)

    end

end

local function prepare_on_destruct(colour)

    return function(pos)
        return beacon_on_destruct(pos, colour)
    end

end

local function prepare_on_timer(colour)

    return function(pos)
        return beacon_on_timer(pos, colour)
    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gadget_beacon_basic.init()

    return {
        description = "Basic beacon set (15 beacons)",
        notes = "Beacons are decorative, and do not affect the player or surroundings",
        depends = {"dye_basic", "light_block_mese", "metal_steel"},
    }

end

function unilib.pkg.gadget_beacon_basic.exec()

    local c_ingot = "unilib:metal_steel_ingot"

    -- Basic beacon set
    local beacon_list = {
        {
            "black", nil, "#292421",
            S("Black Beacon Base"), S("Black Beacon Beam"),
        },
        {
            "blue", "blue", "blue",
            S("Blue Beacon Base"), S("Blue Beacon Beam"),
        },
        {
            "brown", nil, "#A52A2A",
            S("Brown Beacon Base"), S("Brown Beacon Beam"),
        },
        {
            "cyan", "cyan", "cyan",
            S("Cyan Beacon Base"), S("Cyan Beacon Beam"),
        },
        {
            "green", "green", "green",
            S("Green Beacon Base"), S("Green Beacon Beam"),
        },
        {
            "green_dark", nil, "#002600",
            S("Dark Green Beacon Base"), S("Dark Green Beacon Beam"),
        },
        {
            "grey", nil, "#808080",
            S("Grey Beacon Base"), S("Grey Beacon Beam"),
        },
        {
            "grey_dark", nil, "#3C3C3C",
            S("Dark Grey Beacon Base"), S("Dark Grey Beacon Beam"),
        },
        {
            "magenta", "magenta", "magenta",
            S("Magenta Beacon Base"), S("Magenta Beacon Beam"),
        },
        {
            "orange", "orange", "orange",
            S("Orange Beacon Base"), S("Orange Beacon Beam"),
        },
        {
            "pink", nil, "#FFC0CB",
            S("Pink Beacon Base"), S("Pink Beacon Beam"),
        },
        {
            "red", "red", "red",
            S("Red Beacon Base"), S("Red Beacon Beam"),
        },
        {
            "violet", "violet", "violet",
            S("Violet Beacon Base"), S("Violet Beacon Beam"),
        },
        {
            "white", "white", "white",
            S("White Beacon Base"), S("White Beacon Beam"),
        },
        {
            "yellow", "yellow", "yellow",
            S("Yellow Beacon Base"), S("Yellow Beacon Beam"),
        },
    }

    for _, row_list in ipairs(beacon_list) do

        local part_name = row_list[1]
        local orig_name = row_list[2]
        -- (Minetest color_str. Where "#xxxxxx" is specified, the original code did not provide
        --      the beacon; RGBs from the "glass_artisanal_basic" package are used)
        local colour_str = row_list[3]
        local base_description = row_list[4]
        local beam_description = row_list[5]

        local c_dye = "unilib:dye_" .. part_name

        local beacon_orig_name = nil
        local beam_orig_name = nil
        if orig_name ~= nil then

            beacon_orig_name = "beacons:base_" .. orig_name
            beam_orig_name = "beacons:light_" .. orig_name

        end

        unilib.register_node("unilib:gadget_beacon_base_" .. part_name, beacon_orig_name, mode, {
            -- From beacons:base_blue, etc. Creates unilib:gadget_beacon_base_blue, etc
            description = base_description,
            tiles = {
                "unilib_gadget_beacon_base_top.png",
                "unilib_gadget_beacon_base_bottom.png",
                "unilib_gadget_beacon_base_side.png",
            },
            groups = {beacon_base = 1, cracky = 2},
            sounds = unilib.sound_table.metal,

            color = colour_str,
            is_ground_content = false,
            paramtype = "light",

            on_construct = prepare_on_construct(part_name),

            on_destruct = prepare_on_destruct(part_name),

            on_rotate = function() end,

            on_timer = prepare_on_timer(part_name),
        })
        unilib.register_craft({
            -- From beacons:base_blue, etc
            output = "unilib:gadget_beacon_base_" .. part_name,
            recipe = {
                {c_ingot, c_dye, c_ingot},
                {c_ingot, "unilib:light_block_mese", c_ingot},
                {c_ingot, c_ingot, c_ingot},
            },
        })
        unilib.register_craft({
            -- From beacons:base_blue, etc
            type = "shapeless",
            output = "unilib:gadget_beacon_base_" .. part_name,
            recipe = {"group:beacon_base", c_dye},
        })

        unilib.register_node("unilib:gadget_beacon_beam_" .. part_name, beam_orig_name, mode, {
            -- From beacons:light_blue, etc. Creates unilib:gadget_beacon_beam_blue, etc
            description = beam_description,
            tiles = {"unilib_gadget_beacon_beam.png"},
            groups = {beacon_light = 1, not_in_creative_inventory = 1},
            -- (no sounds)

            buildable_to = true,
            color = colour_str,
            damage_per_second = 1,
            diggable = false,
            drawtype = "plantlike",
            drop = "",
            floodable = false,
            light_source = unilib.light_max,
            paramtype = "light",
            pointable = false,
            post_effect_color = part_name,
            sunlight_propagates = true,
            walkable = false,

            on_blast = function() end,

            on_construct = prepare_on_construct(part_name),

            on_destruct = prepare_on_destruct(part_name),

            on_timer = prepare_on_timer(part_name),
        })

    end

end
