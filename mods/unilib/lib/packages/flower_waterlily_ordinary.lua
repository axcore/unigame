---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    flowers
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_waterlily_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.flowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_waterlily_ordinary.init()

    return {
        description = "Ordinary waterlily",
        notes = "Waterlilies, when placed on water, are given a random waving [param2] value,"
    }

end

function unilib.pkg.flower_waterlily_ordinary.exec()

    -- The flowers mod provides two waterlily nodes. The waving variety is used as a decoration.
    --      When dug, it drops the non-waving variety. When the non-waving variety is placed on
    --      water, is is switched for the waving variety, with a random value for param2

    local waterlily_def = {
        description = S("Ordinary Waterlily"),
        tiles = {
            "unilib_flower_waterlily_ordinary.png",
            "unilib_flower_waterlily_ordinary_bottom.png",
        },
        groups = {flammable = 1, flower = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "nodebox",
        floodable = true,
        inventory_image = "unilib_flower_waterlily_ordinary.png",
        liquids_pointable = true,
        node_box = {
            type = "fixed",
            fixed = {-0.5, -31 / 64, -0.5, 0.5, -15 / 32, 0.5}
        },
        node_placement_prediction = "",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-7 / 16, -0.5, -7 / 16, 7 / 16, -15 / 32, 7 / 16}
        },
        use_texture_alpha = "clip",
        walkable = unilib.walkable_waterlilies_flag,
        wield_image = "flowers_waterlily.png",

        on_place = function(itemstack, placer, pointed_thing)

            local pos = pointed_thing.above
            local node = minetest.get_node(pointed_thing.under)
            local def = minetest.registered_nodes[node.name]

            if def and def.on_rightclick then

                return def.on_rightclick(
                    pointed_thing.under, node, placer, itemstack, pointed_thing
                )

            end

            if def and def.liquidtype == "source" and
                    minetest.get_item_group(node.name, "water") > 0 then

                local player_name = placer and placer:get_player_name() or ""
                if not minetest.is_protected(pos, player_name) then

                    minetest.set_node(
                        pos,
                        {
                            name = "unilib:flower_waterlily_ordinary" ..
                                (def.waving == 3 and "_waving" or ""),
                            param2 = math.random(0, 3)
                        }
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

        end
    }

    local waterlily_waving_def = table.copy(waterlily_def)
    waterlily_waving_def.waving = 3
    waterlily_waving_def.drop = "unilib:flower_waterlily_ordinary"
    waterlily_waving_def.groups.not_in_creative_inventory = 1

    unilib.register_node(
        -- From flowers:waterlily
        "unilib:flower_waterlily_ordinary",
        "flowers:waterlily",
        mode,
        waterlily_def
    )
    unilib.register_node(
        -- From flowers:waterlily_waving
        "unilib:flower_waterlily_ordinary_waving",
        "flowers:waterlily_waving",
        mode,
        waterlily_waving_def
    )
    -- (not compatible with flowerpots)

    unilib.register_decoration("flowers_flower_waterlily_ordinary", {
        -- From default/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:flower_waterlily_ordinary_waving",

        noise_params = {
            octaves = 3,
            offset = -0.12,
            persist = 0.7,
            scale = 0.3,
            seed = 33,
            spread = {x = 200, y = 200, z = 200},
        },
        param2 = 0,
        param2_max = 3,
        place_offset_y = 1,
        sidelen = 16,
    })

end
