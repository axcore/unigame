---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unimobs
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.admin_tool_mob_tamer = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.unimobs.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function use_tool(itemstack, user, pointed_thing)

    -- Called when the player left-clicks a mob, while wielding this tool
    -- After basic checks, tames the mob

    -- Basic checks
    local luaent = pointed_thing.ref:get_luaentity()
    if not luaent or
            not luaent.petz_compat_flag or
            luaent.is_tamed_flag or
            luaent.owner or
            not unimobs.petz_global.mob_table[luaent.mob_type] then
        return
    end

    local pname = user:get_player_name()
    if luaent.is_wild_flag then

        core.chat_send_player(pname, S("This creature cannot be tamed"))
        return

    end

    -- Tame the mob
    luaent.is_tamed_flag = unimobs.mobkit_api.add_mob_memory(luaent, "is_tamed_flag", true)
    luaent.owner = unimobs.mobkit_api.add_mob_memory(luaent, "owner", pname)

    core.chat_send_player(pname, S("This creature has been tamed"))

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.admin_tool_mob_tamer.init()

    return {
        description = "Admin mob taming tool",
        notes = "Tames a mob (for debugging purposes). Does not work on mobs that can't be" ..
                " tamed (for example, monsters and wild animals). Does not work on mobs that" ..
                " have already been tamed by another player",
    }

end

function unilib.pkg.admin_tool_mob_tamer.exec()

    unilib.register_tool("unilib:admin_tool_mob_tamer", nil, mode, {
        -- Original to unimobs
        description = S("Admin Mob Tamer"),
        inventory_image = "unilib_admin_tool_mob_tamer.png",
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
