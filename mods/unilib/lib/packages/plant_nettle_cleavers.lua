---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nettle
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_nettle_cleavers = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.nettle.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_nettle_cleavers.init()

    return {
        description = "Cleavers nettle",
        notes = "Cause 1 damage per second and slow down the player's movement",
    }

end

function unilib.pkg.plant_nettle_cleavers.exec()

    unilib.register_node("unilib:plant_nettle_cleavers", "nettle:cleavers", mode, {
        -- From nettle:cleavers
        description = unilib.utils.annotate(S("Cleavers"), "Galium aparine"),
        tiles = {"unilib_plant_nettle_cleavers.png"},
        -- N.B. removed flora = 1 to prevent additional spreading
        groups = {
            attached_node = 1, flammable = 1, nettle_weed = 1, oddly_breakable_by_hand = 2,
            snappy = 2,
        },
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "mesh",
        inventory_image = "unilib_plant_nettle_cleavers.png",
        liquid_alternative_flowing = "unilib:plant_nettle_cleavers",
        liquid_alternative_source = "unilib:plant_nettle_cleavers",
        liquid_range = 0,
        liquid_renewable = false,
        liquid_viscosity = 3,
        liquidtype = "source",
        mesh = "unilib_plant_nettle.obj",
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_nettle_cleavers.png",
    })
    unilib.register_craft({
        -- From nettle:cleavers
        type = "fuel",
        recipe = "unilib:plant_nettle_cleavers",
        burntime = 3,
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration_spare("unilib:plant_nettle_cleavers")

end

function unilib.pkg.plant_nettle_cleavers.post()

    -- The shared package provides a spreading ABM; if it's not available, use the normal
    --      flora-spreading ABM
    if unilib.global.pkg_executed_table["abm_nettle_plant_nettle_spread"] == nil then

        unilib.override_item("unilib:plant_nettle_cleavers", {
            groups = {
                attached_node = 1, flammable = 1, flora = 1, nettle_weed = 1,
                oddly_breakable_by_hand = 2, snappy = 2,
            },
        })

    end

end
