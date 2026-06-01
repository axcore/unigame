---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.inventory_awards_sfinv = {}

local S = unilib.intllib
local F = core.formspec_escape
local FS = function(...) return F(S(...)) end
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.inventory_awards_sfinv.init()

    return {
        description = "Adds an awards button to \"sfinv\", with which the player can view their" ..
                " vocations and achievements",
        mod_depends = "sfinv",
    }

end

function unilib.pkg.inventory_awards_sfinv.exec()

    if not unilib.setting.awards_enable_flag then
        return
    end

    -- Unfortunately the player must click the right tab, then an extra button, before opening
    --      unilib's formspec (but it's still better than nothing)
    sfinv.register_page("unilib:awards", {
        title = S("Awards"),
        get = function(self, player, context)

            local formspec =
                "size[8,8]" ..
                "image_button[3,3;2,2;unilib_gui_trophy_comb.png;awards_sfinv_btn;]" ..
                -- N.B. The label will be in the wrong position, if translated
--              "label[3.25,5;" .. FS("View Awards") .. "]"
                "label[3.25,5;" .. F("View Awards") .. "]"

            return sfinv.make_formspec(player, context, formspec, false)

        end,
    })

    core.register_on_player_receive_fields(function(player, formname, fields)

        -- No formname available, so rely on a button named after sfinv
        if fields.awards_sfinv_btn then
            unilib.awards.show_formspec(player:get_player_name())
        end

    end)

end
