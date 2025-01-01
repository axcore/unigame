---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xocean
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_pickle_sea = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xocean.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_pickle_sea.init()

    return {
        description = "Sea pickle",
        notes = "Static plant that emits light",
        depends = {"liquid_water_ordinary", "sand_ordinary"},
    }

end

function unilib.pkg.plant_pickle_sea.exec()

    unilib.register_node("unilib:plant_pickle_sea", "xocean:pickle", mode, {
        -- From xocean:pickle
        description = unilib.utils.annotate(S("Sea Pickle"), "Pyrosoma"),
        tiles = {"unilib_sand_ordinary.png"},
        groups = {snappy = 3},
        sounds = unilib.sound.generate_stone({
            dig = {name = "unilib_dig_snappy", gain = 0.2},
            dug = {name = "unilib_grass_footstep", gain = 0.25},
        }),

        drawtype = "plantlike_rooted",
        inventory_image = "unilib_plant_pickle_sea.png",
        light_source = 3,
        node_dig_prediction = "unilib:sand_ordinary",
        node_placement_prediction = "",
        paramtype = "light",
        -- N.B. No .paramtype2 in original code
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
                {-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
            },
        },
        special_tiles = {
            {name = "unilib_plant_pickle_sea.png", tileable_vertical = true},
        },
        waving = 1,

        after_destruct = function(pos, oldnode)
            core.set_node(pos, {name = "unilib:sand_ordinary"})
        end,

        --[[
        on_place = function(itemstack, placer, pointed_thing)

            if pointed_thing.type ~= "node" or not placer then
                return itemstack
            end

            local player_name = placer:get_player_name()
            local pos_under = pointed_thing.under
            local pos_above = pointed_thing.above

            if core.get_node(pos_under).name ~= "unilib:sand_ordinary" or
                    core.get_node(pos_above).name ~= "unilib:liquid_water_ordinary_source" then

                return itemstack

            end

            if core.is_protected(pos_under, player_name) or
                    core.is_protected(pos_above, player_name) then

                core.chat_send_player(player_name, S("Node is protected"))
                core.record_protection_violation(pos_under, player_name)
                return itemstack

            end

            core.set_node(pos_under, {name = "unilib:plant_pickle_sea"})
            if not (creative and creative.is_enabled_for(player_name)) then
                itemstack:take_item()
            end

            return itemstack

        end,
        ]]--

        -- N.B. Original code specifies "unilib:sand_ordinary" and
        --      "unilib:liquid_water_ordinary_source"
        on_place = function(itemstack, placer, pointed_thing)

            return unilib.misc.place_in_medium(
                itemstack, placer, pointed_thing,
                {need_under = "group:sand"}
            )

        end,
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration_generic("xocean_plant_pickle_sea", {
        -- From xocean/init.lua
        deco_type = "simple",
        decoration = "unilib:plant_pickle_sea",

        flags = "force_placement",
        noise_params = {
            octaves = 3,
            offset = -0.04,
            persist = 0.7,
            scale = 0.04,
            seed = 87112,
            spread = {x = 200, y = 200, z = 200},
        },
        -- N.B. Replaced apparently useless values of .param2/.param2_max from original code
--      param2 = 48,
--      param2_max = 96,
        param2 = 0,
        param2_max = 3,
        place_offset_y = -1,
        sidelen = 16,
    })

end
