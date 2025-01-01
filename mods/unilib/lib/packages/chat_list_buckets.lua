---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_list_buckets = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_list_buckets(pname, param)

    if unilib.utils.is_table_empty(unilib.global.generic_bucket_table) then

        return false, S("No bucket types have been loaded")

    elseif param ~= nil and param ~= "" then

        -- Ignore multiple bucket types, if specified
        local bucket_list = unilib.utils.split_string_by_whitespace(param)
        local bucket_type = bucket_list[1]

        if bucket_type == nil or
                bucket_type == "" or
                unilib.global.generic_bucket_table[bucket_type] == nil then

            return false, S("Unrecognised bucket type, try /list_buckets")

        else

            local craftitem_list = {}

            local empty_name = "unilib:" .. bucket_type .. "_empty"
            if core.registered_craftitems[empty_name] ~= nil then
                table.insert(craftitem_list, empty_name)
            end

            for liquid_type, _ in pairs(unilib.global.generic_liquid_table) do

                local filled_name = "unilib:" .. bucket_type .. "_with_" .. liquid_type
                if core.registered_craftitems[filled_name] ~= nil then
                    table.insert(craftitem_list, filled_name)
                end

            end

            if #craftitem_list == 0 then

                return false, S("No buckets found for this bucket type")

            else

                table.sort(craftitem_list)

                unilib.utils.chat_send_player(pname, S("Bucket type \"@1\"", bucket_type))

                for _, full_name in ipairs(craftitem_list) do
                    unilib.utils.chat_send_player(pname, "   " .. full_name)
                end

                unilib.utils.chat_send_player(
                    pname, S("End of list (buckets found: @1)", #craftitem_list)
                )

            end

        end

    else

        local bucket_list = {}
        for k, _ in pairs(unilib.global.generic_bucket_table) do
            table.insert(bucket_list, k)
        end

        table.sort(bucket_list)

        unilib.utils.chat_send_player(pname, S("List of bucket types"))
        for _, bucket_type in ipairs(bucket_list) do

            local mini_table = unilib.global.generic_bucket_table[bucket_type]
            unilib.utils.chat_send_player(
                pname, "   " .. bucket_type .. " [" .. mini_table.description .. "]"
            )

        end

        unilib.utils.chat_send_player(
            pname, S("End of list (bucket types found: @1)", #bucket_list)
        )

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_list_buckets.init()

    return {
        description = "Chat commands /list_buckets, /list_bucket",
        notes = "Lists bucket types, or a list of buckets of the specified type",
    }

end

function unilib.pkg.chat_list_buckets.exec()

    core.register_chatcommand("list_buckets", {
        params = "",
        description = S("Lists bucket types, or a list of buckets of the specified type"),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_buckets(name, param)
        end,
    })

    core.register_chatcommand("list_bucket", {
        params = "",
        description = S("Lists bucket types, or a list of buckets of the specified type"),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_buckets(name, param)
        end,
    })

end
