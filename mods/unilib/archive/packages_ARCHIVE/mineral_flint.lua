---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    fire
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("default:flint", {
    description = S("Flint"),
    inventory_image = "default_flint.png"
})

minetest.register_tool("fire:flint_and_steel", {
    description = S("Flint and Steel"),
    inventory_image = "fire_flint_steel.png",
    sound = {breaks = "default_tool_breaks"},

    on_use = function(itemstack, user, pointed_thing)
        local sound_pos = pointed_thing.above or user:get_pos()
        minetest.sound_play("fire_flint_and_steel",
            {pos = sound_pos, gain = 0.5, max_hear_distance = 8}, true)
        local player_name = user:get_player_name()
        if pointed_thing.type == "node" then
            local node_under = minetest.get_node(pointed_thing.under).name
            local nodedef = minetest.registered_nodes[node_under]
            if not nodedef then
                return
            end
            if minetest.is_protected(pointed_thing.under, player_name) then
                minetest.chat_send_player(player_name, "This area is protected")
                return
            end
            if nodedef.on_ignite then
                nodedef.on_ignite(pointed_thing.under, user)
            elseif minetest.get_item_group(node_under, "flammable") >= 1
                    and minetest.get_node(pointed_thing.above).name == "air" then
                minetest.set_node(pointed_thing.above, {name = "fire:basic_flame"})
            end
        end
        if not minetest.is_creative_enabled(player_name) then
            -- Wear tool
            local wdef = itemstack:get_definition()
            itemstack:add_wear(1000)

            -- Tool break sound
            if itemstack:get_count() == 0 and wdef.sound and wdef.sound.breaks then
                minetest.sound_play(wdef.sound.breaks,
                    {pos = sound_pos, gain = 0.5}, true)
            end
            return itemstack
        end
    end
})
minetest.register_craft({
    output = "fire:flint_and_steel",
    recipe = {
        {"default:flint", "default:steel_ingot"}
    }
})
]]--

--[[
minetest.register_node("mtg_plus:flint_block", {
	description = S("Flint Block"),
	_doc_items_longdesc = deco,
	tiles = {"mtg_plus_flint_block.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "mtg_plus:flint_block",
	recipe = {
		{ "default:flint", "default:flint", "default:flint" },
		{ "default:flint", "default:flint", "default:flint" },
		{ "default:flint", "default:flint", "default:flint" },
	}
})
minetest.register_craft({
	output = "default:flint 9 ",
	recipe = {
		{ "mtg_plus:flint_block" },
	}
})
stairs.register_slab("flint_block", "mtg_plus:flint_block", {cracky=2}, {"mtg_plus_flint_block.png", "mtg_plus_flint_block.png", "mtg_plus_flint_block_slab.png", "mtg_plus_flint_block_slab.png", "mtg_plus_flint_block_slab.png", "mtg_plus_flint_block_slab.png"}, S("Flint Block Slab"), minetest.registered_items["mtg_plus:flint_block"].sounds)
stairs.register_stair("flint_block", "mtg_plus:flint_block", {cracky=2}, {"mtg_plus_flint_block_slab.png", "mtg_plus_flint_block.png", "mtg_plus_flint_block_stair1.png", "mtg_plus_flint_block_stair2.png", "mtg_plus_flint_block.png", "mtg_plus_flint_block_slab.png"}, S("Flint Block Stair"), minetest.registered_items["mtg_plus:flint_block"].sounds)
]]--
