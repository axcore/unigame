---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    maptools
-- Code:    zlib
-- Media:   zlib
---------------------------------------------------------------------------------------------------

unilib.pkg.admin_tool_pick = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.maptools.add_mode

local toolcaps_table = {
    damage_groups = {fleshy = 1000},
    full_punch_interval = 0.1,
    groupcaps = {
        bendy = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 5},
        choppy = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 5},
        cracky = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 5},
        crumbly = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 5},
        fleshy = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 5},
        snappy = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 5},
        unbreakable = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 5},
    },
    max_drop_level = 3,
}

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.admin_tool_pick.init()

    return {
        description = "Admin pickaxe",
        notes = "A pickaxe that can dig (almost) anything, including many \"admin\" nodes that" ..
                " are otherwise undiggable",
        depends = "shared_maptools",
    }

end

function unilib.pkg.admin_tool_pick.exec()

    -- Admin pickaxes for breaking maptools nodes
    unilib.register_tool("unilib:admin_tool_pick_without_drop", "maptools:pick_admin", mode, {
        -- From maptools:pick_admin
        description = unilib.utils.hint(S("Admin Pickaxe"), S("without drops")),
        inventory_image = "unilib_admin_tool_pick_without_drop.png",
        groups = {not_in_creative_inventory = unilib.globalshow_admin_item_group},
        -- (no sounds)

        range = 20,
        tool_capabilities = unilib.pkg.shared_maptools.toolcaps_table,

        on_drop = unilib.pkg.shared_maptools.on_drop,
    })

    unilib.register_tool(
        -- From maptools:pick_admin_with_drops
        "unilib:admin_tool_pick_with_drop",
        "maptools:pick_admin_with_drops",
        mode,
        {
            description = unilib.utils.hint(S("Admin Pickaxe"), S("with drops")),
            inventory_image = "unilib_admin_tool_pick_with_drop.png",
            groups = {not_in_creative_inventory = unilib.globalshow_admin_item_group},
            -- (no sounds)

            range = 20,
            tool_capabilities = unilib.pkg.shared_maptools.toolcaps_table,

            on_drop = unilib.pkg.shared_maptools.on_drop,
        }
    )

    core.register_on_punchnode(function(pos, node, puncher)

        if (
            puncher:get_wielded_item():get_name() == "unilib:admin_tool_pick_without_drop" or
            puncher:get_wielded_item():get_name() == "unilib:admin_tool_pick_with_drop"
        ) and core.get_node(pos).name ~= "air" then

            --[[
            unilib.utils.log(
                "action",
                puncher:get_player_name() ..
                " digs " ..
                core.get_node(pos).name ..
                " at " ..
                core.pos_to_string(pos) ..
                " using an Admin Pickaxe."
            )
            ]]--
            unilib.utils.log_player_action(
                puncher,
                "digs",
                core.get_node(pos).name,
                "at",
                core.pos_to_string(pos),
                "using an Admin Pickaxe"
            )

            -- The node is removed directly, which means it even works on non-empty containers and
            --      group-less nodes
            core.remove_node(pos)
            -- Run node update actions like falling nodes
            core.check_for_falling(pos)

        end

    end)

end
