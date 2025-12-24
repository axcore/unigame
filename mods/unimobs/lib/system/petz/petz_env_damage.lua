---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- petz_env_damage.lua
--      Shared API functions from the petz/petz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/api/api_env_damage.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.apply_env_damage(self, entity_pos, priority)

    -- From petz.env_damage()
    -- Called by numerous brain packages
    -- Applies environmental damage to the specified mob
    -- Damage is caused to all mobs by fire, lava and other igniters. Damage will also be caused to
    --      any mobs for which the remix CSV has specified one or more harmful nodes

    local stand_pos = unimobs.mobkit_api.get_standing_pos(self)
    if not stand_pos then
        return
    end

    local entity_node = core.get_node_or_nil(entity_pos)
    local stand_node_pos = unimobs.mobkit_api.get_pos_of_node_centre(stand_pos)
    local stand_node = unimobs.mobkit_api.get_node_defn_at_pos(stand_node_pos)

    -- Apply damage from fire, lava or other igniters (unless immune)
    if not self.igniter_immunity_flag and (
        (stand_node and stand_node.groups.igniter) or
        (entity_node and core.get_item_group(entity_node.name, "igniter") > 0)
    ) then

        unimobs.mobkit_api.apply_damage(
            self, unimobs.petz_setting.igniter_damage, "damaged by igniter"
        )

    end

    -- Apply damage from any nodes which have marked as harmful for this mob
    local harmful_node_data_list =
            unimobs.petz_api.get_msetting(self.mob_type, "harmful_node_data_list")

    if harmful_node_data_list ~= nil and #harmful_node_data_list > 0 then

        -- List of mini-tables in the form:
        --      harmful_node_data_list  = {
        --          {name = "air", where = "entity", damage = 1},
        --          {name = "unilib:grass_ordinary_1", where = "stand", damage = 3},
        --      }
        for _, mini_table in ipairs(harmful_node_data_list) do

            local harmful_node_pos
            if mini_table.where then

                if mini_table.where == "stand" then
                    harmful_node_pos = stand_pos
                else
                    harmful_node_pos = entity_pos
                end

            else

                harmful_node_pos = entity_pos

            end

            local harmful_node = core.get_node_or_nil(harmful_node_pos)
            if harmful_node and harmful_node.name == mini_table.name then
                unimobs.mobkit_api.apply_damage(self, mini_table.damage, "damaged by harmful node")
            end

        end

    end

end
