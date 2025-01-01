---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    map
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_kit_mapping = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.map.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_kit_mapping.init()

    return {
        description = "Mapping kit",
        notes = "Enables the minimap. Use with the Minetest minimap key",
        depends = {
            "dye_basic",
            "glass_ordinary",
            "item_paper_ordinary",
            "metal_steel",
            "shared_map",
        },
    }

end

function unilib.pkg.item_kit_mapping.exec()

    unilib.register_craftitem("unilib:item_kit_mapping", "map:mapping_kit", mode, {
        -- From map:mapping_kit
        description = unilib.utils.hint(S("Mapping Kit"), S("use with 'Minimap' key")),
        inventory_image = "unilib_item_kit_mapping.png",
        groups = {flammable = 3, tool = 1},

        stack_max = 1,

        on_use = function(itemstack, user, pointed_thing)
            unilib.pkg.shared_map.update_hud_flags(user)
        end,
    })
    unilib.register_craft({
        -- From map:mapping_kit
        output = "unilib:item_kit_mapping",
        recipe = {
            {"unilib:glass_ordinary", "unilib:item_paper_ordinary", "group:stick"},
            {"unilib:metal_steel_ingot", "unilib:item_paper_ordinary", "unilib:metal_steel_ingot"},
            {"group:wood", "unilib:item_paper_ordinary", "unilib:dye_black"},
        },
    })
    unilib.register_craft({
        -- From map:mapping_kit
        type = "fuel",
        recipe = "unilib:item_kit_mapping",
        burntime = 5,
    })

end
