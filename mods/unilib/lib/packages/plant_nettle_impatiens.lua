---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nettle
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_nettle_impatiens = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.nettle.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_nettle_impatiens.init()

    return {
        description = "Impatiens nettle",
        notes = "A nettle that doesn't harm the player, but still looks nasty",
    }

end

function unilib.pkg.plant_nettle_impatiens.exec()

    unilib.register_node("unilib:plant_nettle_impatiens", "nettle:impatiens", mode, {
        -- From nettle:impatiens
        description = unilib.utils.annotate(S("Impatiens"), "Impatiens"),
        tiles = {"unilib_plant_nettle_impatiens.png"},
        -- N.B. removed flora = 1 to prevent additional spreading
        groups = {
            attached_node = 1, flammable = 1, nettle_weed = 1, oddly_breakable_by_hand = 2,
            snappy = 2,
        },
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "mesh",
        inventory_image = "unilib_plant_nettle_impatiens.png",
        mesh = "unilib_plant_nettle.obj",
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_nettle_impatiens.png",
    })
    unilib.register_craft({
        -- From nettle:impatiens
        type = "fuel",
        recipe = "unilib:plant_nettle_impatiens",
        burntime = 3,
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration_spare("unilib:plant_nettle_impatiens")

end

function unilib.pkg.plant_nettle_impatiens.post()

    -- The shared package provides a spreading ABM; if it's not available, use the normal
    --      flora-spreading ABM
    if unilib.global.pkg_executed_table["abm_nettle_plant_nettle_spread"] == nil then

        unilib.override_item("unilib:plant_nettle_impatiens", {
            groups = {
                attached_node = 1, flammable = 1, flora = 1, nettle_weed = 1,
                oddly_breakable_by_hand = 2, snappy = 2,
            },
        })

    end

end
