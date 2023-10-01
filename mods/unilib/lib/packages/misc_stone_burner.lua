---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_stone_burner = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_stone_burner.init()

    return {
        description = "Burner stone",
        notes = "Can be ignited (to create a permanent flame)",
        depends = {"fire_permanent", "mineral_flint", "mineral_quartz_white", "mineral_ruby"}
    }

end

function unilib.pkg.misc_stone_burner.exec()

    local c_flint = "unilib:mineral_flint_lump_with_steel"
    local c_ruby = "unilib:mineral_ruby_gem"
    local c_quartz = "unilib:mineral_quartz_white_crystal"
    local c_blue_vindesite = "unilib:stone_vindesite_blue"
    local c_white_vindesite = "unilib:stone_vindesite_white"

    unilib.register_node("unilib:misc_stone_burner", "underch:burner", mode, {
        -- From underch:burner
        description = S("Burner Stone"),
        tiles = {"unilib_misc_stone_burner.png"},
        groups = {cracky = 3, igniter = 4},
        sounds = unilib.sound_table.stone,

        after_destruct = unilib.pkg.fire_permanent.remove,
        on_ignite = unilib.pkg.fire_permanent.add,
    })
    -- N.B. Original code specifies a "group:vindesite" that doesn't actually exist. Assume that it
    --      refers to both varieties of vindesite
    unilib.register_craft({
        -- From underch:burner
        output = "unilib:misc_stone_burner",
        recipe = {
            {c_white_vindesite, c_ruby, c_white_vindesite},
            {c_quartz, c_flint, c_quartz},
            {c_white_vindesite, c_ruby, c_white_vindesite},
        }
    })
    unilib.register_craft({
        -- From underch:burner
        output = "unilib:misc_stone_burner",
        recipe = {
            {c_blue_vindesite, c_ruby, c_blue_vindesite},
            {c_quartz, c_flint, c_quartz},
            {c_blue_vindesite, c_ruby, c_blue_vindesite},
        }
    })

end
