---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_rooted_spider = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

--[[
local function on_place_coral(itemstack, placer, pointed_thing)

    return unilib.pkg.shared_xocean.on_place(
        itemstack, placer, pointed_thing,
        "spider",
        "unilib:coral_block_skeleton"
    )

end

local function on_place_skeleton(itemstack, placer, pointed_thing)

    return unilib.pkg.shared_xocean.on_place(
        itemstack, placer, pointed_thing,
        "spider_skeleton",
        "unilib:coral_block_skeleton"
    )

end
]]--

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_rooted_spider.init()

    return {
        description = "Rooted spider coral",
        depends = {"coral_block_skeleton", "liquid_water_ordinary"},
    }

end

function unilib.pkg.coral_rooted_spider.exec()

    -- N.B. This item has numerous problems. Rewrote the code to match corals from xocean, which
    --      solves the problems

    --[[
    unilib.register_node("unilib:coral_rooted_spider", "lib_ecology:coral_purple", mode, {
        -- From GLEMr11, lib_ecology:coral_purple
        description = S("Rooted Spider Coral"),
        tiles = {"unilib_coral_rooted_spider.png"},
        groups = {sea = 1, snappy = 3},
        sounds = unilib.global.sound_table.stone,

        buildable_to = false,
        drawtype = "plantlike_rooted",
        inventory_image = "unilib_coral_rooted_spider.png",
        is_ground_content = false,
        node_dig_prediction = "unilib:coral_rooted_spider",
        node_placement_prediction = "unilib:coral_rooted_spider",
        paramtype = "light",
        special_tiles = {
            {
                name = "unilib_coral_rooted_spider.png",
                tileable_vertical = false,
            },
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_coral_rooted_spider.png",

        after_destruct = function(pos, oldnode)
            core.set_node(pos, {name = "unilib:coral_block_skeleton"})
        end,

        on_place = function(itemstack, placer, pointed_thing)

            if pointed_thing.type ~= "node" or not placer then
                return itemstack
            end

            local player_name = placer:get_player_name()
            local pos_under = pointed_thing.under
            local pos_above = pointed_thing.above

            if core.get_node(pos_under).name ~= "unilib:coral_block_skeleton" or
                    core.get_node(pos_above).name ~= "unilib:liquid_water_ordinary_source" then
                return itemstack
            end

            if core.is_protected(pos_under, player_name) or
                    core.is_protected(pos_above, player_name) then

                core.chat_send_player(player_name, S("Node is protected"))
                core.record_protection_violation(pos_under, player_name)
                return itemstack

            end

            core.set_node(pos_under, {name = "unilib:coral_rooted_spider"})
            if not (creative and creative.is_enabled_for(player_name)) then
                itemstack:take_item()
            end

            return itemstack
        end,
    })
    ]]--

    local img = "unilib_coral_block_skeleton.png"
    if unilib.setting.mtgame_tweak_flag then
        img = "unilib_coral_block_skeleton_farlands.png"
    end

    unilib.register_node("unilib:coral_rooted_spider", "lib_ecology:coral_purple", mode, {
        -- From GLEMr11, lib_ecology:coral_purple
        description = S("Rooted Spider Coral"),
        tiles = {img},
        -- N.B. No coral = 1 in original code
        groups = {coral = 1, snappy = 3},
        sounds = unilib.sound.generate_stone({
            dig = {name = "unilib_dig_snappy", gain = 0.2},
            dug = {name = "unilib_grass_footstep", gain = 0.25},
        }),

        drawtype = "plantlike_rooted",
        drop = "unilib:coral_rooted_spider_skeleton",
        inventory_image = "unilib_coral_rooted_spider.png",
        node_dig_prediction = "unilib:coral_block_skeleton",
        node_placement_prediction = "",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
                {-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
            },
        },
        special_tiles = {
            {name = "unilib_coral_rooted_spider.png", tileable_vertical = false},
        },
        waving = 1,

        after_destruct = function(pos, oldnode)
            core.set_node(pos, {name = "unilib:coral_block_skeleton"})
        end,

--      on_place = on_place_coral,
        on_place = function(itemstack, placer, pointed_thing)

            return unilib.misc.place_in_medium(
                itemstack, placer, pointed_thing,
                {
                    need_under = "unilib:coral_block_skeleton",
                    displace_flag = true,
                }
            )

        end,
    })

    unilib.register_node("unilib:coral_rooted_spider_skeleton", nil, mode, {
        -- Original to unilib, adapted from xocean:skeleton_fire
        description = S("Rooted Spider Coral Skeleton"),
        tiles = {img},
        groups = {coral = 1, snappy = 3},
        sounds = unilib.sound.generate_stone({
            dig = {name = "unilib_dig_snappy", gain = 0.2},
            dug = {name = "unilib_grass_footstep", gain = 0.25},
        }),

        drawtype = "plantlike_rooted",
        inventory_image = "unilib_coral_rooted_spider_skeleton.png",
        node_dig_prediction = "unilib:coral_block_skeleton",
        node_placement_prediction = "",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
                {-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
            },
        },
        special_tiles = {
            {name = "unilib_coral_rooted_spider_skeleton.png", tileable_vertical = true},
        },
        waving = 1,

        after_destruct = function(pos, oldnode)
            core.set_node(pos, {name = "unilib:coral_block_skeleton"})
        end,

--      on_place = on_place_coral,
        on_place = function(itemstack, placer, pointed_thing)

            return unilib.misc.place_in_medium(
                itemstack, placer, pointed_thing,
                {
                    need_under = "unilib:coral_block_skeleton",
                    displace_flag = true,
                }
            )

        end,
    })

end
