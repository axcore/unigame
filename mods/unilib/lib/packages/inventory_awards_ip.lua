---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.inventory_awards_ip = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.inventory_awards_ip.init()

    return {
        description = "Adds an awards button to \"inventory_plus\", with which the player can" ..
                " view their vocations and achievements",
        mod_depends = "inventory_plus",
    }

end

function unilib.pkg.inventory_awards_ip.exec()

    if not unilib.setting.awards_enable_flag then
        return
    end

    core.register_on_joinplayer(function(player)
        inventory_plus.register_button(player, "awards_ip_btn", S("Awards"))
    end)

    core.register_on_player_receive_fields(function(player, formname, fields)

        -- No formname available, so rely on a button named after inventory_plus
        if fields.awards_ip_btn then
            unilib.awards.show_formspec(player:get_player_name())
        end

    end)


end
