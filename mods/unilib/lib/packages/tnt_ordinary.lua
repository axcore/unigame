---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    tnt
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tnt_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.tnt.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tnt_ordinary.init()

    return {
        description = "TNT and related items",
        notes = "Use flint and steel, or a torch, to ignite a trail of gunpowder or a pile of TNT",
        depends = {
            "gravel_ordinary",
            "item_paper_ordinary",
            "mineral_coal",
            "shared_tnt",
            "torch_ordinary",
        },
        -- One of these is required by the ABM in ../lib/system/abms.lua
        at_least_one = {"fire_ordinary", "liquid_lava_ordinary"},
    }

end

function unilib.pkg.tnt_ordinary.exec()

    -- N.B. All TNT items are in one package, as they are useless without each other
    -- Six items are created in this package. Three are available in the player's inventory:
    --      unilib:tnt_ordinary
    --          A pile of TNT
    --      unilib:tnt_ordinary_stick
    --          Sticks are ingredients to make the pile of TNT
    --      unilib:tnt_gunpowder
    --          Gunpowder is used to make a trail on the ground, leading to the pile. Flint/torch
    --              can ignite the powder trail
    -- Three are not in the player's inventory:
    --      unilib:gunpowder_burning
    --          Gunpowder that has been ignited
    --      unilib:tnt_ordinary_burning
    --          Pile of TNT that has been ignited
    --      unilib:tnt_ordinary_placeholder
    --          Placeholder used during the explosion

    unilib.register_node("unilib:tnt_ordinary_placeholder", "tnt:boom", mode, {
        -- From tnt:boom
        -- (no diescrption)
        -- (no tiles)
        groups = {dig_immediate = 3, not_in_creative_inventory = 1},
        -- (no sounds)

        drawtype = "airlike",
        drop = "",
        inventory_image = "unilib_tnt_ordinary_boom.png",
        light_source = unilib.light_max,
        walkable = false,
        wield_image = "unilib_tnt_ordinary_boom.png",

        -- Unaffected by explosions
        on_blast = function() end,
    })

    unilib.register_node("unilib:tnt_gunpowder", "tnt:gunpowder", mode, {
        -- From tnt:gunpowder
        description = S("Ordinary Gun Powder"),
        tiles = {
            "unilib_tnt_gunpowder_straight.png",
            "unilib_tnt_gunpowder_curved.png",
            "unilib_tnt_gunpowder_tjunction.png",
            "unilib_tnt_gunpowder_crossing.png"
        },
        groups = {
            attached_node = 1,
            connect_to_raillike = minetest.raillike_group("gunpowder"),
            dig_immediate = 2,
            flammable = 5,
        },
        sounds = unilib.sound_table.leaves,

        drawtype = "raillike",
        inventory_image = "unilib_tnt_gunpowder_inv.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_tnt_gunpowder_inv.png",

        on_blast = function(pos, intensity)
            minetest.set_node(pos, {name = "unilib:tnt_gunpowder_burning"})
        end,

        on_burn = function(pos)
            minetest.set_node(pos, {name = "unilib:tnt_gunpowder_burning"})
        end,

        on_ignite = function(pos, igniter)
            minetest.set_node(pos, {name = "unilib:tnt_gunpowder_burning"})
        end,

        on_punch = function(pos, node, puncher)

            if puncher:get_wielded_item():get_name() == "unilib:torch_ordinary" then

                minetest.set_node(pos, {name = "unilib:tnt_gunpowder_burning"})
                unilib.log(
                    "action",
                    puncher:get_player_name() .. " ignites gunpowder at " ..
                            minetest.pos_to_string(pos)
                )

            end

        end,
    })
    unilib.register_craft({
        -- From tnt:gunpowder
        type = "shapeless",
        output = "unilib:tnt_gunpowder 5",
        recipe = {"unilib:gravel_ordinary", "unilib:mineral_coal_lump"}
    })

    unilib.register_node("unilib:tnt_gunpowder_burning", "tnt:gunpowder_burning", mode, {
        -- From tnt:gunpowder_burning
        -- (no description)
        tiles = {{
            name = "unilib_tnt_gunpowder_straight_burning_animated.png",
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 1,
            }
        },
        {
            name = "unilib_tnt_gunpowder_curved_burning_animated.png",
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 1,
            }
        },
        {
            name = "unilib_tnt_gunpowder_tjunction_burning_animated.png",
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 1,
            }
        },
        {
            name = "unilib_tnt_gunpowder_crossing_burning_animated.png",
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 1,
            }
        }},
        groups = {
            attached_node = 1,
            connect_to_raillike = minetest.raillike_group("gunpowder"),
            dig_immediate = 2,
            not_in_creative_inventory = 1
        },
        sounds = unilib.sound_table.leaves,

        drawtype = "raillike",
        drop = "",
        light_source = 5,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
        },
        sunlight_propagates = true,
        walkable = false,

        -- Unaffected by explosions
        on_blast = function() end,

        on_construct = function(pos)

            minetest.sound_play("unilib_gunpowder_burning", {pos = pos, gain = 2}, true)
            minetest.get_node_timer(pos):start(1)

        end,

        on_timer = function(pos, elapsed)

            for dx = -1, 1 do

                for dz = -1, 1 do

                    if math.abs(dx) + math.abs(dz) == 1 then

                        for dy = -1, 1 do

                            unilib.pkg.shared_tnt.tnt_burn({
                                x = pos.x + dx,
                                y = pos.y + dy,
                                z = pos.z + dz,
                            })

                        end

                    end

                end

            end

            minetest.remove_node(pos)

        end,
    })

    unilib.register_craftitem("unilib:tnt_ordinary_stick", "tnt:tnt_stick", mode, {
        -- From tnt:tnt_stick
        description = S("Ordinary TNT Stick"),
        inventory_image = "unilib_tnt_ordinary_stick.png",
        groups = {flammable = 5},
    })
    if unilib.enable_tnt_flag then

        unilib.register_craft({
            output = "unilib:tnt_ordinary_stick 2",
            recipe = {
                {"unilib:tnt_gunpowder", "", "unilib:tnt_gunpowder"},
                {"unilib:tnt_gunpowder", "unilib:item_paper_ordinary", "unilib:tnt_gunpowder"},
                {"unilib:tnt_gunpowder", "", "unilib:tnt_gunpowder"},
            }
        })

    end

    unilib.pkg.shared_tnt.register_tnt({
        -- From tnt:tnt. Creates unilib:tnt_ordinary
        part_name = "ordinary",
        orig_name = {"tnt:tnt", "tnt:tnt_burning"},
        def_table = {
            description = S("Ordinary TNT"),
        },

        replace_mode = mode,
    })
    if unilib.enable_tnt_flag then

        unilib.register_craft_3x3({
            output = "unilib:tnt_ordinary",
            ingredient = "unilib:tnt_ordinary_stick",
        })

    end

end
