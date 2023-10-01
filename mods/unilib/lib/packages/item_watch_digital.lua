---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    orienteering
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.item_watch_digital = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.orienteering.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_watch_digital.init()

    return {
        description = "Digital watch",
        notes = "Punch to toggle between 12-hour and 24-hour displays",
        depends = {"glass_ordinary", "metal_copper", "shared_orienteering"},
    }

end

function unilib.pkg.item_watch_digital.exec()

    unilib.register_tool("unilib:item_watch_digital", "orienteering:watch", mode, {
        -- From orienteering:watch
        description = S("Digital Watch"),
        inventory_image = "unilib_item_watch_digital.png",
        groups = {disable_repair = 1},

        wield_image = "unilib_item_watch_digital.png",

        on_use = unilib.pkg.shared_orienteering.toggle_time_mode,
    })
    unilib.register_craft({
        -- From orienteering:watch
        output = "unilib:item_watch_digital",
        recipe = {
            {"unilib:metal_copper_ingot"},
            {"unilib:glass_ordinary"},
            {"unilib:metal_copper_ingot"},
        },
    })

end
