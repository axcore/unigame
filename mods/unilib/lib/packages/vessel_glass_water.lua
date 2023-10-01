---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.vessel_glass_water = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.vessel_glass_water.init()

    return {
        description = "Glass of water",
        depends = "vessel_glass_empty",
        optional = "item_fibre_hemp",
    }

end

function unilib.pkg.vessel_glass_water.exec()

    unilib.register_craftitem("unilib:vessel_glass_water", "farming:glass_water", mode, {
        -- From farming:glass_water
        description = S("Glass of Water"),
        inventory_image = "unilib_vessel_glass_water.png",
        groups = {flammable = 3, food_water_glass = 1, vessel = 1},
    })

end

function unilib.pkg.vessel_glass_water.post()

    local c_vessel = "unilib:vessel_glass_empty"

    unilib.register_craft({
        -- From farming:glass_water
        output = "unilib:vessel_glass_water 4",
        recipe = {
            {c_vessel, c_vessel},
            {c_vessel, c_vessel},
            {"group:potable_bucket", ""}
        },
        replacements = unilib.potable_bucket_list,
    })

    if unilib.pkg_executed_table["item_fibre_hemp"] ~= nil then

        -- N.B. Let the player waste their hemp filtering potable water, if they really want to
        unilib.register_craft({
            -- From farming:glass_water
            output = "unilib:vessel_glass_water 4",
            recipe = {
                {c_vessel, c_vessel},
                {c_vessel, c_vessel},
                {"group:water_bucket", "unilib:item_fibre_hemp"},
            },
            replacements = unilib.water_bucket_list,
        })

    end

end
