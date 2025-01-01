---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights_extras
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_super_with_spotlight = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.morelights_extras.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_light(dirt_part_name, turf_full_name)

    local orig_name
    if turf_full_name == "unilib:dirt_ordinary_with_turf" then
        orig_name = "morelights_extras:dirt_with_grass"
    end

    local full_name = turf_full_name .. "_with_spotlight"
    local def_table = core.registered_nodes[turf_full_name]

    unilib.register_node(full_name, orig_name, mode, {
        -- From morelights_extras:dirt_with_grass
        description = unilib.utils.brackets(S("Dirt Spotlight"), def_table.description),
        tiles = {
            def_table.tiles[1] .. "^unilib_light_spotlight.png",
            def_table.tiles[2],
            def_table.tiles[3],
        },
        groups = {cracky = 2, handy = 1, oddly_breakable_by_hand = 3, soil = 1},
        sounds = unilib.global.sound_table.glass,

        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        light_source = 12,
        paramtype = "light",
    })
    unilib.register_craft({
        -- From morelights_extras:dirt_with_grass
        output = full_name,
        recipe = {
            {"", "unilib:pane_glass_ordinary_flat", ""},
            {"", "unilib:light_bulb_normal", ""},
            -- N.B. Original code used "unilib:grass_ordinary_1"
            {"group:grass", turf_full_name, ""},
        },
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_super_with_spotlight.init()

    return {
        description = "Dirts with spotlights",
        depends = {"light_bulb_normal", "pane_glass_ordinary"},
    }

end

function unilib.pkg.dirt_super_with_spotlight.exec()

    --[[
    unilib.register_node("unilib:light_block_dirt", "morelights_extras:dirt_with_grass", mode, {
        -- From morelights_extras:dirt_with_grass
        description = S("Dirt Lamp"),
        tiles = {
            "unilib_turf_ordinary_top.png^unilib_light_block_overlay.png",
            "unilib_dirt_ordinary.png",
            "unilib_dirt_ordinary.png^unilib_turf_ordinary_side_overlay.png",
        },
        groups = {cracky = 2, handy = 1, oddly_breakable_by_hand = 3, soil = 1},
        sounds = unilib.global.sound_table.glass,

        light_source = 12,
        paramtype = "light",
    })
    unilib.register_craft({
        -- From morelights_extras:dirt_with_grass
        output = "unilib:light_block_dirt",
        recipe = {
            {"", "unilib:pane_glass_ordinary_flat", ""},
            {"", "unilib:light_bulb_normal", ""},
            {"unilib:grass_ordinary_1", "unilib:dirt_ordinary", ""},
        },
    })
    ]]--

    for dirt_part_name, _ in pairs(unilib.global.super_dirt_table) do

        if unilib.global.dirt_with_turf_reverse_table[dirt_part_name] ~= nil then

            for _, turf_full_name in pairs(
                unilib.global.dirt_with_turf_reverse_table[dirt_part_name]
            ) do
                do_light(dirt_part_name, turf_full_name)
            end

        end

    end

end
