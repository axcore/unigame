---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    keys
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_key_skeleton = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.keys.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_key_skeleton.init()

    return {
        description = "Skeleton key",
        notes = "Punch a locked door (etc) to turn the skeleton key into an ordinary key, that" ..
                " only unlocks that door",
        depends = {"item_key_ordinary",  "metal_gold"},
    }

end

function unilib.pkg.item_key_skeleton.exec()

    -- (Note that keys were moved from minetest_game/default to minetest_game/keys in 2022)
    unilib.register_craftitem(
        -- From default:skeleton_key
        "unilib:item_key_skeleton",
        {"default:skeleton_key", "keys:skeleton_key"},
        mode,
        {
            description = S("Skeleton Key"),
            inventory_image = "unilib_item_key_skeleton.png",

            on_use = function(itemstack, user, pointed_thing)

                if pointed_thing.type ~= "node" then
                    return itemstack
                end

                local pos = pointed_thing.under
                local node = core.get_node(pos)

                if not node then
                    return itemstack
                end

                local node_reg = core.registered_nodes[node.name]
                local on_skeleton_key_use = node_reg and node_reg.on_skeleton_key_use
                if not on_skeleton_key_use then
                    return itemstack
                end

                -- Make a new key secret in case the node callback needs it
                local random = math.random
                local newsecret = string.format(
                    "%04x%04x%04x%04x",
                    random(2^16) - 1,
                    random(2^16) - 1,
                    random(2^16) - 1,
                    random(2^16) - 1
                )

                local secret, _, _ = on_skeleton_key_use(pos, user, newsecret)

                if secret then

                    local inv = core.get_inventory({type = "player", name = user:get_player_name()})

                    -- Update the original itemstack
                    itemstack:take_item()

                    -- Finish and return the new key
                    local new_stack = ItemStack("unilib:item_key_ordinary")
                    local meta = new_stack:get_meta()
                    meta:set_string("secret", secret)
                    meta:set_string(
                        "description",
                        S("Key to @1's @2",
                        user:get_player_name(),
                        core.registered_nodes[node.name].description)
                    )

                    if itemstack:get_count() == 0 then

                        itemstack = new_stack

                    else

                        -- If not added to inventory successfully...
                        if inv:add_item("main", new_stack):get_count() > 0 then
                            core.add_item(user:get_pos(), new_stack)
                        end

                    end

                    return itemstack

                end
            end
        }
    )
    unilib.register_craft({
        -- From default:skeleton_key
        output = "unilib:item_key_skeleton",
        recipe = {
            {"unilib:metal_gold_ingot"},
        },
    })
    unilib.register_craft({
        -- From default:gold_ingot
        type = "cooking",
        output = "unilib:metal_gold_ingot",
        recipe = "unilib:item_key_skeleton",

        cooktime = 5,
    })

end
