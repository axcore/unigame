---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    more_coral
-- Code:    MIT
-- Media:   CC BY-SA
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_decoration({
   name = "default:corals",
   deco_type = "simple",
   place_on = {"default:sand"},
   place_offset_y = -1,
   sidelen = 4,
   noise_params = {
      offset = -4,
      scale = 4,
      spread = {x = 50, y = 50, z = 50},
      seed = 13854352,
      octaves = 3,
      persist = 0.7,
   },
   biomes = {
      "desert_ocean",
      "savanna_ocean",
      "rainforest_ocean",
   },
   y_max = -2,
   y_min = -12,
   flags = "force_placement",
   decoration = {
      "more_coral:coral_grey", "more_coral:coral_violet",
      "more_coral:coral_blue", "more_coral:coral_cyan",
      "more_coral:coral_green", "more_coral:coral_yellow",
      "more_coral:coral_pink", "more_coral:coral_red",
   },
})
]]--
