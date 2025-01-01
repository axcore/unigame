---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- cuisine.lua
--      Set up advanced cuisine (original to unilib)
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Notes
---------------------------------------------------------------------------------------------------

-- Original to unilib
-- Advanced cuisine (if enabled) prevents the player from eating the same food over and over again,
--      forcing them to consume a varied diet
-- When a food item is eaten, its food groups (e.g. "food_bread" for "unilib:food_bread_ordinary")
--      are added to a history list, of a maximum size determined by Minetest settings (default 10)
-- Whenever another food item is eaten, its nutritional value is reduced for every instance of the
--      same food group that occurs in the history list
--
-- Packages defining food items should call the function below, like this:
--
--      on_use = unilib.cuisine.eat_on_use("unilib:food_SOMETHING", 5),
--      on_use = unilib.cuisine.eat_on_use("unilib:food_SOMETHING", 5, "unilib:utensil_SOMETHING"),
--
-- ...which replaces lines like these:
--
--      on_use = core.item_eat(5),
--      on_use = core.item_eat(5, "unilib:utensil_SOMETHING"),
--
-- Packages defining drink items can be used as drinks (if hydration is enabled) or as just another
--      type of food (if not). Those packages should call the function below, like this:
--
--      on_use = unilib.cuisine.drink_on_use("unilib:food_SOMETHING", 2)
--      on_use = unilib.cuisine.drink_on_use("unilib:food_SOMETHING", 2, "unilib:vessel_SOMETHING")
--
-- ...which replaces lines like these:
--
--      on_use = core.item_eat(2),
--      on_use = core.item_eat(2, "unilib:vessel_SOMETHING"),
--
-- Occasionally it's necessary to use a different callback. In that case, use code like this:
--
--      local function do_eat(pos, node, puncher)
--          local return_func = unilib.cuisine.eat_on_use("unilib:food_SOMETHING", 4)
--          return_func(ItemStack("unilib:food_SOMETHING"), puncher, node)
--      end
--
--      on_punch = function(pos, node, puncher, pointed_thing)
--          do_eat(pos, node, puncher)
--      end,
--
-- Negative values are used for poisonous foods. There is no need for poisonous foods to call these
--      functions; they can call core.item_eat() as normal. If they do call these functions,
--      core.item_eat() is used anyway, so the poisonous foods are not added to the player's cuisine
--      history
-- If a satiation value of 0 is used, the player's hunger does not change, and the food is not
--      added to the player's cuisine history (for simplicity)
-- For drinks, the satiation value is ignored if hydration is enabled; all drinks improve the
--      player's thirst by the same amount
-- Note that drinks with a low water content like "unilib:food_milk_coconut" should use a call to
--      unilib.cuisine.eat_on_use(), not unilib.cuisine.drink_on_use()

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.cuisine = {}

---------------------------------------------------------------------------------------------------
-- Load files, as and when required
---------------------------------------------------------------------------------------------------

-- Set up advanced cuisine
if not unilib.setting.debug_disable_effects_flag and
        (unilib.setting.debug_enable_effects_flag or unilib.setting.cuisine_advanced_flag) then
    dofile(unilib.core.path_mod .. "/lib/effects/cuisine/cuisine_eat_base.lua")
else
    dofile(unilib.core.path_mod .. "/lib/effects/cuisine/cuisine_eat_bu.lua")
end

if not unilib.setting.debug_disable_effects_flag and
        (unilib.setting.debug_enable_effects_flag or unilib.setting.thirst_enable_flag) then
    dofile(unilib.core.path_mod .. "/lib/effects/cuisine/cuisine_drink_base.lua")
else
    dofile(unilib.core.path_mod .. "/lib/effects/cuisine/cuisine_drink_bu.lua")
end
