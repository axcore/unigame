---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- kitz_clear_mobs.lua
--      Shared API functions from the petz/kitz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/kitz/api/api_clear_mobs.lua)
---------------------------------------------------------------------------------------------------

function unimobs.kitz_api.clear_mobs_in_range(pos, mod_name)

    -- Was kitz.clear_mobs()
    -- Removes all entities within a 100 block radius of "pos" which were created by the specified
    --      "mod_name". However, petz-compatible mobs whose .is_tamed_flag is true are NOT removed

    for _, obj in ipairs(core.get_objects_inside_radius(pos, 100)) do

        local ent_name = obj:get_entity_name()
        if not obj:is_player() and core.registered_entities[ent_name] then

            local ent_mod_name = unilib.utils.get_mod_name(ent_name)
            local luaent = obj:get_luaentity()

--          if ent_mod_name == mod_name and luaent.type and not luaent.is_tamed_flag then
            if ent_mod_name == mod_name and
                    (not luaent.petz_compat_flag or not luaent.is_tamed_flag) then
                unimobs.kitz_api.remove_mob(luaent)
            end

        end

    end

end
