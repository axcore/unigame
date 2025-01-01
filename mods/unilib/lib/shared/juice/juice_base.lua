---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- juice_base.lua
--      Base API functions for juice
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Base API functions for juice
---------------------------------------------------------------------------------------------------

function unilib.juice._register_juice(data_table)

    -- Original to unilib
    -- Registers a juice type
    -- Juices are squeezed from fruits in the press defined by the "machine_press_juice" package,
    --      but are set up by code in the "shared_drinks" package
    --
    -- data_table compulsory fields:
    --      ingredient (str): e.g. "unilib:fruit_apple"
    --      juice_description (str): e.g. "Apple"
    --      juice_type (str): e.g. "apple". All types of apple should create a single type of juice,
    --          so this and the description should mention only "apple" and not "mature apple" or
    --          anything like that
    --      rgb (str): e.g. "#ecff56"
    --
    -- data_table optional fields:
    --      health (int): e.g. 2 (the number of health points, when the user drinks the juice). Can
    --          be a negative number e.g. -2 for poisonous ingredients. Note the original "drinks"
    --          mod used a default value of 1
    --      orig_flag (bool): true if the original "drinks" mod specifies vessels using (exactly)
    --          the same "juice_type", false (or nil) if this "juice_type" is original to unilib

    local ingredient = data_table.ingredient
    local juice_description = data_table.juice_description
    local juice_type = data_table.juice_type
    local rgb = data_table.rgb

    local health = data_table.health or 2
    local orig_flag = data_table.orig_flag or false

    -- Depending on Minetest settings, the range of juices may be restricted
    if (
        unilib.setting.drinks_restrict_original_flag and
        not orig_flag
    ) or (
        unilib.setting.drinks_restrict_fruit_flag and
        unilib.utils.get_first_component(ingredient) ~= "fruit"
    ) then
        return
    end

    if unilib.global.generic_juice_table[juice_type] == nil then

        unilib.global.generic_juice_table[juice_type] = {
            ingredient_list = {ingredient},
            juice_description = juice_description,
            health = health,
            orig_flag = orig_flag,
            rgb = rgb,
        }

    else

        -- Don't overwrite the existing juice type's data; just update its ingredient list
        table.insert(unilib.global.generic_juice_table[juice_type]["ingredient_list"], ingredient)

    end

end

function unilib.juice._register_duplicate(juice_type, ingredient)

    -- Original to unilib
    -- Registers an ingredient for a juice type that was defined in an earlier call to
    --      unilib.register_juice()

    if unilib.global.generic_juice_table[juice_type] ~= nil then
        table.insert(unilib.global.generic_juice_table[juice_type]["ingredient_list"], ingredient)
    end

end
