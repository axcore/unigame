---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.admin_gun_cobweb = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.admin_gun_cobweb.init()

    return {
        description = "Admin cobweb gun",
        notes = "Shoots a cobweb as a projectile (for debugging purposes)",
        -- N.B. "misc_projectile_cobweb" creates the entity referenced below
        depends = {"misc_projectile_cobweb", "shared_petz_projectiles"},
    }

end

function unilib.pkg.admin_gun_cobweb.exec()

    local c_entity = "unilib:entity_misc_projectile_cobweb"

    unilib.register_tool("unilib:admin_gun_cobweb", "petz:cobweb_gun", mode, {
        -- From petz:cobweb_gun
        description = unilib.utils.hint(
            S("Cobweb Gun"), S("shoots cobweb projectiles")
        ),
        inventory_image = "unilib_admin_gun_cobweb.png",
        -- N.B. Omitted not_in_craft_guide = 1 from original code
        groups = {not_in_creative_inventory = unilib.globalshow_admin_item_group},

        -- N.B. Omitted .short_description from original code
--      short_description = S("Cobweb Gun"),

        on_use = function(itemstack, user, pointed_thing)

            if core.registered_entities[c_entity] then
                unilib.pkg.shared_petz_projectiles.spawn_projectile(user, 20, c_entity)
            end

        end,
    })

end
