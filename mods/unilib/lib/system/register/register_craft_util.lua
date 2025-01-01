---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- register_craft_util.lua
--      Craft recipe utility functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Craft recipe utility functions
---------------------------------------------------------------------------------------------------

function unilib.register._register_craft_metadata_copy(ingredient, output)

    -- Adapted from default/functions.lua
    -- In the original mod, used to copy metadata from ordinary books to books with writing
    -- Used for that purpose in unilib (but available to other code, as required)
    --
    -- Args:
    --      ingredient (str): e.g. "unilib:item_book_ordinary"
    --      output (str): e.g. "unilib:item_book_ordinary_written"

    unilib.register_craft({
        type = "shapeless",
        output = output,
        recipe = {ingredient, output}
    })

    core.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)

        if itemstack:get_name() ~= output then
            return
        end

        local original
        local index
        for i = 1, #old_craft_grid do

            if old_craft_grid[i]:get_name() == output then

                original = old_craft_grid[i]
                index = i

            end

        end

        if not original then
            return
        end

        local copymeta = original:get_meta():to_table()
        itemstack:get_meta():from_table(copymeta)
        -- Put the book with metadata back in the craft grid
        craft_inv:set_stack("craft", index, original)

    end)

end

function unilib.register._register_external_ingredient(full_name, ingredient)

    -- Original to unilib
    -- Some packages have craft recipes that require items from other mods, but we can't say in
    --      advance which mods will supply those items. These typically include meat, milk and eggs
    --      used as ingredients for food items
    -- Ideally, such craft recipes should use "group:food_egg", rather than an actual item name like
    --      "mobs:egg", so that all mods providing eggs can be used as ingredients
    -- Affected packages should call this function, which updates a global variable. The player can
    --      then use the chat command /check_ingredients, once the game has started, to check that
    --      the external ingredients are actually available
    -- (We don't check external ingredients directly, so that the user isn't forced to add all
    --      possible external mods to unilib's mod.conf)
    --
    -- Args:
    --      full_name (str): e.g. "unilib:food_cake_jaffa"
    --      ingredient (str or list): e.g. {"group:food_egg", "group:food_milk"}

    local ingredient_list = unilib.utils.convert_to_list(ingredient)
    unilib.global.external_ingredient_table[full_name] = ingredient_list

end

function unilib.register._register_craft_conflicts(pair_list)

    -- Original to unilib
    -- Updates unilib.global.craft_recipe_conflict_list
    -- "pair_list" consists of one or more mini-lists in the form
    --  { ... {"unilib:item_stick_ordinary 4", "unilib:material_charcoal_artificial_lump 8"} ... }

    for _, mini_list in ipairs(pair_list) do
        table.insert(unilib.global.craft_recipe_conflict_list, mini_list)
    end

end

function unilib.register._register_craft_missing_ingredients(pair_list)

    -- Original to unilib
    -- Updates unilib.global.craft_recipe_missing_ingredient_list
    -- "pair_list" consists of one or more mini-lists in the form
    -- { ... {"unilib:item_stick_ordinary 4", "unilib:material_charcoal_artificial_lump 8"} ... }

    for _, mini_list in ipairs(pair_list) do
        table.insert(unilib.global.craft_recipe_missing_ingredient_list, mini_list)
    end

end
