---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nettle
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_nettle_scotch_broom = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.nettle.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_nettle_scotch_broom.init()

    return {
        description = "Scotch broom nettle",
        notes = "A nettle that acts like a solid block",
    }

end

function unilib.pkg.plant_nettle_scotch_broom.exec()

    unilib.register_node("unilib:plant_nettle_scotch_broom", "nettle:scotch_broom", mode, {
        -- nettle:scotch_broom
        description = unilib.annotate(S("Scotch Broom"), "Cytisus scoparius"),
        tiles = {"unilib_plant_nettle_scotch_broom.png"},
        -- N.B. removed flora = 1 to prevent additional spreading
        groups = {choppy = 2, flammable = 1, nettle_weed = 1, oddly_breakable_by_hand = 1},
        sounds = unilib.sound_table.leaves,

        drawtype = "mesh",
        inventory_image = "unilib_plant_nettle_scotch_broom.png",
        mesh = "unilib_plant_nettle_scotch_broom.obj",
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        walkable = true,
        waving = 1,
        wield_image = "unilib_plant_nettle_scotch_broom.png",
    })
    unilib.register_craft({
        -- nettle:scotch_broom
        type = "fuel",
        recipe = "unilib:plant_nettle_scotch_broom",
        burntime = 6,
    })
    -- (not compatible with flowerpots)

end

function unilib.pkg.plant_nettle_scotch_broom.post()

    -- The shared package provides a spreading ABM; if it's not available, use the normal
    --      flora-spreading ABM
    if unilib.pkg_executed_table["abm_nettle_plant_nettle_spread"] == nil then

        unilib.override_item("unilib:plant_nettle_scotch_broom", {
            groups = {
                choppy = 2, flammable = 1, flora = 1, nettle_weed = 1, oddly_breakable_by_hand = 1,
            },
        })

    end

end
