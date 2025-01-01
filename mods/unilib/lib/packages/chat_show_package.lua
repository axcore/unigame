---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_show_package = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_show_package.init()

    return {
        description = "Chat command /show_package",
        notes = "Shows the unilib package that created a node, craftitem or tool",
    }

end

function unilib.pkg.chat_show_package.exec()

    core.register_chatcommand("show_package", {
        params = "<item> ",
        description = S("Shows the unilib package that created a node, craftitem or tool"),
        privs = {unilib_tools = true},

        func = function(name, param)

            if param == nil or param == "" then
                return false, S("Show the parent package of which node, craftitem or tool?")
            end

            local mod_name = unilib.utils.get_mod_name(param)
            if mod_name ~= "unilib" then

                return false, S("This command can only show unilib items")

            elseif unilib.global.node_parent_table[param] ~= nil then

                return true, S(
                    "The node \"@1\" was created by the package \"@2\"",
                    param,
                    unilib.global.node_parent_table[param]
                )

            elseif unilib.global.craftitem_parent_table[param] ~= nil then

                return true, S(
                    "The craftitem \"@1\" was created by the package \"@2\"",
                    param,
                    unilib.global.craftitem_parent_table[param]
                )

            elseif unilib.global.tool_parent_table[param] ~= nil then

                return true, S(
                    "The tool \"@1\" was created by the package \"@2\"",
                    param,
                    unilib.global.tool_parent_table[param]
                )

            else

                return false, S("The parent package of this item is unknown")

            end

        end,
    })

end
