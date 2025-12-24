---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unimobs
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.admin_tool_mob_soother = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.unimobs.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function use_tool(itemstack, user, pointed_thing)

    -- Called when the player left-clicks a mob, while wielding this tool
    -- After basic checks, soothes the mob

    -- Basic checks
    local luaent = pointed_thing.ref:get_luaentity()
    if not luaent or
            not luaent.petz_compat_flag or
            (not luaent.hostile_to_players_flag and not luaent.was_attacked_by_player_flag) or
            not unimobs.petz_global.mob_table[luaent.mob_type] then
        return
    end

    -- Soothe the mob. Note that code in the "mtb_attack_player" package sets
    --      .was_attacked_by_player_flag back to true for pack animals like wolves, so that
    --      property must be disabled too
    luaent.hostile_to_players_flag = false
    luaent.pack_attack_mode_flag = false
    -- N.B. As described in the comments in petz_init_prop.lua, .was_attacked_by_player_flag is not
    --      set with unimobs.mobkit_api.add_mob_memory()
    luaent.was_attacked_by_player_flag = false

    -- Also empty the mob's behaviour queues, in case it was in the middle of attacking something
    unimobs.mobkit_api.clear_both_queues(luaent)

    local pname = user:get_player_name()
    core.chat_send_player(pname, S("This creature has been pacified (temporarily)"))

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.admin_tool_mob_soother.init()

    return {
        description = "Admin mob soothing tool",
        notes = "Temporarily calms an aggressive mob (for debugging purposes). Works only on" ..
                " mobs that are likely to attack the player. The soothing effects wears off" ..
                " when the game restarts",
    }

end

function unilib.pkg.admin_tool_mob_soother.exec()

    unilib.register_tool("unilib:admin_tool_mob_soother", nil, mode, {
        -- Original to unimobs
        description = S("Admin Mob Soother"),
        inventory_image = "unilib_admin_tool_mob_soother.png",
        groups = {not_in_creative_inventory = unilib.globalshow_admin_item_group},
        -- (no sounds)

        -- It's not OK to interact with water
        liquids_pointable = false,
        -- In common with other admin tools, forbid stacks
        stack_max = 1,
        wield_image = "",
        wield_scale = {x = 1, y = 1, z = 1},

        on_use = function(itemstack, user, pointed_thing)

            if user ~= nil and pointed_thing ~= nil and pointed_thing.type == "object" then
                use_tool(itemstack, user, pointed_thing)
            end

        end,
    })

end
