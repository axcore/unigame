---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nettle
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_nettle_normal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.nettle.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_nettle_normal.init()

    return {
        description = "Normal nettle",
        notes = "Cause 1 damage per second",
    }

end

function unilib.pkg.plant_nettle_normal.exec()

    unilib.register_node("unilib:plant_nettle_normal", "nettle:nettle", mode, {
        -- From nettle:nettle
        description = unilib.annotate(S("Normal Nettle"), "Urtica"),
        tiles = {"unilib_plant_nettle_normal.png"},
        -- N.B. removed flora = 1 to prevent additional spreading
        groups = {
            attached_node = 1, flammable = 1, nettle_weed = 1, oddly_breakable_by_hand = 2,
            snappy = 2,
        },
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        damage_per_second = 1 * unilib.nettle_damage_factor,
        drawtype = "mesh",
        inventory_image = "unilib_plant_nettle_normal.png",
        mesh = "unilib_plant_nettle.obj",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_nettle_normal.png",
    })
    unilib.register_craft({
        -- From nettle:nettle
        type = "fuel",
        recipe = "unilib:plant_nettle_normal",
        burntime = 3,
    })
    -- (not compatible with flowerpots)

end

function unilib.pkg.plant_nettle_normal.post()

    -- The shared package provides a spreading ABM; if it's not available, use the normal
    --      flora-spreading ABM
    if unilib.pkg_executed_table["abm_nettle_plant_nettle_spread"] == nil then

        unilib.override_item("unilib:plant_nettle_normal", {
            groups = {
                attached_node = 1, flammable = 1, flora = 1, nettle_weed = 1,
                oddly_breakable_by_hand = 2, snappy = 2,
            },
        })

    end

end
