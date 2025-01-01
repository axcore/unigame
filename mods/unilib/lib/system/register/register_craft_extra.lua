---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- register_craft_extra.lua
--      Extra craft recipe functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Extra craft recipe functions
---------------------------------------------------------------------------------------------------

function unilib.register._register_craft_2x2(data_table)

    -- Original to unilib
    -- A convenience function for crafting recipes that use a 2x2 grid with an output of 1 item
    --
    -- data_table compulsory fields:
    --      data_table.output (str): e.g. "unilib:stone_ordinary_brick"
    --      data_table.ingredient (str): e.g. "unilib:stone_ordinary"

    local output = data_table.output
    local ingredient = data_table.ingredient

    core.register_craft({
        output = output,
        recipe = {
            {ingredient, ingredient},
            {ingredient, ingredient},
        },
    })

end

function unilib.register._register_craft_2x2x4(data_table)

    -- Original to unilib
    -- A convenience function for crafting recipes that use a 2x2 grid with an output of 4 items
    --
    -- data_table compulsory fields:
    --      data_table.output (str): e.g. "unilib:stone_ordinary_brick"
    --      data_table.ingredient (str): e.g. "unilib:stone_ordinary"

    local output = data_table.output
    local ingredient = data_table.ingredient

    -- (Inevitably we'll sometimes forget to remove the multiple from the arguments)
    if string.find(output, " 4$") then

        unilib.utils.show_error(
            "unilib.register_craft_2x2x4(): Duplicate multiple in craft recipe",
            output,
            ingredient
        )

    else

        core.register_craft({
            output = output .. " 4",
            recipe = {
                {ingredient, ingredient},
                {ingredient, ingredient},
            },
        })

    end

end

function unilib.register._register_craft_3x3(data_table)

    -- Original to unilib
    -- A convenience function for crafting recipes that use a 3x3 grid with an output of 1 item
    --
    -- data_table compulsory fields:
    --      data_table.output (str): e.g. "unilib:stone_ordinary_brick"
    --      data_table.ingredient (str): e.g. "unilib:stone_ordinary"

    local output = data_table.output
    local ingredient = data_table.ingredient

    core.register_craft({
        output = output,
        recipe = {
            {ingredient, ingredient, ingredient},
            {ingredient, ingredient, ingredient},
            {ingredient, ingredient, ingredient},
        },
    })

end

function unilib.register._register_craft_3x3x9(data_table)

    -- Original to unilib
    -- A convenience function for crafting recipes that use a 3x3 grid with an output of 9 items
    --
    -- data_table compulsory fields:
    --      data_table.output - e.g. "unilib:stone_ordinary_brick"
    --      data_table.ingredient - e.g. "unilib:stone_ordinary"

    local output = data_table.output
    local ingredient = data_table.ingredient

    -- (Inevitably we'll sometimes forget to remove the multiple from the arguments)
    if string.find(output, " 9$") then

        unilib.utils.show_error(
            "unilib.register_craft_3x3x9(): Duplicate multiple in craft recipe",
            output,
            ingredient
        )

    else

        core.register_craft({
            output = output .. " 9",
            recipe = {
                {ingredient, ingredient, ingredient},
                {ingredient, ingredient, ingredient},
                {ingredient, ingredient, ingredient},
            },
        })

    end

end
