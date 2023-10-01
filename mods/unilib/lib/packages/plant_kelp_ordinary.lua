---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_kelp_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_kelp_ordinary.init()

    return {
        description = "Ordinary sand with kelp",
        notes = "Occurs naturally in temperate/cool oceans, growing on ordinary sand. Kelp has" ..
                " a random height. Kelp must be placed on sand, in a column of at least 4" ..
                " water-like blocks. The kelp and its sand block are in fact one unit; the fake" ..
                " sand block does not fall",
        depends = "sand_ordinary",
    }

end

function unilib.pkg.plant_kelp_ordinary.exec()

    unilib.register_node("unilib:plant_kelp_ordinary", "default:sand_with_kelp", mode, {
        -- From default:sand_with_kelp
        description = S("Ordinary Kelp"),
        tiles = {"unilib_sand_ordinary.png"},
        groups = {snappy = 3},
        sounds = unilib.node_sound_sand_defaults({
            dig = {name = "unilib_dig_snappy", gain = 0.2},
            dug = {name = "unilib_grass_footstep", gain = 0.25},
        }),

        drawtype = "plantlike_rooted",
        inventory_image = "unilib_plant_kelp_ordinary.png",
        node_dig_prediction = "unilib:sand_ordinary",
        node_placement_prediction = "",
        paramtype = "light",
        paramtype2 = "leveled",
        selection_box = {
            type = "fixed",
            fixed = {
                    {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
                    {-2/16, 0.5, -2/16, 2/16, 3.5, 2/16},
            },
        },
        special_tiles = {{name = "unilib_plant_kelp_ordinary.png", tileable_vertical = true}},
        waving = 1,
        wield_image = "unilib_plant_kelp_ordinary.png",

        after_destruct = function(pos, oldnode)
            minetest.set_node(pos, {name = "unilib:sand_ordinary"})
        end,

        on_place = function(itemstack, placer, pointed_thing)

            -- Call on_right-click if the pointed node defines it
            if pointed_thing.type == "node" and placer and
                    not placer:get_player_control().sneak then

                local node_ptu = minetest.get_node(pointed_thing.under)
                local def_ptu = minetest.registered_nodes[node_ptu.name]
                if def_ptu and def_ptu.on_rightclick then

                    return def_ptu.on_rightclick(
                        pointed_thing.under, node_ptu, placer, itemstack, pointed_thing
                    )

                end

            end

            local pos = pointed_thing.under
            if minetest.get_node(pos).name ~= "unilib:sand_ordinary" then
                return itemstack
            end

            local height = math.random(4, 6)
            local pos_top = {x = pos.x, y = pos.y + height, z = pos.z}
            local node_top = minetest.get_node(pos_top)
            local def_top = minetest.registered_nodes[node_top.name]
            local player_name = placer:get_player_name()

            if def_top and def_top.liquidtype == "source" and
                    minetest.get_item_group(node_top.name, "water") > 0 then

                if not minetest.is_protected(pos, player_name) and
                        not minetest.is_protected(pos_top, player_name) then

                    minetest.set_node(
                        pos,
                        {name = "unilib:plant_kelp_ordinary", param2 = height * 16}
                    )

                    if not unilib.is_creative(player_name) then
                        itemstack:take_item()
                    end

                else

                    minetest.chat_send_player(player_name, S("Node is protected"))
                    minetest.record_protection_violation(pos, player_name)

                end

            end

            return itemstack

        end,
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration("default_plant_kelp_ordinary", {
        -- From default/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:plant_kelp_ordinary",

        flags = "force_placement",
        noise_params = {
            octaves = 3,
            offset = -0.04,
            persist = 0.7,
            scale = 0.1,
            seed = 87112,
            spread = {x = 200, y = 200, z = 200},
        },
        param2 = 48,
        param2_max = 96,
        place_offset_y = -1,
        sidelen = 16,
    })

end
