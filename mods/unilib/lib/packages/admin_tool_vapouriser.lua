---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.admin_tool_vapouriser = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.admin_tool_vapouriser.init()

    return {
        description = "Admin vapouriser",
        notes = "Replaces the node directly above the pointed node with air. Useful for removing" ..
                " invisible, unpointable nodes (such as invisible light sources)",
        depends = "shared_maptools",
    }

end

function unilib.pkg.admin_tool_vapouriser.exec()

    unilib.register_tool("unilib:admin_tool_vapouriser", nil, mode, {
        -- Original to unilib
        description = unilib.utils.hint(S("Admin Vapouriser"), S("removes invisible nodes")),
        inventory_image = "unilib_admin_tool_vapouriser.png",
        groups = {not_in_creative_inventory = unilib.globalshow_admin_item_group},
        -- (no sounds)

        range = 20,
        -- N.B. no .tool_capabilities, so that the node above is the one removed

        on_drop = unilib.pkg.shared_maptools.on_drop,
    })

    core.register_on_punchnode(function(pos, node, puncher)

        local above_pos = {x = pos.x, y = pos.y + 1, z = pos.z}

        if (puncher:get_wielded_item():get_name() == "unilib:admin_tool_vapouriser") and
                core.get_node(pos).name ~= "air" and
                core.get_node(above_pos).name ~= "air" then

            --[[
            unilib.utils.log(
                "action",
                puncher:get_player_name() ..
                " vapourises " ..
                core.get_node(above_pos).name ..
                " at " ..
                core.pos_to_string(pos) ..
                " using an Admin Vapouriser."
            )
            ]]--
            unilib.utils.log_player_action(
                puncher,
                "vapourises",
                core.get_node(above_pos).name,
                "at",
                pos,
                "using an Admin Vapouriser"
            )

            -- The node is removed directly, which means it even works on non-empty containers and
            --      group-less nodes
            core.remove_node(above_pos)
            -- Run node update actions like falling nodes
            core.check_for_falling(above_pos)

        end

    end)

end
