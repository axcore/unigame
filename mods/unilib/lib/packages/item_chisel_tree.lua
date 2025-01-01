---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    stripped_tree
-- Code:    GPLv3.0
-- Media:   GPLv3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_chisel_tree = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.stripped_tree.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_chisel_tree.init()

    return {
        description = "Tree chisel",
        notes = "Used to strip the bark from compatible tree trunks. Does not work on bamboo," ..
                " fern or mushroom trees",
        depends = {"item_bark_tree", "item_screwdriver_ordinary", "metal_steel"},
    }

end

function unilib.pkg.item_chisel_tree.exec()

    local c_bark = "unilib:item_bark_tree"

    unilib.register_tool("unilib:item_chisel_tree", "stripped_tree:chisel", mode, {
        -- From stripped_tree:chisel
        description = S("Tree Chisel"),
        inventory_image = "unilib_item_chisel_tree.png",
        -- (no groups)
        sound = {breaks = "unilib_tool_breaks"},

        stack_max = 1,
        wield_image = "unilib_item_chisel_tree.png",

        on_use = function(itemstack, user, pointed_thing)

            if pointed_thing.type ~= "node" then
                return
            end

            local pos = pointed_thing.under
            local pname = user:get_player_name()

            if core.is_protected(pos, pname) then

                core.record_protection_violation(pos, pname)
                return

            end

            local trunk_name = core.get_node(pos).name
            local stripped_name = trunk_name .. "_stripped"

            if core.registered_nodes[stripped_name] then

                core.swap_node(pos, {name = stripped_name})

                if not unilib.utils.is_creative(user:get_player_name()) then

                    local inv = user:get_inventory()
                    -- Check for room in inventory, if not, drop item
                    if inv:room_for_item("main", c_bark) then
                        inv:add_item("main", {name = c_bark})
                    else
                        core.add_item(pos, c_bark)
                    end

                    -- 300 uses
                    itemstack:add_wear(unilib.constant.max_tool_wear / 299)

                end

                return itemstack

            end

        end,
    })
    unilib.register_craft({
        -- From stripped_tree:chisel
        output = "unilib:item_chisel_tree",
        recipe = {
            {"", "unilib:metal_steel_ingot", ""},
            {"", "unilib:item_screwdriver_ordinary", ""},
            {"", "", ""},
        },
    })

end
