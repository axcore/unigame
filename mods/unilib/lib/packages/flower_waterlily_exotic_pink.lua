---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_waterlily_exotic_pink = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_place(itemstack, placer, pointed_thing)

    local pos = pointed_thing.above
    local node = minetest.get_node(pointed_thing.under).name
    local def = minetest.registered_nodes[node]
    local player_name = placer:get_player_name()

    if def and def.liquidtype == "source" and
            minetest.get_item_group(node, "water") > 0 then

        if not minetest.is_protected(pos, player_name) then

            if math.random(1, 2) == 1 then

                minetest.set_node(
                    pos,
                    {name = "unilib:flower_waterlily_exotic_pink", param2 = math.random(0, 3)}
                )

            else

                minetest.set_node(
                    pos,
                    {
                        name = "unilib:flower_waterlily_exotic_pink_flowering",
                        param2 = math.random(0, 3)
                    }
                )

            end

            if not minetest.settings:get_bool("creative_mode") then
                itemstack:take_item()
            end

        else

            minetest.chat_send_player(player_name, S("Node is protected"))
            minetest.record_protection_violation(pos, player_name)

        end

    end

    return itemstack

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_waterlily_exotic_pink.init()

    return {
        description = "Exotic waterlily with Pink Flower",
    }

end

function unilib.pkg.flower_waterlily_exotic_pink.exec()

    -- The flowering variant is partially defined in mapgen/mapgen.lua, overriding code in
    --      flowers/init.lua
    -- The decoration is adapted from flowers/mapgen.lua

    unilib.register_node("unilib:flower_waterlily_exotic_pink", nil, mode, {
        -- From farlands, mapgen/nodes.lua, mapgen:waterlily
        description = S("Exotic Waterlily"),
        tiles = {"unilib_flower_waterlily_exotic_pink.png"},
        groups = {flammable = 1, flower = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "mesh",
        floodable = true,
        inventory_image = "unilib_flower_waterlily_exotic_inv.png",
        liquids_pointable = true,
        mesh = "unilib_flower_waterlily_exotic.b3d",
        node_placement_prediction = "",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-7 / 16, -0.5, -7 / 16, 7 / 16, -15 / 32, 7 / 16},
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        visual_scale = 0.5,
        walkable = unilib.walkable_waterlilies_flag,
        wield_image = "unilib_flower_waterlily_exotic_inv.png",

        on_place = on_place,
    })
    -- (not compatible with flowerpots)

    unilib.register_node("unilib:flower_waterlily_exotic_pink_flowering", nil, mode, {
        -- From farlands, mapgen/nodes.lua, flowers:waterlily
        description = S("Exotic Waterlily with Pink Flower"),
        tiles = {"unilib_flower_waterlily_exotic_pink_flowering.png"},
        -- N.B. not_in_creative_inventory is not in original code
        groups = {flammable = 1, flower = 1, not_in_creative_inventory = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "mesh",
        -- N.B. drop not in original code
        drop = "unilib:flower_waterlily_exotic_pink",
        floodable = true,
        inventory_image = "unilib_flower_waterlily_exotic_inv.png",
        liquids_pointable = true,
        mesh = "unilib_flower_waterlily_exotic.b3d",
        node_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -15 / 32, 0.5}
        },
        node_placement_prediction = "",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-7 / 16, -0.5, -7 / 16, 7 / 16, -15 / 32, 7 / 16},
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        visual_scale = 0.5,
        walkable = unilib.walkable_waterlilies_flag,
        wield_image = "unilib_flower_waterlily_exotic_inv.png",

        on_place = on_place,
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration("farlands_flower_waterlily_exotic_pink", {
        -- From farlands, flowers/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_flower_waterlily_exotic_pink.mts",

        noise_params = {
            octaves = 3,
            offset = -0.12,
            persist = 0.7,
            scale = 0.3,
            seed = 33,
            spread = {x = 200, y = 200, z = 200},
        },
        rotation = "random",
        sidelen = 16,
    })

end
