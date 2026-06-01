---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_box_filtration = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- On average, filtering ordinary water takes 2 minutes (1 minute to convert the dry box to wet,
--      and another minute to convert the wet box to dry + water)
local check_time = 6
local chance = 20

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_box_filtration.init()

    return {
        description = "Filtration box",
        notes = "Place a dry filtration box in the world, with ordinary water above and a gap" ..
                " below. Over time, the box will filter the ordinary water to produce river" ..
                " water. This package can be used in any game, but it's particularly designed" ..
                " for use together with the \"override_unilib_salt_water\" package, which makes" ..
                " ordinary water non-potable",
        depends = {
            "item_stick_ordinary",
            "liquid_water_ordinary",
            "liquid_water_river",
            "material_charcoal_artificial_lump",
        },
        suggested = {
            "gravel_ordinary",                  -- group:gravel
            "sand_ordinary",                    -- group:sand
        },
    }

end

function unilib.pkg.misc_box_filtration.exec()

    local c_stick = "unilib:item_stick_ordinary"

    unilib.register_node("unilib:misc_box_filtration_dry", nil, mode, {
        -- Original to unilib
        description = S("Dry Filtration Box"),
        tiles = {
            "unilib_misc_box_filtration_dry_top.png",
            "unilib_misc_box_filtration_dry_bottom.png",
            "unilib_misc_box_filtration_dry_side.png",
        },
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.gravel,

        on_construct = function(pos)
            core.get_node_timer(pos):start(check_time)
        end,

        on_timer = function(pos, elapsed)

            if math.random(chance) == 1 then

                local above_pos = {x = pos.x, y = pos.y + 1, z = pos.z}
                local above_node = core.get_node(above_pos)
                if above_node.name == "unilib:liquid_water_ordinary_source" or
                        above_node.name == "default:water_source" then

                    core.swap_node(above_pos, {name = "unilib:liquid_water_ordinary_flowing"})
                    core.swap_node(pos, {name = "unilib:misc_box_filtration_wet"})

                end

            end

            return true

        end,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:misc_box_filtration_dry",
        recipe = {
            {c_stick, "group:gravel", c_stick},
            {c_stick, "group:sand", c_stick},
            {c_stick, "unilib:material_charcoal_artificial_lump", c_stick},
        },
    })

    unilib.register_node("unilib:misc_box_filtration_wet", nil, mode, {
        -- Original to unilib
        description = S("Wet Filtration Box"),
        tiles = {
            "unilib_misc_box_filtration_wet_top.png",
            "unilib_misc_box_filtration_wet_bottom.png",
            "unilib_misc_box_filtration_wet_side.png",
        },
        groups = {cracky = 3, not_in_creative_inventory = 1},
        sounds = unilib.global.sound_table.gravel,

        on_construct = function(pos)
            core.get_node_timer(pos):start(check_time)
        end,

        on_timer = function(pos, elapsed)

            if math.random(chance) == 1 then

                local below_pos = {x = pos.x, y = pos.y - 1, z = pos.z}
                local below_node = core.get_node(below_pos)
                if below_node.name == "air" then

                    core.swap_node(below_pos, {name = "unilib:liquid_water_river_source"})
                    core.swap_node(pos, {name = "unilib:misc_box_filtration_dry"})

                end

            end

            return true

        end,
    })

end
