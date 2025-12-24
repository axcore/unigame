---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unimobs
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.admin_tool_mob_stimulator = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.unimobs.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function use_tool(itemstack, user, pointed_thing)

    -- Called when the player left-clicks a mob, while wielding this tool
    -- After basic checks, stimulates the mob

    -- Basic checks
    local luaent = pointed_thing.ref:get_luaentity()
    if not luaent or
            not luaent.petz_compat_flag or
            luaent.is_in_rut_flag or
            luaent.is_pregnant_flag or
            not unimobs.petz_global.mob_table[luaent.mob_type] then
        return
    end

    -- Stimulate the mob
    unimobs.petz_api.stimulate_mob_breeding(luaent, user)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.admin_tool_mob_stimulator.init()

    return {
        description = "Admin mob stimulation tool",
        notes = "Encourages mobs to breed, by making them search for a mate (for debugging" ..
                " purposes). Does not work on mobs that are infertile or already pregnant",
    }

end

function unilib.pkg.admin_tool_mob_stimulator.exec()

    unilib.register_tool("unilib:admin_tool_mob_stimulator", nil, mode, {
        -- Original to unimobs
        description = S("Admin Mob Stimulator"),
        inventory_image = "unilib_admin_tool_mob_stimulator.png",
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
