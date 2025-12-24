---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unimobs
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.admin_tool_mob_breeder = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.unimobs.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function use_tool(itemstack, user, pointed_thing)

    -- Called when the player left-clicks a mob, while wielding this tool
    -- After basic checks, impregnates the mob

    -- Basic checks
    local luaent = pointed_thing.ref:get_luaentity()
    if not luaent or
            not luaent.petz_compat_flag or
            luaent.is_male_flag or
            luaent.is_pregnant_flag or
            not unimobs.petz_global.mob_table[luaent.mob_type] then
        return
    end

    -- Impregnate the mob (effectively cloning it, since there isn't a separate father and mother)
    unimobs.petz_api.breed_mob_naturally(luaent, luaent)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.admin_tool_mob_breeder.init()

    return {
        description = "Admin mob breeding tool",
        notes = "Makes a mob pregnant (for debugging purposes). Does not work on female mobs" ..
                " that are already pregnant, and doesn't work on male mobs at all",
    }

end

function unilib.pkg.admin_tool_mob_breeder.exec()

    unilib.register_tool("unilib:admin_tool_mob_breeder", nil, mode, {
        -- Original to unimobs
        description = S("Admin Mob Breeder"),
        inventory_image = "unilib_admin_tool_mob_breeder.png",
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
