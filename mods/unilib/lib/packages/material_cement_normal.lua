---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cement
-- Code:    GPLv3.0
-- Media:   GPLv3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.material_cement_normal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cement.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.material_cement_normal.init()

    return {
        description = "Normal cement",
        notes = "Wet and dry cement can be crafted using ordinary ingredients. Dry cement" ..
                " becomes wet near water. Wet cement becomes concrete when not wear water." ..
                " Concrete can be dyed",
        depends = "gravel_ordinary",
        at_least_one = {"liquid_water_ordinary", "liquid_water_river"},
    }

end

function unilib.pkg.material_cement_normal.exec()

    local dry_img = "unilib_sand_ordinary.png^(default_gravel.png^[opacity:128)"
    local wet_img = "(" .. dry_img .. ")^[colorize:#000000:60"

    unilib.register_node("unilib:material_cement_normal_dry", "cement:dry", mode, {
        -- From cement:dry
        description = S("Dry Normal Cement"),
        tiles = {dry_img},
        groups = {crumbly = 2, falling_node = 1},
        sounds = unilib.sound_table.gravel,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- From cement:dry
        type = "shapeless",
        output = "unilib:material_cement_normal_dry 2",
        recipe = {"group:sand", "unilib:gravel_ordinary"},
    })

    unilib.register_node("unilib:material_cement_normal_wet", "cement:wet", mode, {
        -- From cement:wet
        description = S("Wet Normal Cement"),
        tiles = {wet_img},
        groups = {crumbly = 3, falling_node = 1},
        sounds = unilib.sound_table.dirt,

        is_ground_content = false,
    })
    -- (Craft recipe appears below)

    unilib.register_abm({
        -- From cement/init.lua
        label = "Convert dry cement to wet cement [material_cement_normal]",
        nodenames = {"unilib:material_cement_normal_dry"},
        -- N.B. Only responds to ordinary water in the original code
        neighbors = {"unilib:liquid_water_ordinary_source", "unilib:liquid_water_river_source"},

        catch_up = true,
        chance = 2,
        interval = 5,

        action = function(pos, node)
            minetest.set_node(pos, {name = "unilib:material_cement_normal_wet"})
        end,
    })

end

function unilib.pkg.material_cement_normal.post()

    unilib.register_craft({
        -- From cement:wet
        type = "shapeless",
        output = "unilib:material_cement_normal_wet 2",
        recipe = {"group:sand", "unilib:gravel_ordinary", "group:craftable_bucket"},
        replacements = unilib.craftable_bucket_list,
    })

end
