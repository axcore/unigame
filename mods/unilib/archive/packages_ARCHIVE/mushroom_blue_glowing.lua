---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plants
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
name_plant = "glowshroom"
name = mod_name..":"..name_plant.."_wild"
img = mod_name.."_"..name_plant.."_wild.png"
minetest.register_node(name, {
  tiles = {img},
  inventory_image = img,
  description = name_plant,
  drop = {max_items = 1,items = {{ items = {name}}}},
  drawtype = "plantlike",
  paramtype = 'light',
  sunlight_propagates = true,
  buildable_to = true,
  walkable = false,
  visual_scale = 1.3,
  light_source = 11,
  groups = { snappy = 3,flammable=2, attached_node=1},
  sounds = default.node_sound_leaves_defaults(),
  selection_box = {
    type = "fixed",
    fixed = { -0.25, -0.5, -0.25, 0.25, -3/16, 0.25 },
  },
})

habitat:generate("plants:glowshroom_wild", "default:stone", nil, nil, -5, 20, 7, 40, {"default:stone_with_coal"},0,{""})
]]--
