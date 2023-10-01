---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.gadget_speaker = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gadget_speaker.init()

    return {
        description = "Speaker",
        notes = "A purely decorative item",
        depends = {"metal_copper", "metal_gold"},
        optional = "shared_screwdriver",
    }

end

function unilib.pkg.gadget_speaker.exec()

    local c_copper = "unilib:metal_copper_ingot"
    local c_gold = "unilib:metal_gold_ingot"

    unilib.register_node("unilib:gadget_speaker", "xdecor:speaker", mode, {
        -- From xdecor:speaker
        description = S("Speaker"),
        tiles = {
            "unilib_gadget_speaker_top.png",
            "unilib_gadget_speaker_side.png",
            "unilib_gadget_speaker_side.png",
            "unilib_gadget_speaker_side.png",
            "unilib_gadget_speaker_back.png",
            "unilib_gadget_speaker_front.png",
        },
        groups = {cracky = 2},
        sounds = unilib.sound_table.node,

        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From xdecor:speaker
        output = "unilib:gadget_speaker",
        recipe = {
            {c_gold, c_copper, c_gold},
            {c_copper, "", c_copper},
            {c_gold, c_copper, c_gold}
        },
    })
    if unilib.pkg_executed_table["shared_screwdriver"] ~= nil then

        unilib.override_item("unilib:gadget_speaker", {
            on_rotate = unilib.pkg.shared_screwdriver.rotate_simple,
        })

    end

end
