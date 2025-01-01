---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_show_inventory = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_show(name, param)

    if not core.get_player_by_name(name) then
        return false, unilib.constant.chat_offline_msg
    end

    local count = 0
    local inv = core.get_inventory({type = "player", name = name})
    local inv_dict = inv:get_lists()

    unilib.utils.chat_send_player(name, S("Current inventory"))

    for key, mini_list in pairs(inv_dict) do

        unilib.utils.chat_send_player(name, "  " .. key)
        for _, itemstack in ipairs(mini_list) do

            if itemstack:get_name() ~= "" then

                count = count + 1
                if itemstack:get_count() > 1 then

                    unilib.utils.chat_send_player(
                        name,
                        "    " .. itemstack:get_name() .. " " .. itemstack:get_count()
                    )

                else

                    unilib.utils.chat_send_player(name, "    " .. itemstack:get_name())

                end

            end

        end

    end

    unilib.utils.chat_send_player(name, S("End of list (occupied inventory slots: @1)", count))

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_show_inventory.init()

    return {
        description = "Chat commands /show_inventory, /inventory, /inv",
        notes = "Displays the player's current inventory",
    }

end

function unilib.pkg.chat_show_inventory.exec()

    core.register_chatcommand("show_inventory", {
        params = "",
        description = S("Displays your current inventory"),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_show(name, param)
        end,
    })

    core.register_chatcommand("inventory", {
        params = "",
        description = S("Displays your current inventory"),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_show(name, param)
        end,
    })

    core.register_chatcommand("inv", {
        params = "",
        description = S("Displays your current inventory"),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_show(name, param)
        end,
    })

end
