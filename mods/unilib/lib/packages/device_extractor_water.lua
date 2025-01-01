---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    thirsty
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.device_extractor_water = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.thirsty.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.device_extractor_water.init()

    return {
        description = "Automatic water extractor",
        notes = "Automatically fills a container (such as a canteen) in your inventory. Best" ..
                " used alongside a water injector device",
        depends = {"mineral_diamond", "mineral_mese"},
    }

end

function unilib.pkg.device_extractor_water.exec()

    -- N.B. Most of the code providing functionality for this craftitem is in
    --      ../lib/effects/hydration/hydration_base.lua

    unilib.register_craftitem("unilib:device_extractor_water", "thirsty:extractor", mode, {
        -- From thirsty:extractor
        description = S("Automatic Water Extractor"),
        inventory_image = "unilib_device_extractor_water.png",
    })

end

function unilib.pkg.device_extractor_water.post()

    local c_diamond = "unilib:mineral_diamond_gem"
    local c_mese = "unilib:mineral_mese_crystal"

    unilib.register_craft({
        -- From thirsty:extractor
        output = "unilib:device_extractor_water",
        recipe = {
            {c_mese, c_diamond, c_mese},
            {c_diamond, "group:craftable_bucket", c_diamond},
            {c_mese, c_diamond, c_mese}
        },
        -- N.B. no replacement table with unilib.global.craftable_bucket_list required
    })

end
