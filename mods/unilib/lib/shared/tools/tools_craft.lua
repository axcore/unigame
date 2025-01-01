---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- tools_craft.lua
--      Register standard craft recipes
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Register standard craft recipes
---------------------------------------------------------------------------------------------------

function unilib.tools._register_craft_axe(data_table)

    -- Adapted from default/tools.lua
    -- Function to create a standard craft recipe for the specified axe
    -- Unlike the original minetest_game code, this function can also produce the mirror image
    --      craft recipe
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "bronze"
    --      ingredient (str): e.g. "unilib:metal_bronze_ingot"

    local part_name = data_table.part_name
    local ingredient = data_table.ingredient

    unilib.register_craft({
        output = "unilib:tool_axe_" .. part_name,
        recipe = {
            {ingredient, ingredient},
            {ingredient, "group:stick"},
            {"", "group:stick"},
        },
    })

    if unilib.setting.mtgame_tweak_flag then

        -- (Mirror image craft recipe)
        unilib.register_craft({
            output = "unilib:tool_axe_" .. part_name,
            recipe = {
                {"", ingredient, ingredient},
                {"", "group:stick", ingredient},
                {"", "group:stick", ""},
            },
        })

    end

end

function unilib.tools._register_craft_chainsaw(data_table)

    -- Adapted from xtraores/init.lua
    -- Function to create a standard craft recipe for the specified chainsaw (an overpowered axe)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "tritonium"
    --      ingredient (str): e.g. "unilib:metal_tritonium_ingot"
    --      minor_ingredient (str): e.g. "unilib:metal_steel_ingot"

    local part_name = data_table.part_name
    local ingredient = data_table.ingredient
    local minor_ingredient = data_table.minor_ingredient

    unilib.register_craft({
        output = "unilib:tool_chainsaw_" .. part_name,
        recipe = {
            {minor_ingredient, ingredient},
            {minor_ingredient, ingredient},
            {"", ingredient},
        },
   })

   if unilib.setting.mtgame_tweak_flag then

        -- (Mirror image craft recipe)
        unilib.register_craft({
            output = "unilib:tool_chainsaw_" .. part_name,
            recipe = {
                {ingredient, minor_ingredient},
                {ingredient, minor_ingredient},
                {ingredient, ""},
            },
        })

    end

end

function unilib.tools._register_craft_drill(data_table)

    -- Adapted from xtraores/init.lua
    -- Function to create a standard craft recipe for the specified drill (an overpowered pickaxe)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "tritonium"
    --      ingredient (str): e.g. "unilib:metal_tritonium_ingot"
    --      minor_ingredient (str): e.g. "unilib:mineral_diamond_gem"

    local part_name = data_table.part_name
    local ingredient = data_table.ingredient
    local minor_ingredient = data_table.minor_ingredient

    unilib.register_craft({
        output = "unilib:tool_chainsaw_" .. part_name,
        recipe = {
            {ingredient, ingredient, ingredient},
            {"", ingredient, ""},
            {"", minor_ingredient, ""},
        },
   })

end

function unilib.tools._register_craft_pick(data_table)

    -- Adapted from default/tools.lua
    -- Function to create a standard craft recipe for the specified pickaxe
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "bronze"
    --      ingredient (str): e.g. "unilib:metal_bronze_ingot"


    local part_name = data_table.part_name
    local ingredient = data_table.ingredient

    unilib.register_craft({
        output = "unilib:tool_pick_" .. part_name,
        recipe = {
            {ingredient, ingredient, ingredient},
            {"", "group:stick", ""},
            {"", "group:stick", ""},
        },
    })

end

function unilib.tools._register_craft_scythe(data_table)

    -- Adapted from sickles/tools.lua
    -- Function to create a standard craft recipe for the specified scythe
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "bronze"
    --      ingredient (str): e.g. "unilib:metal_bronze_ingot"

    local part_name = data_table.part_name
    local ingredient = data_table.ingredient

    unilib.register_craft({
        output = "unilib:tool_scythe_" .. part_name,
        recipe = {
            {"", ingredient, ingredient},
            {ingredient, "", "group:stick"},
            {"", "", "group:stick"},
        },
    })

end

function unilib.tools._register_craft_shovel(data_table)

    -- Adapted from default/tools.lua
    -- Function to create a standard craft recipe for the specified shovel
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "bronze"
    --      ingredient (str): e.g. "unilib:metal_bronze_ingot"

    local part_name = data_table.part_name
    local ingredient = data_table.ingredient

    unilib.register_craft({
        output = "unilib:tool_shovel_" .. part_name,
        recipe = {
            {ingredient},
            {"group:stick"},
            {"group:stick"},
        },
    })

end

function unilib.tools._register_craft_sickle(data_table)

    -- Adapted from sickles/tools.lua
    -- Function to create a standard craft recipe for the specified sickle
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "bronze"
    --      ingredient (str): e.g. "unilib:metal_bronze_ingot"

    local part_name = data_table.part_name
    local ingredient = data_table.ingredient

    unilib.register_craft({
        output = "unilib:tool_sickle_" .. part_name,
        recipe = {
            {ingredient, ""},
            {"", ingredient},
            {"group:stick", ""},
        },
    })

end

function unilib.tools._register_craft_sword(data_table)

    -- Adapted from default/tools.lua
    -- Function to create a standard craft recipe for the specified sword
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "bronze"
    --      ingredient (str): e.g. "unilib:metal_bronze_ingot"

    local part_name = data_table.part_name
    local ingredient = data_table.ingredient

    unilib.register_craft({
        output = "unilib:tool_sword_" .. part_name,
        recipe = {
            {ingredient},
            {ingredient},
            {"group:stick"},
        },
    })

end

function unilib.tools._register_craft_spear(data_table)

    -- Adapted from xtraores/init.lua
    -- Function to create a standard craft recipe for the specified spear
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "bronze"
    --      ingredient (str): e.g. "unilib:metal_bronze_ingot"

    local part_name = data_table.part_name
    local ingredient = data_table.ingredient

    unilib.register_craft({
        output = "unilib:tool_spear_" .. part_name,
        recipe = {
            {"", ingredient, ""},
            {ingredient, "group:stick", ingredient},
            {"", "group:stick", ""},
        },
    })

end
