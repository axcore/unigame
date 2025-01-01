---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    fireflies
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_net_bug = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.fireflies.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_net_bug.init()

    return {
        description = "Bug net",
        notes = "Catches anything in the \"catchable\" group, including butterflies and fireflies",
        depends = "item_string_ordinary",
    }

end

function unilib.pkg.item_net_bug.exec()

    unilib.register_tool("unilib:item_net_bug", "fireflies:bug_net", mode, {
        -- From fireflies:bug_net
        description = S("Bug Net"),
        inventory_image = "unilib_item_net_bug.png",
        pointabilities = {nodes = {["group:catchable"] = true}},

        --[[
        on_use = function(itemstack, player, pointed_thing)

            local player_name = player and player:get_player_name() or ""
            if not pointed_thing or pointed_thing.type ~= "node" or
                    core.is_protected(pointed_thing.under, player_name) then
                return
            end

            local node_name = core.get_node(pointed_thing.under).name
            local inv = player:get_inventory()
            if core.get_item_group(node_name, "catchable") == 1 then

                core.remove_node(pointed_thing.under)
                local stack = ItemStack(node_name .. " 1")
                local leftover = inv:add_item("main", stack)
                if leftover:get_count() > 0 then
                    core.add_item(pointed_thing.under, node_name .. " 1")
                end

            end

            if not unilib.utils.is_creative(player_name) then

                itemstack:add_wear_by_uses(256)
                return itemstack

            end

        end,
        ]]--

        tool_capabilities = {
            groupcaps = {
                catchable = { maxlevel = 1, uses = 256, times = { [1] = 0, [2] = 0, [3] = 0 } },
            },
        },
    })
    unilib.register_craft( {
        -- From fireflies:bug_net
        output = "unilib:item_net_bug",
        recipe = {
            {"unilib:item_string_ordinary", "unilib:item_string_ordinary"},
            {"unilib:item_string_ordinary", "unilib:item_string_ordinary"},
            {"group:stick", ""},
        },
    })
    unilib.tools.register_no_repair("unilib:item_net_bug", S("This net cannot be repaired"))

end
