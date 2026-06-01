---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pontoons
-- Code:    MIT
-- Media:   MIT/CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_pontoon_steel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pontoons.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_pontoon_steel.init()

    return {
        description = "Steel pontoon",
        depend = "metal_steel",
    }

end

function unilib.pkg.misc_pontoon_steel.exec()

    local c_ingot = "unilib:metal_steel_ingot"

    unilib.register_node("unilib:misc_pontoon_steel", "pontoons:steel_pontoon", mode, {
        -- From pontoons:steel_pontoon
        description = unilib.utils.hint(
            S("Steel Pontoon"), S("right-click water or lava to place")
        ),
        tiles = {"unilib_misc_pontoon_steel.png"},
        groups = {cracky = 1, level = 2},
        sounds = unilib.global.sound_table.metal,

        is_ground_content = false,
        liquids_pointable = true,
    })
    -- N.B. Tweaked the original craft recipe, to match the one in the "misc_pontoon_wood" package
    unilib.register_craft({
        -- From pontoons:steel_pontoon
        output = "unilib:misc_pontoon_steel",
        recipe = {
            {c_ingot, c_ingot, c_ingot},
            {"", "", ""},
            {"", c_ingot, ""},
        },
    })

end
