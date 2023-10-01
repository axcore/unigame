---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_calendar_simple = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_calendar_simple.init()

    return {
        description = "Simple calendar",
        depends = {"dye_basic", "item_paper_ordinary", "item_string_ordinary"},
    }

end

function unilib.pkg.misc_calendar_simple.exec()

    local c_paper = "unilib:item_paper_ordinary"

    unilib.register_node("unilib:misc_calendar_simple", nil, mode, {
        -- Original to unilib
        description = unilib.brackets(S("Simple Calendar"), S("right-click to open")),
        tiles = {"unilib_misc_calendar_simple.png"},
        groups = {attached_node = 1, flammable = 1, oddly_breakable_by_hand = 3},
        sounds = unilib.sound_table.node,

        drawtype = "signlike",
        inventory_image = "unilib_misc_calendar_simple.png",
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = {
            type = "wallmounted",
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_misc_calendar_simple.png",

        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
            unilib.open_simple_calendar(clicker)
        end,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "calendar_node:calendar",
        recipe = {
            {c_paper, "unilib:dye_black", c_paper},
            {"unilib:item_string_ordinary", "unilib:dye_black", c_paper},
            {c_paper, "unilib:dye_black", c_paper},
        },
    })

end
