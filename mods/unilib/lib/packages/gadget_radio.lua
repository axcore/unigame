---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.gadget_radio = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gadget_radio.init()

    return {
        description = "Radio",
        notes = "A purely decorative item",
        depends = "gadget_speaker",
        optional = "shared_screwdriver",
    }

end

function unilib.pkg.gadget_radio.exec()

    unilib.register_node("unilib:gadget_radio", "xdecor:radio", mode, {
        -- From xdecor:radio
        description = S("Radio"),
        tiles = {
            "unilib_gadget_radio_top.png",
            "unilib_gadget_radio_side.png",
            "unilib_gadget_radio_side.png",
            "unilib_gadget_radio_side.png",
            "unilib_gadget_radio_back.png",
            "unilib_gadget_radio_front.png",
        },
        groups = {cracky = 2},
        sounds = unilib.global.sound_table.node,

        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From xdecor:radio
        type = "shapeless",
        output = "unilib:gadget_radio",
        recipe = {"unilib:gadget_speaker", "unilib:gadget_speaker"},
    })
    if unilib.global.pkg_executed_table["shared_screwdriver"] ~= nil then

        unilib.override_item("unilib:gadget_radio", {
            on_rotate = unilib.pkg.shared_screwdriver.rotate_simple,
        })

    end

end
