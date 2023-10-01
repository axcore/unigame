---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    thirsty
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[

if minetest.get_modpath("default") and minetest.get_modpath("bucket") and thirsty.config.register_amulets then

    minetest.register_craftitem('thirsty:extractor', {
        description = 'Water extractor',
        inventory_image = 'thirsty_extractor.png',
    })
    minetest.register_craft({
        output = "thirsty:extractor",
        recipe = {
            { "default:mese_crystal", "default:diamond", "default:mese_crystal"},
            { "default:diamond", "bucket:bucket_water", "default:diamond"},
            { "default:mese_crystal", "default:diamond", "default:mese_crystal"}
        }
    })

end
]]--
