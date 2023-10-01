---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_key_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_key_ordinary.init()

    return {
        description = "Ordinary key",
        notes = "Created from an ordinary skeleton key",
        depends = "metal_gold",
    }

end

function unilib.pkg.item_key_ordinary.exec()

    -- ("default:key" is already aliased on to "keys:key" by something; maybe in the engine? Anyway,
    --      we need to un-alias it to prevent a warning in debug.txt)
    minetest.registered_aliases["default:key"] = nil

    unilib.register_tool("unilib:item_key_ordinary", {"default:key", "keys:key"}, mode, {
        -- From default:key
        description = S("Ordinary Key"),
        inventory_image = "unilib_item_key_ordinary.png",
        groups = {key = 1, not_in_creative_inventory = 1},

        stack_max = 1,

        on_place = function(itemstack, placer, pointed_thing)

            local under = pointed_thing.under
            local node = minetest.get_node(under)
            local def = minetest.registered_nodes[node.name]

            if def and def.on_rightclick and not (
                placer and placer:is_player() and
                placer:get_player_control().sneak
            ) then
                return def.on_rightclick(under, node, placer, itemstack, pointed_thing) or itemstack
            end

            if pointed_thing.type ~= "node" then
                return itemstack
            end

            local pos = pointed_thing.under
            node = minetest.get_node(pos)

            if not node or node.name == "ignore" then
                return itemstack
            end

            local ndef = minetest.registered_nodes[node.name]
            if not ndef then
                return itemstack
            end

            local on_key_use = ndef.on_key_use
            if on_key_use then
                on_key_use(pos, placer)
            end

            return nil

        end
    })
    unilib.register_craft({
        -- From default:gold_ingot
        type = "cooking",
        output = "unilib:metal_gold_ingot",
        recipe = "unilib:item_key_ordinary",

        cooktime = 5,
    })

end
