---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pontoons
-- Code:    MIT
-- Media:   MIT/CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_pontoon_wood = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pontoons.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_pontoon_wood.init()

    return {
        description = "Wooden pontoon",
    }

end

function unilib.pkg.misc_pontoon_wood.exec()

    unilib.register_node("unilib:misc_pontoon_wood", "pontoons:wood_pontoon", mode, {
        -- From pontoons:wood_pontoon
        description = unilib.utils.hint(S("Wooden Pontoon"), S("right-click water to place")),
        tiles = {"unilib_misc_pontoon_wood.png"},
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, wood = 1},
        sounds = unilib.global.sound_table.wood,

        is_ground_content = false,
        liquids_pointable = true,
        paramtype2 = "facedir",
        place_param2 = 0,
    })
    -- N.B. Tweaked the original craft recipe, reducing output from 4 to 2
    unilib.register_craft({
        -- From pontoons:wood_pontoon
        output = "unilib:misc_pontoon_wood 2",
        recipe = {
            {"group:wood", "group:wood", "group:wood"},
            {"", "", ""},
            {"", "group:wood", ""},
        },
    })
    unilib.register_craft({
        -- From pontoons:wood_pontoon
        type = "fuel",
        recipe = "unilib:misc_pontoon_wood",
        burntime = 7,
    })

end
