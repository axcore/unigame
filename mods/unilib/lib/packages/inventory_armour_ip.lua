---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/3d_armor_ui
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.inventory_armour_ip = {}

local S = unilib.intllib
local FS = function(...) return core.formspec_escape(S(...)) end
local mode = unilib.global.imported_mod_table["3d_armor_ip"].add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.inventory_armour_ip.init()

    return {
        description = "Adds an armour button to \"inventory_plus\", with which the player can" ..
                " equip or unequip armour",
        mod_depends = "inventory_plus",
    }

end

function unilib.pkg.inventory_armour_ip.exec()

    local old_formspec = unilib.armour.get_default_formspec()
    unilib.armour.set_default_formspec(
         "size[8,8.5]button[6,0;2,0.5;main;" .. FS("Back") .. "]" .. old_formspec
    )

    unilib.armour.register_callback_on_update(function(player)

        local pname = player:get_player_name()
        local formspec = unilib.armour.get_formspec(pname, true)
        local page = player:get_inventory_formspec()
        if page:find("detached:" .. pname .. "_armour") then
            inventory_plus.set_inventory_formspec(player, formspec)
        end

    end)

    if core.get_modpath("crafting") then

        inventory_plus.get_formspec = function(player, page)
        end

    end

    core.register_on_joinplayer(function(player)
        inventory_plus.register_button(player, "armour", S("Armour"))
    end)

    core.register_on_player_receive_fields(function(player, formname, fields)

        if fields.armour then

            local pname = player:get_player_name()
            if not pname or
                    not core.get_inventory({type = "detached", name = pname .. "_armour"}) then
                return
            end

            local formspec = unilib.armour.get_formspec(pname, true)
            inventory_plus.set_inventory_formspec(player, formspec)

        end

    end)

end
