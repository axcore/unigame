---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.torch_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.torch_ordinary.init()

    return {
        description = "Ordinary torch",
        depends = "mineral_coal",
    }

end

function unilib.pkg.torch_ordinary.exec()

    local function on_flood(pos, oldnode, newnode)

        -- When flooded, any kind of ordinary torch becomes a dropped item
        core.add_item(pos, ItemStack("unilib:torch_ordinary 1"))

        -- Play flame-extinguish sound if the flooding liquid is not an 'igniter'
        local nodedef = core.registered_items[newnode.name]
        if not (
            nodedef and nodedef.groups and nodedef.groups.igniter and nodedef.groups.igniter > 0
        ) then

            core.sound_play(
                "unilib_cool_lava",
                {pos = pos, max_hear_distance = 16, gain = 0.07},
                true
            )

        end

        -- Remove the torch node
        return false

    end

    unilib.register_node("unilib:torch_ordinary", "default:torch", mode, {
        -- From default:torch
        description = S("Ordinary Torch"),
        tiles = {{
            name = "unilib_torch_ordinary_animated.png",
            animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
        }},
        groups = {attached_node = 1, choppy = 2, dig_immediate = 3, flammable = 1, torch = 1},
        sounds = unilib.global.sound_table.wood,

        drawtype = "mesh",
        drop = "unilib:torch_ordinary",
        floodable = true,
        inventory_image = "unilib_torch_ordinary.png",
        light_source = 12,
        liquids_pointable = false,
        mesh = "unilib_torch_floor.obj",
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = {
            type = "wallmounted",
            wall_bottom = {-1/8, -1/2, -1/8, 1/8, 2/16, 1/8},
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        walkable = false,
        wield_image = "unilib_torch_ordinary.png",

        on_flood = on_flood,

        on_place = function(itemstack, placer, pointed_thing)

            local under = pointed_thing.under
            local node = core.get_node(under)
            local def = core.registered_nodes[node.name]

            if def and def.on_rightclick and not (
                placer and placer:is_player() and placer:get_player_control().sneak
            ) then
                return def.on_rightclick(under, node, placer, itemstack, pointed_thing) or itemstack
            end

            local above = pointed_thing.above
            local wdir = core.dir_to_wallmounted(vector.subtract(under, above))
            local fakestack = itemstack

            if wdir == 0 then
                fakestack:set_name("unilib:torch_ordinary_ceiling")
            elseif wdir == 1 then
                fakestack:set_name("unilib:torch_ordinary")
            else
                fakestack:set_name("unilib:torch_ordinary_wall")
            end

            itemstack = core.item_place(fakestack, placer, pointed_thing, wdir)
            itemstack:set_name("unilib:torch_ordinary")

            return itemstack

        end,

        on_rotate = false
    })
    unilib.register_craft({
        -- From default:torch
        output = "unilib:torch_ordinary 4",
        recipe = {
            {"unilib:mineral_coal_lump"},
            {"group:stick"},
        },
    })
    unilib.register_craft({
        -- From default:torch
        type = "fuel",
        recipe = "unilib:torch_ordinary",
        burntime = 4,
    })

    unilib.register_node("unilib:torch_ordinary_wall", "default:torch_wall", mode, {
        -- From default:torch_wall
        -- (no description)
        tiles = {{
            name = "unilib_torch_ordinary_animated.png",
            animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
        }},
        groups = {
            attached_node = 1, choppy = 2, dig_immediate = 3, flammable = 1,
            not_in_creative_inventory = 1, torch = 1,
        },
        sounds = unilib.global.sound_table.wood,

        drawtype = "mesh",
        drop = "unilib:torch_ordinary",
        floodable = true,
        light_source = 12,
        mesh = "unilib_torch_wall.obj",
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = {
            type = "wallmounted",
            wall_side = {-1/2, -1/2, -1/8, -1/8, 1/8, 1/8},
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        walkable = false,

        on_flood = on_flood,

        on_rotate = false
    })

    unilib.register_node("unilib:torch_ordinary_ceiling", "default:torch_ceiling", mode, {
        -- From default:torch_ceiling
        -- (no description)
        tiles = {{
            name = "unilib_torch_ordinary_animated.png",
            animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
        }},
        groups = {
            attached_node = 1, choppy = 2, dig_immediate = 3, flammable = 1,
            not_in_creative_inventory = 1, torch = 1,
        },
        sounds = unilib.global.sound_table.wood,

        drawtype = "mesh",
        drop = "unilib:torch_ordinary",
        floodable = true,
        light_source = 12,
        mesh = "unilib_torch_ceiling.obj",
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = {
            type = "wallmounted",
            wall_top = {-1/8, -1/16, -5/16, 1/8, 1/2, 1/8},
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        walkable = false,

        on_flood = on_flood,

        on_rotate = false
    })

    unilib.register_lbm({
        label = "Place ordinary torches [torch_ordinary]",
        name = "unilib:lbm_torch_ordinary",
        nodenames = {"unilib:torch_ordinary"},

        action = function(pos, node)

            if node.param2 == 0 then
                core.set_node(pos, {name = "unilib:torch_ordinary_ceiling", param2 = node.param2})
            elseif node.param2 == 1 then
                core.set_node(pos, {name = "unilib:torch_ordinary", param2 = node.param2})
            else
                core.set_node(pos,{name = "unilib:torch_ordinary_wall", param2 = node.param2})
            end

        end
    })
    unilib.register_obsolete_lbm({
        mod_origin = "default",
        name = "default:3dtorch",
    })

end
