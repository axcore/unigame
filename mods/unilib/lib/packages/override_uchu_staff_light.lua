---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    lightstaff
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.override_uchu_staff_light = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.lightstaff.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.override_uchu_staff_light.init()

    return {
        description = "Overrides the staff of light (from ethereal_ng), if loaded, to convert" ..
                " smooth stone nodes into glowstone lamps",
        optional = "staff_light",
    }

end

function unilib.pkg.override_uchu_staff_light.exec()

    if unilib.global.pkg_executed_table["light_block_glowstone"] ~= nil and
            unilib.global.pkg_executed_table["staff_light"] ~= nil then

        core.registered_tools["unilib:staff_light"].on_use = function(
            itemstack, user, pointed_thing
        )
            if pointed_thing.type ~= "node" then
                return
            end

            local pos = pointed_thing.under
            local pname = user:get_player_name()

            if core.is_protected(pos, pname) then

                core.record_protection_violation(pos, pname)
                return

            end

            local full_name = core.get_node(pos).name
            if core.get_item_group(full_name, "smoothstone") > 0 then

                core.swap_node(pos, {name = "unilib:light_block_glowstone"})

                if not unilib.utils.is_creative(pname) then
                    itemstack:add_wear(65535 / 149) -- 150 uses
                end

                return itemstack

            end

        end

    end

end
