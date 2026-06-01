---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.inventory_awards_ui = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.inventory_awards_ui.init()

    return {
        description = "Adds an awards button to \"unified_inventory\", with which the player can" ..
                " view their vocations and achievements",
        mod_depends = "unified_inventory",
    }

end

function unilib.pkg.inventory_awards_ui.exec()

    if not unilib.setting.awards_enable_flag then
        return
    end

    local ui = unified_inventory
    if ui.sfinv_compat_layer then
        return
    end

    unified_inventory.register_button("awards", {
        type = "image",
        image = "unilib_gui_trophy_comb.png",
        tooltip = S("Awards"),

        action = function(player)
            unilib.awards.show_formspec(player:get_player_name())
        end,
    })

end
