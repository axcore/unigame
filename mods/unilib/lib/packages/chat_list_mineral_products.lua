---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_list_mineral_products = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_list_mineral_products(pname, param)

    local product_table = {}
    local missing_table = {}

    for part_name, data_table in pairs(unilib.global.mineral_table) do

        local mini_list = {}
        for i, item_name in ipairs(data_table.metal_list) do
            table.insert(mini_list, item_name)
        end

        for i, item_name in ipairs(data_table.non_metal_list) do
            table.insert(mini_list, item_name)
        end

        product_table[part_name] = mini_list

    end

    if unilib.utils.is_table_empty(product_table) then

        return false, S("No minerals are registered")

    else

        local product_list = {}
        for k, _ in pairs(product_table) do
            table.insert(product_list, k)
        end

        unilib.utils.chat_send_player(
            pname,
            S("List of registered mineral products (m = metal, n = non-metal, * = unrecognised)")
        )

        table.sort(product_list)
        for _, mineral_name in ipairs(product_list) do

            local item_list = product_table[mineral_name]
            table.sort(item_list)

            local mod_item_list = {}
            for i, item_name in ipairs(item_list) do

                if unilib.global.metal_table[item_name] ~= nil then

                    mod_item_list[i] = "<m> " .. item_name

                elseif unilib.global.non_metal_table[item_name] ~= nil then

                    mod_item_list[i] = "<n> " .. item_name

                else

                    mod_item_list[i] = "*   " .. item_name
                    missing_table[item_name] = true

                end
            end

            unilib.utils.chat_send_player(pname, "   " .. mineral_name)
            if not next(mod_item_list) then
                unilib.utils.chat_send_player(pname, "      (no products)")
            else
                unilib.utils.chat_send_player(pname, "      " .. table.concat(mod_item_list, ", "))
            end

        end

        unilib.utils.chat_send_player(
            pname, S("End of list (mineral products found: @1)", #product_list)
        )

        if not unilib.utils.is_table_empty(missing_table) then

            local missing_list = {}
            for k, _ in pairs(missing_table) do
                table.insert(missing_list, k)
            end

            unilib.utils.chat_send_player(pname, S("Unregistered metals/elemental non-metals:"))

            table.sort(missing_list)
            for _, item_name in ipairs(missing_list) do
                unilib.utils.chat_send_player(pname, "   " .. item_name)
            end

            unilib.utils.chat_send_player(
                pname, S("End of list (unregistered products found: @1)", #missing_list)
            )

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_list_mineral_products.init()

    return {
        description = "Chat commands /list_mineral_products, /list_mineral_product",
        notes = "Lists all metals/elemental non-metals produced by minerals",
    }

end

function unilib.pkg.chat_list_mineral_products.exec()

    core.register_chatcommand("list_mineral_products", {
        params = "",
        description = S("Lists all metals/elemental non-metals produced by minerals"),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_mineral_products(name, param)
        end,
    })

    core.register_chatcommand("list_mineral_product", {
        params = "",
        description = S("Lists all metals/elemental non-metals produced by minerals"),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_mineral_products(name, param)
        end,
    })

end
