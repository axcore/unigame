---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/3d_armor_ui
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.inventory_armour_ui = {}

local S = unilib.intllib
local FS = function(...) return core.formspec_escape(S(...)) end
local mode = unilib.global.imported_mod_table["3d_armor_ui"].add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.inventory_armour_ui.init()

    return {
        description = "Adds an armour button to \"unified_inventory\", with which the player can" ..
                " equip or unequip armour",
        mod_depends = "unified_inventory",
    }

end

function unilib.pkg.inventory_armour_ui.exec()

    local ui = unified_inventory
    if ui.sfinv_compat_layer then
        return
    end

    unilib.armour.register_callback_on_update(function(player)

        local pname = player:get_player_name()
        if unified_inventory.current_page[pname] == "armour" then
            unified_inventory.set_inventory_formspec(player, "armour")
        end

    end)

    unified_inventory.register_button("armour", {
        type = "image",
        image = "unilib_inventory_armour_ui.png",
        tooltip = S("Armour")
    })

    unified_inventory.register_page("armour", {

        get_formspec = function(player, perplayer_formspec)

            local pname = player:get_player_name()
            local player_data_table = unilib.armour.get_player_data(pname)
            local player_texture_table = unilib.armour.get_player_texture(pname)
            local fire_protect = unilib.armour.get_config("fire_protect")

            local fy = perplayer_formspec.form_header_y + 0.5
            local gridx = perplayer_formspec.std_inv_x
            local gridy = 0.6

            local formspec = perplayer_formspec.standard_inv_bg ..
                perplayer_formspec.standard_inv ..
                ui.make_inv_img_grid(gridx, gridy, 2, 3) ..
                string.format(
                    "label[%f,%f;%s]",
                    perplayer_formspec.form_header_x,
                    perplayer_formspec.form_header_y,
                    FS("Armour")
                ) ..
                string.format(
                    "list[detached:%s_armour;armour;%f,%f;2,3;]",
                    pname, gridx + ui.list_img_offset, gridy + ui.list_img_offset
                ) ..
                "image[3.5," .. (fy - 0.25) .. ";2,4;" .. player_texture_table.preview .. "]" ..
                "label[6.0," .. (fy + 0.0) .. ";" .. FS("Level") .. ": " ..
                        player_data_table.level .. "]" ..
                "label[6.0," .. (fy + 0.5) .. ";" .. FS("Heal") .. ":  " ..
                        player_data_table.heal .. "]" ..
                "listring[current_player;main]" ..
                "listring[detached:" .. pname .. "_armour;armour]"

            if fire_protect then

                formspec = formspec .. "label[6.0," .. (fy + 1.0) .. ";" .. FS("Fire") .. ":  " ..
                        player_data_table.fire .. "]"

            end

            if core.get_modpath("technic") ~= nil then

                formspec = formspec .. "label[6.0," .. (fy + 1.5) .. ";" .. FS("Radiation") ..
                        ":  " .. player_data_table.groups["radiation"] .. "]"

            end

            return {formspec = formspec}

        end,
    })

end
