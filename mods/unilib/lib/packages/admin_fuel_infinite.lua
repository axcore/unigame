---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    maptools
-- Code:    zlib
-- Media:   zlib
---------------------------------------------------------------------------------------------------

unilib.pkg.admin_fuel_infinite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.maptools.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.admin_fuel_infinite.init()

    return {
        description = "(Almost) everlasting fuel",
        depends = "shared_maptools",
    }

end

function unilib.pkg.admin_fuel_infinite.exec()

    -- A fuel which burns (for example in furnaces) for real-time decades
    unilib.register_craftitem("unilib:admin_fuel_infinite", "maptools:infinitefuel", mode, {
        -- From maptools:infinitefuel
        description = S("Infinite Fuel"),
        inventory_image = "unilib_admin_fuel_infinite.png",
        groups = {not_in_creative_inventory = unilib.show_admin_item_group},

        stack_max = 65535,
    })
    unilib.register_craft({
        -- From maptools:infinitefuel
        type = "fuel",
        recipe = "unilib:admin_fuel_infinite",
        burntime = 1000000000,
    })

end
