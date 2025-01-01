---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.furniture_cushion_simple_basic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.furniture_cushion_simple_basic.init()

    return {
        description = "Simple cushion set (based on the basic 15 dye set)",
        notes = "Can be sat on, like a chair. Can also be used to break falls",
        depends = "shared_xdecor",
    }

end

function unilib.pkg.furniture_cushion_simple_basic.exec()

    -- Basic cushion set (based on the basic 15 dye set)
    local wool_list = {
        {"black",       S("Simple Black Cushion")},
        {"blue",        S("Simple Blue Cushion")},
        {"brown",       S("Simple Brown Cushion")},
        {"cyan",        S("Simple Cyan Cushion")},
        {"green",       S("Simple Green Cushion")},
        {"green_dark",  S("Simple Dark Green Cushion")},
        {"grey",        S("Simple Grey Cushion")},
        {"grey_dark",   S("Simple Dark Grey Cushion")},
        {"magenta",     S("Simple Magenta Cushion")},
        {"orange",      S("Simple Orange Cushion")},
        {"pink",        S("Simple Pink Cushion")},
        {"red",         S("Simple Red Cushion")},
        {"violet",      S("Simple Violet Cushion")},
        {"white",       S("Simple White Cushion")},
        {"yellow",      S("Simple Yellow Cushion")},
    }

    for _, row_list in ipairs(wool_list) do

        local part_name = row_list[1]
        local description = row_list[2]

        local cushion_name = "unilib:furniture_cushion_simple_" .. part_name
        local block_name = "unilib:furniture_cushion_simple_" .. part_name .. "_block"
        local img = "unilib_furniture_cushion_simple_" .. part_name .. ".png"
        local ingredient = "unilib:wool_" .. part_name

        -- The original xdecor code provides only a single red cushion
        local cushion_orig_name = nil
        local block_orig_name = nil
        if part_name == "red" then

            cushion_orig_name = "xdecor:cushion"
            block_orig_name = "xdecor:cushion_block"

        end

        unilib.register_node(cushion_name, cushion_orig_name, mode, {
            -- From xdecor:cushion
            description = description,
            tiles = {img},
            groups = {fall_damage_add_percent = -50, flammable = 3, snappy = 3},
            sounds = unilib.global.sound_table.node,

            drawtype = "nodebox",
            -- N.B. is_ground_content = false not in original code; added to match other furniture
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
            },
            paramtype = "light",
            paramtype2 = "facedir",

            can_dig = unilib.furniture.can_dig_chair,

            on_place = core.rotate_node,

            on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)

                pos.y = pos.y + 0
                unilib.furniture.do_sit_chair(pos, node, clicker, pointed_thing)
                return itemstack

            end,
        })
        unilib.register_craft({
            -- From xdecor:cushion
            output = cushion_name .. " 3",
            recipe = {
                {ingredient, ingredient, ingredient}
            },
        })

        unilib.register_node(block_name, block_orig_name, mode, {
            -- From xdecor:cushion_block
            description = S("Simple Cushion Block"),
            tiles = {img},
            -- N.B. removed not_in_creative_inventory = 1 from original code
            --[[
            groups = {
                fall_damage_add_percent = -75, flammable = 3, not_in_creative_inventory = 1,
                snappy = 3,
            },
            ]]--
            groups = {fall_damage_add_percent = -75, flammable = 3, snappy = 3},
            sounds = unilib.global.sound_table.node,

            -- N.B. is_ground_content = false not in original code; added to match other furniture
            is_ground_content = false,
            paramtype2 = "facedir",
        })
        unilib.register_craft({
            -- From xdecor:cushion_block
            output = block_name,
            recipe = {
                {cushion_name},
                {cushion_name},
            },
        })
        unilib.register_craft({
            -- Original to unilib
            output = cushion_name .. " 2",
            recipe = {
                {block_name},
            },
        })

    end

end
