---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nettle
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_nettle_carduus = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.nettle.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_nettle_carduus.init()

    return {
        description = "Carduus nettle",
        notes = "Cause 1 damage per second",
    }

end

function unilib.pkg.plant_nettle_carduus.exec()

    unilib.register_node("unilib:plant_nettle_carduus", "nettle:carduus", mode, {
        -- From nettle:carduus
        description = unilib.annotate(S("Carduus"), "Carduus"),
        tiles = {"unilib_plant_nettle_carduus.png"},
        -- N.B. removed flora = 1 to prevent additional spreading
        groups = {
            attached_node = 1, flammable = 1, nettle_weed = 1, oddly_breakable_by_hand = 2,
            snappy = 2,
        },
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        damage_per_second = 1 * unilib.nettle_damage_factor,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_nettle_carduus.png",
        paramtype = "light",
        sunlight_propagates = true,
        visual_scale = 1.2,
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_nettle_carduus.png",
    })
    unilib.register_craft({
        -- From nettle:carduus
        type = "fuel",
        recipe = "unilib:plant_nettle_carduus",
        burntime = 3,
    })
    unilib.register_plant_in_pot("unilib:plant_nettle_carduus", "nettle:carduus")

end

function unilib.pkg.plant_nettle_carduus.post()

    -- The shared package provides a spreading ABM; if it's not available, use the normal
    --      flora-spreading ABM
    if unilib.pkg_executed_table["abm_nettle_plant_nettle_spread"] == nil then

        unilib.override_item("unilib:plant_nettle_carduus", {
            groups = {
                attached_node = 1, flammable = 1, flora = 1, nettle_weed = 1,
                oddly_breakable_by_hand = 2, snappy = 2,
            },
        })

    end

end
