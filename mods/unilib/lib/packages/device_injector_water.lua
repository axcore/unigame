---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    thirsty
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.device_injector_water = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.thirsty.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.device_injector_water.init()

    return {
        description = "Automatic water injector",
        notes = "Automatically removes water from a container (such as a canteen) in your" ..
                " inventory, and uses it to maintain your current hydration. Best used alonside" ..
                " a water extractor device",
        depends = {"mineral_diamond", "mineral_mese"},
    }

end

function unilib.pkg.device_injector_water.exec()

    -- N.B. Most of the code providing functionality for this craftitem is in
    --      ../effects/hydration.lua

    unilib.register_craftitem("unilib:device_injector_water", "thirsty:injector", mode, {
        -- From thirsty:injector
        description = S("Automatic Water Injector"),
        inventory_image = "unilib_device_injector_water.png",
    })

end

function unilib.pkg.device_injector_water.post()

    local c_diamond = "unilib:mineral_diamond_gem"
    local c_mese = "unilib:mineral_mese_crystal"

    minetest.register_craft({
        -- From thirsty:injector
        output = "unilib:device_injector_water",
        recipe = {
            {c_diamond, c_mese, c_diamond},
            {c_mese, "group:craftable_bucket", c_mese},
            {c_diamond, c_mese, c_diamond},
        },
        -- N.B. no replacement table with unilib.craftable_bucket_list required
    })

end
