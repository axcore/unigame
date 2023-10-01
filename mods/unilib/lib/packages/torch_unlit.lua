---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_torch
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.torch_unlit = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_torch.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_flood(pos, oldnode, newnode)

    minetest.add_item(pos, ItemStack("unilib:torch_unlit 1"))

    -- Play flame-extinguish sound if liquid is not an 'igniter'
    local nodedef = minetest.registered_items[newnode.name]

    -- Return if torch is unlit already
    if oldnode.name == "unilib:torch_unlit" or
            oldnode.name == "unilib:torch_unlit_wall" or
            oldnode.name == "unilib:torch_unlit_ceiling" then
        return false
    end

    -- Play sound if torch is lit
    if not (
        nodedef and
        nodedef.groups and
        nodedef.groups.igniter and
        nodedef.groups.igniter > 0
    ) then

        minetest.sound_play(
            "unilib_cool_lava",
            {pos = pos, max_hear_distance = 16, gain = 0.1},
            true
        )

    end

    -- Remove the torch node
    return false

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.torch_unlit.init()

    return {
        description = "Unlit torch",
        notes = "When this package is loaded, ordinary torches (even those already placed in" ..
                " the world) expire after some minutes, leaving behind an unlit torch. Reignite" ..
                " the torch with an ordinary match",
        depends = {"item_stick_ordinary", "torch_ordinary"},
    }

end

function unilib.pkg.torch_unlit.exec()

    unilib.register_node("unilib:torch_unlit", "real_torch:torch", mode, {
        -- From real_torch:torch
        description = S("Unlit Torch"),
        tiles = {
            {
                name = "unilib_torch_unlit.png",
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 3.3,
                },
            },
        },
        groups = {attached_node = 1, choppy = 2, dig_immediate = 3, flammable = 1},
        sounds = unilib.sound_table.wood,

        drawtype = "mesh",
        drop = "unilib:torch_unlit",
        floodable = true,
        inventory_image = "unilib_torch_unlit.png",
        liquids_pointable = false,
        light_source = 3,
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
        wield_image = "unilib_torch_unlit.png",

        on_flood = on_flood,

        on_ignite = function(pos, igniter)

            local node = minetest.get_node(pos)
            minetest.set_node(pos, {name = "unilib:torch_ordinary", param2 = node.param2})

        end,

        on_place = function(itemstack, placer, pointed_thing)

            local under = pointed_thing.under
            local node = minetest.get_node(under)
            local def_table = minetest.registered_nodes[node.name]

            if def_table and
                    def_table.on_rightclick and
                    ((not placer) or (placer and not placer:get_player_control().sneak)) then

                return def_table.on_rightclick(under, node, placer, itemstack, pointed_thing) or
                        itemstack

            end

            local above = pointed_thing.above
            local wdir = minetest.dir_to_wallmounted(vector.subtract(under, above))
            local fakestack = itemstack

            if wdir == 0 then
                fakestack:set_name("unilib:torch_unlit_ceiling")
            elseif wdir == 1 then
                fakestack:set_name("unilib:torch_unlit")
            else
                fakestack:set_name("unilib:torch_unlit_wall")
            end

            itemstack = minetest.item_place(fakestack, placer, pointed_thing, wdir)
            itemstack:set_name("unilib:torch_unlit")

            return itemstack

        end,
    })
    unilib.register_craft({
        -- From real_torch:torch
        output = "unilib:item_stick_ordinary",
        recipe = {
            {"unilib:torch_unlit", "unilib:torch_unlit"},
            {"unilib:torch_unlit", "unilib:torch_unlit"},
        }
    })

    unilib.register_node("unilib:torch_unlit_wall", "real_torch:torch_wall", mode, {
        -- From real_torch:torch_wall
        -- (no description)
        tiles = {
            {
                name = "unilib_torch_unlit.png",
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 3.3,
                },
            },
        },
        groups = {
            attached_node = 1, choppy = 2, dig_immediate = 3, flammable = 1,
            not_in_creative_inventory = 1,
        },
        sounds = unilib.sound_table.wood,

        drawtype = "mesh",
        drop = "unilib:torch_unlit",
        floodable = true,
        light_source = 3,
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

        on_ignite = function(pos, igniter)

            local node = minetest.get_node(pos)
            minetest.set_node(pos, {name = "unilib:torch_ordinary_wall", param2 = node.param2})

        end,
    })

    unilib.register_node("unilib:torch_unlit_ceiling", "real_torch:torch_ceiling", mode, {
        -- From real_torch:torch_ceiling
        -- (no description)
        tiles = {
            {
                name = "unilib_torch_unlit.png",
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 3.3,
                },
            },
        },
        groups = {
            attached_node = 1, choppy = 2, dig_immediate = 3, flammable = 1,
            not_in_creative_inventory = 1,
        },
        sounds = unilib.sound_table.wood,

        drawtype = "mesh",
        drop = "unilib:torch_unlit",
        floodable = true,
        light_source = 3,
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

        on_ignite = function(pos, igniter)

            local node = minetest.get_node(pos)
            minetest.set_node(pos, {name = "unilib:torch_ordinary_ceiling", param2 = node.param2})

        end,
    })

    -- Override ordinary torches so they burn out
    unilib.register_lbm({
        label = "Convert ordinary torch to unlit [torch_unlit]",
        name = "unilib:lbm_torch_unlit",
        nodenames = {
            "unilib:torch_ordinary",
            "unilib:torch_ordinary_wall",
            "unilib:torch_ordinary_ceiling",
        },

        action = function(pos)

            if not minetest.get_node_timer(pos):is_started() then

                minetest.get_node_timer(pos):start(
                    math.random(unilib.real_torch_min_time, unilib.real_torch_max_time)
                )

            end

        end,
    })

    unilib.override_item("unilib:torch_ordinary", {

        on_construct = function(pos)

            minetest.get_node_timer(pos):start(
                math.random(unilib.real_torch_min_time, unilib.real_torch_max_time)
            )

        end,

        on_flood = on_flood,

        on_timer = function(pos, elapsed)

            local p2 = minetest.get_node(pos).param2

            minetest.set_node(pos, {name = "unilib:torch_unlit", param2 = p2})
            minetest.sound_play(
                "unilib_extinguish_torch",
                {pos = pos, gain = 0.1, max_hear_distance = 10},
                true
            )

        end,
    })

    unilib.override_item("unilib:torch_ordinary_wall", {

        on_construct = function(pos)

            minetest.get_node_timer(pos):start(
                math.random(unilib.real_torch_min_time, unilib.real_torch_max_time)
            )

        end,

        on_flood = on_flood,

        on_timer = function(pos, elapsed)

            local p2 = minetest.get_node(pos).param2

            minetest.set_node(pos, {name = "unilib:torch_unlit_wall", param2 = p2})
            minetest.sound_play(
                "unilib_extinguish_torch",
                {pos = pos, gain = 0.1, max_hear_distance = 10},
                true
            )

        end,
    })

    unilib.override_item("unilib:torch_ordinary_ceiling", {

        on_construct = function(pos)

            minetest.get_node_timer(pos):start(
                math.random(unilib.real_torch_min_time, unilib.real_torch_max_time)
            )

        end,

        on_flood = on_flood,

        on_timer = function(pos, elapsed)

            local p2 = minetest.get_node(pos).param2

            minetest.set_node(pos, {name = "unilib:torch_unlit_ceiling", param2 = p2})
            minetest.sound_play(
                "unilib_extinguish_torch",
                {pos = pos, gain = 0.1, max_hear_distance = 10},
                true
            )

        end,
    })

end
