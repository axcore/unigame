---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
--
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_waterlily_exotic_yellow = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_place(itemstack, placer, pointed_thing)

    local pos = pointed_thing.above
    local node = core.get_node(pointed_thing.under).name
    local def = core.registered_nodes[node]
    local player_name = placer:get_player_name()

    if def and def.liquidtype == "source" and core.get_item_group(node, "water") > 0 then

        if not core.is_protected(pos, player_name) then

            if math.random(1, 2) == 1 then

                core.set_node(
                    pos,
                    {name = "unilib:flower_waterlily_exotic_yellow", param2 = math.random(0, 3)}
                )

            else

                core.set_node(
                    pos,
                    {
                        name = "unilib:flower_waterlily_exotic_yellow_flowering",
                        param2 = math.random(0, 3)
                    }
                )

            end

            if not core.settings:get_bool("creative_mode") then
                itemstack:take_item()
            end

        else

            core.chat_send_player(player_name, S("Node is protected"))
            core.record_protection_violation(pos, player_name)

        end

    end

    return itemstack

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_waterlily_exotic_yellow.init()

    return {
        description = "Exotic waterlily with yellow flower",
    }

end

function unilib.pkg.flower_waterlily_exotic_yellow.exec()

    unilib.register_node("unilib:flower_waterlily_exotic_yellow", nil, mode, {
        -- From farlands, mapgen/nodes.lua, mapgen:waterlily. Texture is from GLEMr4,
        --      lib_ecology_plant_waterlily_yellow_noflower.png
        description = S("Exotic Waterlily"),
        tiles = {"unilib_flower_waterlily_exotic_yellow.png"},
        groups = {flammable = 1, flower = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

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
        walkable = unilib.setting.walkable_waterlilies_flag,
        wield_image = "unilib_flower_waterlily_exotic_inv.png",

        on_place = on_place,
    })
    -- (not compatible with flowerpots)

    unilib.register_node("unilib:flower_waterlily_exotic_yellow_flowering", nil, mode, {
        -- From farlands, mapgen/nodes.lua, flowers:waterlily. Texture is from GLEMr4,
        --      lib_ecology_plant_waterlily_yellow.png
        description = S("Exotic Waterlily with Yellow Flower"),
        tiles = {"unilib_flower_waterlily_exotic_yellow_flowering.png"},
        -- N.B. not_in_creative_inventory is not in original code
        groups = {flammable = 1, flower = 1, not_in_creative_inventory = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "mesh",
        -- N.B. drop not in original code
        drop = "unilib:flower_waterlily_exotic_yellow",
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
        walkable = unilib.setting.walkable_waterlilies_flag,
        wield_image = "unilib_flower_waterlily_exotic_inv.png",

        on_place = on_place,
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration_generic("farlands_flower_waterlily_exotic_yellow", {
        -- From farlands, flowers/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_flower_waterlily_exotic_yellow.mts",

        noise_params = {
            octaves = 3,
            offset = -0.12,
            persist = 0.7,
            scale = 0.3,
            seed = 66,
            spread = {x = 200, y = 200, z = 200},
        },
        rotation = "random",
        sidelen = 16,
    })

end
