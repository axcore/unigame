---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_rooted_orange_glow = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_rooted_orange_glow.init()

    return {
        description = "Orange glowing coral",
        optional = "dye_basic",
    }

end

function unilib.pkg.coral_rooted_orange_glow.exec()

    unilib.register_node("unilib:coral_rooted_orange_glow", "ethereal:coral3", mode, {
        -- From ethereal:coral3
        description = S("Orange Glowing Coral"),
        tiles = {"unilib_coral_rooted_orange_glow.png"},
        groups = {snappy = 3},
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_coral_rooted_orange_glow.png",
        light_source = 3,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 1 / 4, 6 / 16}
        },
        wield_image = "unilib_coral_rooted_orange_glow.png",
    })
    if unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From ethereal:coral3
            output = "unilib:dye_orange 3",
            recipe = {
                {"unilib:coral_rooted_orange_glow"},
            },
        })

    end

end
