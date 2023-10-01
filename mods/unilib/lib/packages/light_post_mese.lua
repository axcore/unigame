---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_post_mese = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_register(data_table)

    -- Adapted from default/functions.lua
    -- Creates a mese light post based on a tree type (already registered in an earlier call to
    --      unilib.register_tree()
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.tree_table
    --      full_name (str): e.g. "unilib:light_post_mese_aspen"
    --      orig_name (str): e.g. "default:mese_post_light_aspen_wood"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      base_img (str): e.g. "unilib_tree_aspen_wood_fence.png"
    --      ingredient (str): e.g. "unilib:tree_aspen_wood"
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local full_name = data_table.full_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local base_img = data_table.base_img or "unilib_tree_" .. part_name .. "_wood.png"
    local ingredient = data_table.ingredient or "unilib:tree_" .. part_name .. "_wood"

    local light_img = base_img .. "^unilib_light_post_mese_side.png^[makealpha:0,0,0"
    local dark_img = base_img .. "^unilib_light_post_mese_side_dark.png^[makealpha:0,0,0"

    -- The calling package should have marked these packages as dependencies
    if unilib.pkg_executed_table["glass_ordinary"] == nil or
            unilib.pkg_executed_table["mineral_mese"] == nil then
        return
    end

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = unilib.brackets(
            S("Mese Light Post"), unilib.tree_table[part_name]["description"]
        ),
        tiles = {base_img, base_img, dark_img, dark_img, light_img, light_img},
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        is_ground_content = false,
        light_source = unilib.light_max,
        node_box = {
            type = "fixed",
            fixed = {
                {-2 / 16, -8 / 16, -2 / 16, 2 / 16, 8 / 16, 2 / 16},
            },
        },
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "opaque",
        wield_image = light_img,
    })

    unilib.register_craft({
        output = full_name .. " 4",
        recipe = {
            {"", "unilib:glass_ordinary", ""},
            {
                "unilib:mineral_mese_crystal",
                "unilib:mineral_mese_crystal",
                "unilib:mineral_mese_crystal",
            },
            {"", ingredient, ""},
        }
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_post_mese.init()

    return {
        description = "Mese light post set",
        notes = "This package creates light posts from a limited range of super trees",
        depends = {"glass_ordinary", "mineral_mese"},
    }

end

function unilib.pkg.light_post_mese.post()

    local tree_list = {
        -- minetest_game trees
        {
            part_name = "acacia",
            orig_name = "default:mese_post_light_acacia_wood",
            base_img = "unilib_tree_acacia_wood_fence.png",
        },
        {
            part_name = "apple",
            orig_name = "default:mese_post_light",
            base_img = "unilib_tree_apple_wood_fence.png",
        },
        {
            part_name = "aspen",
            orig_name = "default:mese_post_light_aspen_wood",
            base_img = "unilib_tree_aspen_wood_fence.png",
        },
        {
            part_name = "jungle",
            orig_name = "default:mese_post_light_junglewood",
            base_img = "unilib_tree_jungle_wood_fence.png",
        },
        {
            part_name = "pine",
            orig_name = "default:mese_post_light_pine_wood",
            base_img = "unilib_tree_pine_wood_fence.png",
        },

        -- Other trees
        {
            part_name = "banana",
            orig_name = "ethereal:mese_post_banana",
            base_img = "unilib_tree_banana_wood.png",
        },
        {
            part_name = "birch",
            orig_name = "ethereal:mese_post_birch",
            base_img = "unilib_tree_birch_wood.png",
        },
        {
            part_name = "frost",
            orig_name = "ethereal:mese_post_frostwood",
            base_img = "unilib_tree_frost_wood.png",
        },
        {
            part_name = "healing",
            orig_name = "ethereal:mese_post_yellowwood",
            base_img = "unilib_tree_healing_wood.png",
        },
        {
            part_name = "mushroom_red",
            orig_name = "ethereal:mese_post_mushroom",
            base_img = "unilib_tree_mushroom_red_trunk.png",

            ingredient = "unilib:tree_mushroom_red_trunk",
        },
        {
            part_name = "palm",
            orig_name = "ethereal:mese_post_palm",
            base_img = "unilib_tree_palm_wood.png",
        },
        {
            part_name = "redwood",
            orig_name = "ethereal:mese_post_redwood",
            base_img = "unilib_tree_redwood_wood.png",
        },
        {
            part_name = "sakura",
            orig_name = "ethereal:mese_post_sakura",
            base_img = "unilib_tree_sakura_wood.png",
        },
        {
            part_name = "scorched",
            orig_name = "ethereal:mese_post_scorched",
            base_img = "unilib_tree_scorched_trunk.png",

            ingredient = "unilib:tree_scorched_trunk",
        },
        {
            part_name = "willow_weeping",
            orig_name = "ethereal:mese_post_willow",
            base_img = "unilib_tree_willow_weeping_wood.png",
        },
    }

    for _, mini_table in pairs(tree_list) do

        -- N.B. some trees from the ethereal mod used tree trunks as the ingredient
        local ingredient = mini_table.ingredient or
                "unilib:tree_" .. mini_table.part_name .. "_wood"

        if unilib.super_tree_table[mini_table.part_name] ~= nil and
                unilib.pkg_executed_table["tree_" .. mini_table.part_name] ~= nil and
                minetest.registered_nodes[ingredient] ~= nil then

            do_register({
                part_name = mini_table.part_name,
                full_name = "unilib:light_post_mese_" .. mini_table.part_name,
                orig_name = mini_table.orig_name,

                replace_mode = mode,
                base_img = mini_table.base_img,
                ingredient = ingredient,
            })

        end

    end

end
