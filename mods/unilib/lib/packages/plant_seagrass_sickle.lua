---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xocean
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_seagrass_sickle = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xocean.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_seagrass_sickle.init()

    return {
        description = "Sickle seagrass",
        notes = "Can only be placed on underwater sand",
        depends = {"liquid_water_ordinary", "sand_ordinary"},
    }

end

function unilib.pkg.plant_seagrass_sickle.exec()

    unilib.register_node("unilib:plant_seagrass_sickle", "xocean:seagrass", mode, {
        -- From xocean:seagrass
        description = unilib.annotate(S("Sickle Seagrass"), "Thalassia hemprichii"),
        tiles = {"unilib_sand_ordinary.png"},
        groups = {snappy = 3},
        sounds = unilib.node_sound_stone_defaults({
            dig = {name = "unilib_dig_snappy", gain = 0.2},
            dug = {name = "unilib_grass_footstep", gain = 0.25},
        }),

        drawtype = "plantlike_rooted",
        inventory_image = "unilib_plant_seagrass_sickle.png",
        node_dig_prediction = "unilib:sand_ordinary",
        node_placement_prediction = "",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
                {-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
            },
        },
        special_tiles = {
            {name = "unilib_plant_seagrass_sickle.png", tileable_vertical = true},
        },
        waving = 1,

        after_destruct = function(pos, oldnode)
            minetest.set_node(pos, {name = "unilib:sand_ordinary"})
        end,

        on_place = function(itemstack, placer, pointed_thing)

            if pointed_thing.type ~= "node" or not placer then
                return itemstack
            end

            local player_name = placer:get_player_name()
            local pos_under = pointed_thing.under
            local pos_above = pointed_thing.above

            if minetest.get_node(pos_under).name ~= "unilib:sand_ordinary" or
                    minetest.get_node(pos_above).name ~= "unilib:liquid_water_ordinary_source" then

                return itemstack

            end

            if minetest.is_protected(pos_under, player_name) or
                    minetest.is_protected(pos_above, player_name) then

                minetest.chat_send_player(player_name, S("Node is protected"))
                minetest.record_protection_violation(pos_under, player_name)
                return itemstack

            end

            minetest.set_node(pos_under, {name = "unilib:plant_seagrass_sickle"})
            if not (creative and creative.is_enabled_for(player_name)) then
                itemstack:take_item()
            end

            return itemstack

        end,
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration("xocean_plant_seagrass_sickle", {
        -- From xocean/init.lua
        deco_type = "simple",
        decoration = "unilib:plant_seagrass_sickle",

        flags = "force_placement",
        noise_params = {
            octaves = 3,
            offset = -0.04,
            persist = 0.7,
            scale = 0.4,
            seed = 87112,
            spread = {x = 200, y = 200, z = 200},
        },
        param2 = 48,
        param2_max = 96,
        place_offset_y = -1,
        sidelen = 16,
    })

end
