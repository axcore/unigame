---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_calendar_fancy = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_calendar_fancy.init()

    return {
        description = "Fancy calendar",
        notes = "When player stats are disabled in settings, this calendar behaves the same as" ..
                " a simple calendar",
        depends = {"dye_basic", "item_paper_ordinary", "metal_steel", "shared_calendars"},
    }

end

function unilib.pkg.misc_calendar_fancy.exec()

    local c_paper = "unilib:item_paper_ordinary"

    unilib.register_node("unilib:misc_calendar_fancy", nil, mode, {
        -- Original to unilib
        description = unilib.utils.brackets(S("Fancy Calendar"), S("right-click to open")),
        tiles = {"unilib_misc_calendar_fancy.png"},
        groups = {attached_node = 1, flammable = 1, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.node,

        drawtype = "signlike",
        inventory_image = "unilib_misc_calendar_fancy.png",
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = {
            type = "wallmounted",
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_misc_calendar_fancy.png",

        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)

            if not unilib.setting.stats_bio_flag then

                unilib.pkg.shared_calendars.open_simple_calendar(clicker)

            else

                unilib.pkg.shared_calendars.open_fancy_calendar(
                    clicker, "unilib:misc_calendar_fancy"
                )

            end

        end,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:misc_calendar_fancy",
        recipe = {
            {c_paper, "unilib:dye_black", c_paper},
            {"unilib:metal_steel_ingot", "unilib:dye_black", c_paper},
            {c_paper, "unilib:dye_black", c_paper},
        },
    })

    core.register_on_player_receive_fields(function(player, formname, fields)
        unilib.calendars.on_receive_fields(player, formname, fields, "unilib:misc_calendar_fancy")
    end)

end
