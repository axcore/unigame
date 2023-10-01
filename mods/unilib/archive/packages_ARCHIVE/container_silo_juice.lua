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
function drinks.drinks_silo(pos, inputstack, inputcount)
   local meta = minetest.get_meta(pos)
   local vessel = string.sub(inputstack, 8, 10)
   drinks.drinks_liquid_avail_add(drinks.shortname[vessel].size, drinks.shortname[vessel].name, 256, pos, inputstack, inputcount)
end

minetest.register_node('drinks:liquid_silo', {
   description = 'Silo of Liquid',
   _doc_items_longdesc = "A node that provides a simple way to store juice.",
   _doc_items_usagehelp = "Add or remove liquids from the silo using buckets, bottles, or cups.",
   drawtype = 'mesh',
   mesh = 'drinks_silo.obj',
   tiles = {name='drinks_silo.png'},
   groups = {choppy=2, dig_immediate=2,},
   paramtype = 'light',
   paramtype2 = 'facedir',
   selection_box = {
      type = 'fixed',
      fixed = {-.5, -.5, -.5, .5, 1.5, .5},
      },
   collision_box = {
      type = 'fixed',
      fixed = {-.5, -.5, -.5, .5, 1.5, .5},
      },
   on_construct = function(pos)
      local meta = minetest.get_meta(pos)
      local inv = meta:get_inventory()
      inv:set_size('main', 8*4)
      inv:set_size('src', 1)
      inv:set_size('dst', 1)
      meta:set_string('fullness', 0)
      meta:set_string('fruit', 'empty')
      meta:set_string('infotext', 'Empty Drink Silo')
      meta:set_string('formspec', 'size[8,8]'..
      'label[0,0;Fill with the drink of your choice,]'..
      'label[0,.4;you can only add more of the same type of drink.]'..
      'label[4.5,1.2;Add liquid ->]'..
      'label[.75,1.75;The Silo is empty]'..
      'label[4.5,2.25;Take liquid ->]'..
      'label[2,3.2;(This empties the silo completely)]'..
      'button[0,3;2,1;purge;Purge]'..
      'list[current_name;src;6.5,1;1,1;]'..
      'list[current_name;dst;6.5,2;1,1;]'..
      'list[current_player;main;0,4;8,5;]')
   end,
   on_metadata_inventory_put = function(pos, listname, index, stack, player)
      local meta = minetest.get_meta(pos)
      local inv = meta:get_inventory()
      local instack = inv:get_stack("src", 1)
      local outstack = inv:get_stack('dst', 1)
      local outputstack = outstack:get_name()
      local inputstack = instack:get_name()
      local outputcount = outstack:get_count()
      local inputcount = instack:get_count()
      local fruit = string.sub(inputstack, 12, -1)
      local fruit_in = meta:get_string('fruit')
      if fruit_in == 'empty' then
         meta:set_string('fruit', fruit)
         local fruit_name = minetest.registered_nodes[instack:get_name()]
         meta:set_string('fruit_name', string.lower(fruit_name.juice_type))
         local vessel = string.sub(inputstack, 8, 10)
         drinks.drinks_silo(pos, inputstack, inputcount)
      end
      if fruit == fruit_in then
         local vessel = string.sub(inputstack, 8, 10)
         drinks.drinks_silo(pos, inputstack, inputcount)
      end
      if drinks.longname[outputstack] then
         drinks.drinks_liquid_avail_sub(drinks.longname[outputstack].size, drinks.longname[outputstack].name, 256, outputstack, pos, outputcount)
      end
   end,
   on_receive_fields = function(pos, formname, fields, sender)
      if fields['purge'] then
         local meta = minetest.get_meta(pos)
         local fullness = 0
         local fruit_name = 'no'
         meta:set_string('fullness', 0)
         meta:set_string('fruit', 'empty')
         meta:set_string('infotext', 'Empty Drink Silo')
         meta:set_string('formspec', drinks.liquid_storage_formspec(fruit_name, fullness, 256))
      end
   end,
   can_dig = function(pos)
      local meta = minetest.get_meta(pos);
      local inv = meta:get_inventory()
      if inv:is_empty("src") and
         inv:is_empty("dst") and
         tonumber(meta:get_string('fullness')) == 0 then
         return true
      else
         return false
      end
   end,
   allow_metadata_inventory_put = function(pos, listname, index, stack, player)
      local meta = minetest.get_meta(pos)
      if listname == 'src' then --adding liquid
         local inputstack = stack:get_name()
         local inputcount = stack:get_count()
         local valid = string.sub(inputstack, 1, 8)
         if valid == 'drinks:j' then
            return inputcount
         else
            return 0
         end
      elseif listname == 'dst' then --removing liquid
         --make sure there is liquid to take_item
         local juice = meta:get_string('fruit')
         if juice ~= 'empty' then
            local inputstack = stack:get_name()
            local inputcount = stack:get_count()
            local valid = string.sub(inputstack, 1, 7)
            if valid == 'vessels' or valid == 'bucket:' then
               return inputcount
            else
               return 0
            end
         else
            return 0
         end
      end
   end,
})
minetest.register_craft({
      output = 'drinks:liquid_silo',
      recipe = {
         {'drinks:liquid_barrel'},
         {'drinks:liquid_barrel'},
         {'drinks:liquid_barrel'}
      }
})
]]--
