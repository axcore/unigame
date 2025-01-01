---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.admin_tool_tester_general = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local function
---------------------------------------------------------------------------------------------------

local function use_tool(itemstack, user, pointed_thing)

    local pos = core.get_pointed_thing_position(pointed_thing)
    local node = core.get_node(pos)

    -- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    -- =                                ADD YOUR CODE HERE
    -- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

--  unilib.utils.log(node.name .. ", x: " .. pos.x .. " y: " .. pos.y .. " z: " .. pos.z)





    -- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.admin_tool_tester_general.init()

    return {
        description = "Admin general tester",
        notes = "A tool which is used to run some arbitrary code at the punched position. By" ..
                " default, the tool does nothing; the user must add their code to the" ..
                " \"admin_tool_tester_general\" package",
        depends = "shared_maptools",
    }

end

function unilib.pkg.admin_tool_tester_general.exec()

    unilib.register_tool("unilib:admin_tool_tester_general", nil, mode, {
        -- Original to unilib
        description = unilib.utils.hint(S("Admin General Tester"), S("runs arbitrary code")),
        inventory_image = "unilib_admin_tool_tester_general.png",
        groups = {not_in_creative_inventory = unilib.globalshow_admin_item_group},
        -- (no sounds)

        -- In case this tester must store information in metadata, only one can be stacked
        stack_max = 1,
        range = 20,
        tool_capabilities = unilib.pkg.shared_maptools.toolcaps_table,

        on_use = function(itemstack, user, pointed_thing)

            if user == nil or pointed_thing == nil then
                return nil
            end

            if pointed_thing.type ~= "node" then
                return nil
            end

            use_tool(itemstack, user, pointed_thing)

        end,
    })

end
