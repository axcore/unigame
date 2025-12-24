---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPLv2
-- Media:   CC-0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_update_slope = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.naturalslopeslib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_update_slope.init()

    return {
        description = "Chat command /update_slope",
        notes = "Updates the shape of a slope node at the player's current position",
    }

end

function unilib.pkg.chat_update_slope.exec()

    core.register_chatcommand("update_slope", {
        params = "",
        description = S("Updates the shape of a slope node at the player's current position"),
        privs = {unilib_admin = true},

        func = function(pname, param)

            local player = core.get_player_by_name(pname)
            if not player then
                return false, S("Player not found")
            end

            local pos = player:get_pos()
            local node_pos = {x = pos.x, y = pos.y - 1, z = pos.z}
            local node = core.get_node(node_pos)

            if unilib.slopes.update_shape(node_pos, node) then
                return true, S("Slope shape updated")
            else
                return false, S("@1 cannot have its shape updated", node.name)
            end

        end,
    })

end
