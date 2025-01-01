---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ropes
-- Code:    MIT
-- Media:   unknown (textures), CC0 (sounds)
---------------------------------------------------------------------------------------------------

unilib.pkg.ladder_rope = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ropes.add_mode

-- (As long as the shortest mining rope)
local max_length = 50
-- (Burntimes in "shared_roeps" packages have local variables, so add one here for consistency)
local ladder_burntime = 15

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ladder_rope.init()

    return {
        description = "Rope ladder",
        notes = "Provides a ladder that behaves like a mining rope",
        depends = "shared_ropes",
        suggested = {
            "rope_mining",                      -- group:vines
        },
    }

end

function unilib.pkg.ladder_rope.exec()

    unilib.register_node("unilib:ladder_rope_top", "ropes:ropeladder_top", mode, {
        -- From ropes:ropeladder_top
        description = S("Rope Ladder"),
        tiles = {"unilib_ladder_wood_ordinary.png^unilib_ladder_rope_top_overlay.png"},
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1},
        sounds = unilib.global.sound_table.wood,

        climbable = true,
        drawtype = "signlike",
        inventory_image = "unilib_ladder_wood_ordinary.png^unilib_ladder_rope_top_overlay.png",
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = {
            type = "wallmounted",
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        walkable = false,
        wield_image = "unilib_ladder_wood_ordinary.png^unilib_ladder_rope_top_overlay.png",

        after_destruct = function(pos)

            local pos_below = {x = pos.x, y = pos.y - 1, z = pos.z}
            unilib.pkg.shared_ropes.destroy_rop(
                pos_below,
                {"unilib:ladder_rope", "unilib:ladder_rope_bottom", "unilib:ladder_rope_falling"}
            )

        end,

        after_place_node = function(pos, placer)

            local pos_below = {x = pos.x, y = pos.y - 1, z = pos.z}
            local node_below = core.get_node(pos_below)
            local this_node = core.get_node(pos)
            local placer_name = placer:get_player_name()

            -- param2 holds the facing direction of this node. If it's 0 or 1 the node is "flat" and
            --      we don't want the ladder to extend.
            if unilib.pkg.shared_ropes.can_place_rope_in_node(node_below.name) and
                    this_node.param2 > 1 and
                    (
                        not core.is_protected(pos_below, placer_name)
                        or core.check_player_privs(placer_name, "protection_bypass")
                    ) then

                core.add_node(
                    pos_below,
                    {name = "unilib:ladder_rope_bottom", param2 = this_node.param2}
                )

                local meta = core.get_meta(pos_below)
                meta:set_int("length_remaining", max_length)
                meta:set_string("placer", placer_name)

            end

        end,

        on_place = function(itemstack, placer, pointed_thing)

            if pointed_thing.type == "node" then

                local target_node = core.get_node(pointed_thing.under)
                local target_def = core.registered_nodes[target_node.name]
                if target_def.walkable == false then
                    return itemstack
                end

            end

            return core.item_place(itemstack, placer, pointed_thing)

        end,
    })
    unilib.register_craft({
        -- From ropes:ropeladder_top
        output = "unilib:ladder_rope_top",
        recipe = {
            {"", "group:stick", ""},
            {"group:vines", "group:stick", "group:vines"},
            {"", "group:stick", ""},
        },
    })
    unilib.register_craft({
        -- From ropes:ropeladder_top
        type = "fuel",
        recipe = "unilib:ladder_rope_top",
        burntime = ladder_burntime,
    })

    unilib.register_node("unilib:ladder_rope", "ropes:ropeladder", mode, {
        -- From ropes:ropeladder
        description = S("Rope Ladder"),
        tiles = {"unilib_ladder_wood_ordinary.png^unilib_ladder_rope_overlay.png"},
        groups = {choppy = 2, flammable = 2, not_in_creative_inventory = 1},
        sounds = unilib.global.sound_table.wood,

        climbable = true,
        drop = "",
        drawtype = "signlike",
        inventory_image = "unilib_ladder_wood_ordinary.png^unilib_ladder_rope_overlay.png",
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = {
            type = "wallmounted",
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        walkable = false,
        wield_image = "unilib_ladder_wood_ordinary.png^unilib_ladder_rope_overlay.png",

        after_destruct = function(pos)

            unilib.pkg.shared_ropes.hanging_after_destruct(
                pos,
                "unilib:ladder_rope_falling", "unilib:ladder_rope", "unilib:ladder_rope_bottom"
            )

        end,
    })

    unilib.register_node("unilib:ladder_rope_bottom", "ropes:ropeladder_bottom", mode, {
        -- From ropes:ropeladder_bottom
        description = S("Rope Ladder"),
        tiles = {"unilib_ladder_wood_ordinary.png^unilib_ladder_rope_bottom_overlay.png"},
        groups = {choppy = 2, flammable = 2, not_in_creative_inventory = 1},
        sounds = unilib.global.sound_table.wood,

        climbable = true,
        drop = "",
        drawtype = "signlike",
        inventory_image = "unilib_ladder_wood_ordinary.png^unilib_ladder_rope_bottom_overlay.png",
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = {
            type = "wallmounted",
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        walkable = false,
        wield_image = "unilib_ladder_wood_ordinary.png^unilib_ladder_rope_bottom_overlay.png",

        after_destruct = function(pos)

            unilib.pkg.shared_ropes.hanging_after_destruct(
                pos, "unilib:ladder_rope_falling", "unilib:ladder_rope", "unilib:ladder_rope_bottom"
            )

        end,

        on_construct = function(pos)

            local timer = core.get_node_timer(pos)
            timer:start(1)

        end,

        on_timer = unilib.pkg.shared_ropes.make_rope_on_timer("unilib:ladder_rope"),
    })

    unilib.register_node("unilib:ladder_rope_falling", "ropes:ropeladder_falling", mode, {
        -- ropes:ropeladder_falling
        description = S("Rope Ladder"),
        tiles = {"unilib_ladder_wood_ordinary.png^unilib_ladder_rope_overlay.png"},
        groups = {flammable = 2, not_in_creative_inventory = 1},
        sounds = unilib.global.sound_table.wood,

        climbable = true,
        drop = "",
        drawtype = "signlike",
        inventory_image = "unilib_ladder_wood_ordinary.png^unilib_ladder_rope_overlay.png",
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = {
            type = "wallmounted",
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        walkable = false,
        wield_image = "unilib_ladder_wood_ordinary.png^unilib_ladder_rope_overlay.png",

        on_construct = function(pos)

            local timer = core.get_node_timer(pos)
            timer:start(1)

        end,

        on_timer = function(pos, elapsed)

            local pos_below = {x = pos.x, y = pos.y - 1, z = pos.z}
            local node_below = core.get_node(pos_below)

            if node_below.name ~= "ignore" then

                unilib.pkg.shared_ropes.destroy_rope(
                    pos_below,
                    {
                        "unilib:ladder_rope",
                        "unilib:ladder_rope_bottom",
                        "unilib:ladder_rope_falling",
                    }
                )

                core.swap_node(pos, {name = "air"})

            else

                local timer = core.get_node_timer(pos)
                timer:start(1)

            end

        end,
    })

end
