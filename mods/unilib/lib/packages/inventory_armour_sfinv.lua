---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/3d_armor_sfinv
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.inventory_armour_sfinv = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table["3d_armor_sfinv"].add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.inventory_armour_sfinv.init()

    return {
        description = "Adds an armour button to \"sfinv\", with which the player can equip or" ..
                " unequip armour",
        mod_depends = "sfinv",
    }

end

function unilib.pkg.inventory_armour_sfinv.exec()

    sfinv.register_page("unilib:armour", {
        title = S("Armour"),
        get = function(self, player, context)

            local pname = player:get_player_name()
            local formspec = unilib.armour.get_formspec(pname, true)
            return sfinv.make_formspec(player, context, formspec, false)

        end,
    })

    unilib.armour.register_callback_on_update(function(player)

        if sfinv.enabled then
            sfinv.set_player_inventory_formspec(player)
        end

    end)

end
