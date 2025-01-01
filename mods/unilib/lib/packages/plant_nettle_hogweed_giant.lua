---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nettle
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_nettle_hogweed_giant = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.nettle.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_nettle_hogweed_giant.init()

    return {
        description = "Giant hogweed nettle",
        notes = "Cause 2 damage per second and hurts the player when punched",
    }

end

function unilib.pkg.plant_nettle_hogweed_giant.exec()

    unilib.register_node("unilib:plant_nettle_hogweed_giant", "nettle:giant_hogweed", mode, {
        -- From nettle:giant_hogweed
        description = unilib.utils.annotate(S("Giant Hogweed"), "Heracleum mantegazzianum"),
        tiles = {"unilib_plant_nettle_hogweed_giant.png"},
        -- N.B. removed flora = 1 to prevent additional spreading
        groups = {
            attached_node = 1, flammable = 1, nettle_weed = 1, oddly_breakable_by_hand = 2,
            snappy = 2,
        },
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        damage_per_second = 2 * unilib.setting.nettle_damage_factor,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_nettle_hogweed_giant.png",
        paramtype = "light",
        sunlight_propagates = true,
        visual_scale = 2,
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_nettle_hogweed_giant.png",

        on_punch = function(pos, node, player, pointed_thing)
            player:set_hp(player:get_hp() - 1)
        end,
    })
    unilib.register_craft({
        -- From nettle:giant_hogweed
        type = "fuel",
        recipe = "unilib:plant_nettle_hogweed_giant",
        burntime = 3,
    })
    unilib.register_plant_in_pot("unilib:plant_nettle_hogweed_giant", "nettle:giant_hogweed")

    unilib.register_decoration_spare("unilib:plant_nettle_hogweed_giant")

end

function unilib.pkg.plant_nettle_hogweed_giant.post()

    -- The shared package provides a spreading ABM; if it's not available, use the normal
    --      flora-spreading ABM
    if unilib.global.pkg_executed_table["abm_nettle_plant_nettle_spread"] == nil then

        unilib.override_item("unilib:plant_nettle_hogweed_giant", {
            groups = {
                attached_node = 1, flammable = 1, flora = 1, nettle_weed = 1,
                oddly_breakable_by_hand = 2, snappy = 2,
            },
        })

    end

end
