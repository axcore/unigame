---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    fireflies
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_firefly = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.fireflies.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_firefly.init()

    return {
        description = "Fireflies",
        notes = "Only visible at night. Can be caught with a bug net and placed in a bottle to" ..
                " create a light source",
    }

end

function unilib.pkg.misc_firefly.exec()

    -- Register nodes
    unilib.register_node("unilib:misc_firefly", "fireflies:firefly", mode, {
        -- From fireflies:firefly
        description = S("Firefly"),
        tiles = {{
            name = "unilib_misc_firefly_animated.png",
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 1.5
            },
        }},
        groups = {catchable = 1},
        -- (no sounds)

        buildable_to = true,
        drawtype = "plantlike",
        floodable = true,
        inventory_image = "unilib_misc_firefly.png",
        light_source = 6,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_misc_firefly.png",

        on_place = function(itemstack, placer, pointed_thing)

            local player_name = placer:get_player_name()
            local pos = pointed_thing.above

            if not minetest.is_protected(pos, player_name) and
                    not minetest.is_protected(pointed_thing.under, player_name) and
                    minetest.get_node(pos).name == "air" then

                minetest.set_node(pos, {name = "unilib:misc_firefly"})
                minetest.get_node_timer(pos):start(1)
                itemstack:take_item()

            end

            return itemstack

        end,

        on_timer = function(pos, elapsed)

            if minetest.get_node_light(pos) > 11 then
                minetest.set_node(pos, {name = "unilib:misc_firefly_hidden"})
            end
            minetest.get_node_timer(pos):start(30)

        end
    })

    unilib.register_node("unilib:misc_firefly_hidden", "fireflies:hidden_firefly", mode, {
        -- From fireflies:hidden_firefly
        description = S("Hidden Firefly"),
        -- (no tiles)
        groups = {not_in_creative_inventory = 1},
        -- (no sounds)

        buildable_to = true,
        diggable = false,
        drawtype = "airlike",
        drop = "",
        floodable = true,
        inventory_image = "unilib_misc_firefly.png^unilib_invisible_node_overlay.png",
        paramtype = "light",
        pointable = false,
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_misc_firefly.png^unilib_invisible_node_overlay.png",

        on_place = function(itemstack, placer, pointed_thing)

            local player_name = placer:get_player_name()
            local pos = pointed_thing.above

            if not minetest.is_protected(pos, player_name) and
                    not minetest.is_protected(pointed_thing.under, player_name) and
                    minetest.get_node(pos).name == "air" then

                minetest.set_node(pos, {name = "unilib:misc_firefly_hidden"})
                minetest.get_node_timer(pos):start(1)
                itemstack:take_item()

            end

            return itemstack

        end,

        on_timer = function(pos, elapsed)

            if minetest.get_node_light(pos) <= 11 then
                minetest.set_node(pos, {name = "unilib:misc_firefly"})
            end
            minetest.get_node_timer(pos):start(30)

        end
    })

    -- Register decorations
    unilib.register_decoration("fireflies_misc_firefly", {
        -- From fireflies/init.lua
        deco_type = "simple",
        decoration = "unilib:misc_firefly",

        fill_ratio = 0.0005,
        place_offset_y = 2,
        sidelen = 80,
    })

    unilib.register_decoration("fireflies_misc_firefly_hidden", {
        -- From fireflies/init.lua
        deco_type = "simple",
        decoration = "unilib:misc_firefly_hidden",

        fill_ratio = 0.0005,
        place_offset_y = 3,
        sidelen = 80,
    })

end

function unilib.pkg.misc_firefly.post()

    -- Depending on whether any firefly decorations are added, set up the nodetimers

    -- Get decoration ID
    local fireflies = minetest.get_decoration_id("unilib:misc_firefly")
    local fireflies_hidden = minetest.get_decoration_id("unilib:misc_firefly_hidden")
    if fireflies ~= nil then

        minetest.set_gen_notify({decoration = true}, {fireflies, fireflies_hidden})

        -- Start nodetimers to convert fireflies (at night) into hidden fireflies (during the
        --      day)
        minetest.register_on_generated(function(minp, maxp, blockseed)

            local gennotify = minetest.get_mapgen_object("gennotify")
            local poslist = {}

            for _, pos in ipairs(gennotify["decoration#" .. fireflies] or {}) do

                local fireflies_pos = {x = pos.x, y = pos.y + 3, z = pos.z}
                table.insert(poslist, fireflies_pos)

            end

            for _, pos in ipairs(gennotify["decoration#" .. fireflies_hidden] or {}) do

                local fireflies_hidden_pos = {x = pos.x, y = pos.y + 4, z = pos.z}
                table.insert(poslist, fireflies_hidden_pos)

            end

            if #poslist ~= 0 then

                for i = 1, #poslist do

                    local pos = poslist[i]
                    minetest.get_node_timer(pos):start(1)

                end

            end

        end)

    end

end
