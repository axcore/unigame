---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.admin_gun_lantern = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.admin_gun_lantern.init()

    return {
        description = "Admin lantern gun",
        notes = "Shoots a jack-o'-lantern as a projectile (for debugging purposes)",
        -- N.B. "misc_projectile_lantern" creates the entity referenced below
        depends = {"misc_projectile_lantern", "shared_petz_projectiles"},
    }

end

function unilib.pkg.admin_gun_lantern.exec()

    local c_entity = "unilib:entity_misc_projectile_lantern"

    unilib.register_tool("unilib:admin_gun_lantern", "petz:grenade_gun", mode, {
        -- From petz:grenade_gun
        description = unilib.utils.hint(
            S("Lantern Gun"), S("shoots explosive jack-o'-lanterns")
        ),
        inventory_image = "unilib_admin_gun_lantern.png",
        -- N.B. Omitted not_in_craft_guide = 1 from original code
        groups = {not_in_creative_inventory = unilib.globalshow_admin_item_group},

        -- N.B. Omitted .short_description from original code
--      short_description = S("Lantern Gun"),

        on_use = function(itemstack, user, pointed_thing)

            if core.registered_entities[c_entity] then
                unilib.pkg.shared_petz_projectiles.spawn_projectile(user, 20, c_entity)
            end

        end,
    })

end
