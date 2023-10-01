---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    drinks
-- Code:    MIT
-- Media:   CC by SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
function drinks.drinks_liquid_sub(liq_vol, ves_typ, ves_vol, pos, able_to_fill, leftover_count, outputstack)
   local meta = minetest.get_meta(pos)
   local fullness = tonumber(meta:get_string('fullness'))
   local fruit = meta:get_string('fruit')
   local fruit_name = meta:get_string('fruit_name')
   local inv = meta:get_inventory()
   local fullness = fullness - (liq_vol*able_to_fill)
   meta:set_string('fullness', fullness)
   meta:set_string('infotext', (math.floor((fullness/ves_vol)*100))..' % full of '..fruit_name..' juice.')
   if ves_vol == 128 then
      meta:set_string('formspec', drinks.liquid_storage_formspec(fruit_name, fullness, 128))
   elseif ves_vol == 256 then
      meta:set_string('formspec', drinks.liquid_storage_formspec(fruit_name, fullness, 256))
   end
   if ves_typ == 'jcu' or ves_typ == 'jbo' or ves_typ == 'jsb' or ves_typ == 'jbu' then
      inv:set_stack('dst', 1, 'drinks:'..ves_typ..'_'..fruit..' '..able_to_fill)
      inv:set_stack('src', 1, outputstack..' '..leftover_count)
   elseif ves_typ == 'thirsty:bronze_canteen' then
      inv:set_stack('dst', 1, {name="thirsty:bronze_canteen", count=1, wear=60, metadata=""})
   elseif ves_typ == 'thirsty:steel_canteen' then
      inv:set_stack('dst', 1, {name="thirsty:steel_canteen", count=1, wear=40, metadata=""})
   end
end

function drinks.drinks_liquid_add(liq_vol, ves_typ, ves_vol, pos, inputcount, leftover_count, inputstack)
   local meta = minetest.get_meta(pos)
   local fullness = tonumber(meta:get_string('fullness'))
   local fruit = meta:get_string('fruit')
   local fruit_name = meta:get_string('fruit_name')
   local inv = meta:get_inventory()
   local fullness = fullness + (liq_vol*inputcount)
   meta:set_string('fullness', fullness)
   inv:set_stack('src', 1, ves_typ..' '..inputcount)
   inv:set_stack('dst', 1, inputstack..' '..leftover_count)
   meta:set_string('infotext', (math.floor((fullness/ves_vol)*100))..' % full of '..fruit_name..' juice.')
   if ves_vol == 256 then
      meta:set_string('formspec', drinks.liquid_storage_formspec(fruit_name, fullness, 256))
   elseif ves_vol == 128 then
      meta:set_string('formspec', drinks.liquid_storage_formspec(fruit_name, fullness, 128))
   end
end

-- replace craftitem to node definition
-- use existing node as template (e.g. 'vessel:glass_bottle')
drinks.register_item = function( name, template, def )
   local template_def = minetest.registered_nodes[template]
   if template_def then
   local drinks_def = table.copy(template_def)

   -- replace/add values
   for k,v in pairs(def) do
      if k == "groups" then
         -- special handling for groups: merge instead replace
         for g,n in pairs(v) do
            drinks_def[k][g] = n
         end
      else
         drinks_def[k]=v
      end
   end

   if def.inventory_image then
      drinks_def.wield_image = drinks_def.inventory_image
      drinks_def.tiles = { drinks_def.inventory_image }
   end

   minetest.register_node( name, drinks_def )
   end
end

function drinks.drinks_liquid_avail_sub(liq_vol, ves_typ, ves_vol, outputstack, pos, count)
   local meta = minetest.get_meta(pos)
   local fullness = tonumber(meta:get_string('fullness'))
   if fullness - (liq_vol*count) < 0 then
      local able_to_fill = math.floor(fullness/liq_vol)
      local leftover_count = count - able_to_fill
      drinks.drinks_liquid_sub(liq_vol, ves_typ, ves_vol, pos, able_to_fill, leftover_count, outputstack)
   elseif fullness - (liq_vol*count) >= 0 then
      drinks.drinks_liquid_sub(liq_vol, ves_typ, ves_vol, pos, count, 0, outputstack)
   end
end

function drinks.drinks_liquid_avail_add(liq_vol, ves_typ, ves_vol, pos, inputstack, inputcount)
   local meta = minetest.get_meta(pos)
   local fullness = tonumber(meta:get_string('fullness'))
   if fullness + (liq_vol*inputcount) > ves_vol then
      local avail_ves_vol = ves_vol - fullness
      local can_empty = math.floor(avail_ves_vol/liq_vol)
      local leftover_count = inputcount - can_empty
      drinks.drinks_liquid_add(liq_vol, ves_typ, ves_vol, pos, can_empty, leftover_count, inputstack)
   elseif fullness + (liq_vol*inputcount) <= ves_vol then
      drinks.drinks_liquid_add(liq_vol, ves_typ, ves_vol, pos, inputcount, 0, inputstack)
   end
end

if minetest.get_modpath('default') then
   drinks.juiceable['apple'] = true -- Name of fruit to make juiceable.
   drinks.juiceable['cactus'] = true
   drinks.juiceable['blueberries'] = true
   table.insert(drinks.drink_table, {'apple', 'Apple', '#ecff56'})
   table.insert(drinks.drink_table, {'cactus', 'Cactus', '#96F97B'})
   table.insert(drinks.drink_table, {'blueberries', 'Blueberry', '#521dcb'})
end

if minetest.get_modpath('bushes_classic') then
   drinks.juiceable['blackberry'] = true
   drinks.juiceable['blueberry'] = true
   drinks.juiceable['gooseberry'] = true
   drinks.juiceable['raspberry'] = true
   drinks.juiceable['strawberry'] = true
   table.insert(drinks.drink_table, {'blackberry', 'Blackberry', '#581845'})
   table.insert(drinks.drink_table, {'blueberry', 'Blueberry', '#521dcb'})
   table.insert(drinks.drink_table, {'gooseberry', 'Gooseberry', '#9cf57c'})
   table.insert(drinks.drink_table, {'raspberry', 'Raspberry', '#C70039'})
   table.insert(drinks.drink_table, {'strawberry', 'Strawberry', '#ff3636'})
end

if minetest.get_modpath('farming_plus') then
   drinks.juiceable['banana'] = true
   drinks.juiceable['melon'] = true
   drinks.juiceable['lemon_item'] = true
   drinks.juiceable['orange_item'] = true
   drinks.juiceable['peach_item'] = true
   drinks.juiceable['rhubarb_item'] = true
   drinks.juiceable['tomato_item'] = true
   drinks.juiceable['strawberry_item'] = true
   drinks.juiceable['raspberry_item'] = true
   table.insert(drinks.drink_table, {'banana', 'Banana', '#eced9f'})
   table.insert(drinks.drink_table, {'lemon', 'Lemon', '#feffaa'})
   table.insert(drinks.drink_table, {'melon', 'Melon', '#ef4646'})
   table.insert(drinks.drink_table, {'orange', 'Orange', '#ffc417'})
   table.insert(drinks.drink_table, {'peach', 'Peach', '#f2bc1e'})
   table.insert(drinks.drink_table, {'rhubarb', 'Rhubarb', '#fb8461'})
   table.insert(drinks.drink_table, {'tomato', 'Tomato', '#d03a0e'})
   table.insert(drinks.drink_table, {'strawberry', 'Strawberry', '#ff3636'})
   table.insert(drinks.drink_table, {'raspberry', 'Raspberry', '#C70039'})
end

if minetest.get_modpath('crops') then
   drinks.juiceable['melon'] = true
   drinks.juiceable['melon_slice'] = true
   drinks.juiceable['tomato'] = true
   drinks.juiceable['pumpkin'] = true
   table.insert(drinks.drink_table, {'melon', 'Melon', '#ef4646'})
   table.insert(drinks.drink_table, {'tomato', 'Tomato', '#d03a0e'})
   table.insert(drinks.drink_table, {'pumpkin', 'Pumpkin', '#ffc04c'})
end

if minetest.get_modpath('farming') then
   drinks.juiceable['melon_8'] = true
   drinks.juiceable['melon_slice'] = true
   drinks.juiceable['tomato'] = true
   drinks.juiceable['carrot'] = true
   drinks.juiceable['cucumber'] = true
   drinks.juiceable['grapes'] = true
   drinks.juiceable['pumpkin_8'] = true
   drinks.juiceable['pumpkin_slice'] = true
   drinks.juiceable['raspberries'] = true
   drinks.juiceable['rhubarb'] = true
   drinks.juiceable['blueberries'] = true
   drinks.juiceable['pineapple'] = true
   drinks.juiceable['pineapple_ring'] = true
   table.insert(drinks.drink_table, {'melon', 'Melon', '#ef4646'})
   table.insert(drinks.drink_table, {'tomato', 'Tomato', '#990000'})
   table.insert(drinks.drink_table, {'carrot', 'Carrot', '#ed9121'})
   table.insert(drinks.drink_table, {'cucumber', 'Cucumber', '#73af59'})
   table.insert(drinks.drink_table, {'grapes', 'Grape', '#b20056'})
   table.insert(drinks.drink_table, {'pumpkin', 'Pumpkin', '#ffc04c'})
   table.insert(drinks.drink_table, {'raspberries', 'Raspberry', '#C70039'})
   table.insert(drinks.drink_table, {'rhubarb', 'Rhubarb', '#fb8461'})
   table.insert(drinks.drink_table, {'blueberries', 'Blueberry', '#521dcb'})
   table.insert(drinks.drink_table, {'pineapple', 'Pineapple', '#dcd611'})
   minetest.register_alias_force('farming:carrot_juice', 'drinks:jcu_carrot')
   minetest.register_alias_force('farming:pineapple_juice', 'drinks:jcu_pineapple')
end

if minetest.get_modpath('fruit') then
   drinks.juiceable['pear'] = true
   drinks.juiceable['plum'] = true
   drinks.juiceable['peach'] = true
   drinks.juiceable['orange'] = true
   table.insert(drinks.drink_table, {'pear', 'Pear', '#ecff56'})
   table.insert(drinks.drink_table, {'plum', 'Plum', '#8e4585'})
   table.insert(drinks.drink_table, {'peach', 'Peach', '#f2bc1e'})
   table.insert(drinks.drink_table, {'orange', 'Orange', '#ffc417'})
end

if minetest.get_modpath('ethereal') then
   drinks.juiceable['banana'] = true
   drinks.juiceable['coconut'] = true
   drinks.juiceable['coconut_slice'] = true
   drinks.juiceable['orange'] = true
   drinks.juiceable['strawberry'] = true
   table.insert(drinks.drink_table, {'banana', 'Banana', '#eced9f'})
   table.insert(drinks.drink_table, {'coconut', 'Coconut', '#ffffff'})
   table.insert(drinks.drink_table, {'orange', 'Orange', '#ffc417'})
   table.insert(drinks.drink_table, {'strawberry', 'Strawberry', '#ff3636'})
end

--Parse Table
for i in ipairs (drinks.drink_table) do
   local desc = drinks.drink_table[i][1]
   local craft = drinks.drink_table[i][2]
   local color = drinks.drink_table[i][3]
   local health = drinks.drink_table[i][4]
   health = health or 1
   -- The color of the drink is all done in code, so we don't need to have multiple images.

--Actual Node registration
minetest.register_node('drinks:jbu_'..desc..'', {
	description = 'Bucket of '..craft..' Juice',
	drawtype = "plantlike",
	tiles = {'bucket.png^(drinks_bucket_contents.png^[colorize:'..color..':200)'},
	inventory_image = 'bucket.png^(drinks_bucket_contents.png^[colorize:'..color..':200)',
	wield_image = 'bucket.png^(drinks_bucket_contents.png^[colorize:'..color..':200)',
	paramtype = "light",
   juice_type = craft,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, drink = 1},
	sounds = default.node_sound_defaults(),
})

drinks.register_item('drinks:jcu_'..desc,  'vessels:drinking_glass', {
   description = 'Cup of '..craft..' Juice',
   groups = {drink=1},
   juice_type = craft,
   inventory_image = 'drinks_glass_contents.png^[colorize:'..color..':200^drinks_drinking_glass.png',
   on_use = function(itemstack, user, pointed_thing)
      thirsty.drink(user, 4, 20)
      local eat_func = minetest.item_eat(health, 'vessels:drinking_glass')
      return eat_func(itemstack, user, pointed_thing)
   end,
})

drinks.register_item('drinks:jbo_'..desc, 'vessels:glass_bottle',{
   description = 'Bottle of '..craft..' Juice',
   groups = {drink = 1},
   juice_type = craft,
   inventory_image = 'drinks_bottle_contents.png^[colorize:'..color..':200^drinks_glass_bottle.png',
   on_use = function(itemstack, user, pointed_thing)
      thirsty.drink(user, 8, 20)
      local eat_func = minetest.item_eat((health*2), 'vessels:glass_bottle')
      return eat_func(itemstack, user, pointed_thing)
   end,
})

drinks.register_item('drinks:jsb_'..desc, 'vessels:steel_bottle',{
   description = 'Heavy Steel Bottle ('..craft..' Juice)',
   groups = {drink = 1},
   juice_type = craft,
   inventory_image = 'vessels_steel_bottle.png',
   on_use = function(itemstack, user, pointed_thing)
      thirsty.drink(user, 8, 20)
      local eat_func = minetest.item_eat((health*2), 'vessels:steel_bottle')
      return eat_func(itemstack, user, pointed_thing)
   end,
})

end
]]--
