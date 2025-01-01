---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_rooted_green_glow = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_rooted_green_glow.init()

    return {
        description = "Green glowing coral",
        notes = "Because of code in the \"sand_undersea\" package, grows spontaneuously on" ..
                " undersea sand (but can be placed on any type of sand)",
        optional = "dye_basic",
    }

end

function unilib.pkg.coral_rooted_green_glow.exec()

    unilib.register_node("unilib:coral_rooted_green_glow", "ethereal:coral5", mode, {
        -- From ethereal:coral5
        description = S("Green Glowing Coral"),
        tiles = {"unilib_coral_rooted_green_glow.png"},
        -- N.B. No coral = 1 in original code
        groups = {coral = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_coral_rooted_green_glow.png",
        light_source = 3,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 3 / 16, 6 / 16}
        },
        wield_image = "unilib_coral_rooted_green_glow.png",

        -- N.B. No .on_place() in original code
        on_place = function(itemstack, placer, pointed_thing)

            return unilib.misc.place_in_medium(
                itemstack, placer, pointed_thing,
                {need_under = "group:sand"}
            )

        end,
    })
    if unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From ethereal:coral5
            output = "unilib:dye_green 3",
            recipe = {
                {"unilib:coral_rooted_green_glow"},
            },
        })

    end

end
