---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    steel
-- Code:    GPL-2.0
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_plate_steel_hard = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.steel.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_plate_steel_hard.init()

    return {
        description = "Hardened steel plate",
        depends = "decor_plate_steel_soft",
        optional = "material_scrap_steel",
    }

end

function unilib.pkg.decor_plate_steel_hard.exec()

    unilib.register_node("unilib:decor_plate_steel_hard", "steel:plate_hard", mode, {
        -- From steel:plate_hard
        description = S("Hardened Steel Plate"),
        tiles = {"unilib_decor_plate_steel_hard.png"},
        -- N.B. dig_stone = 1 in original code
        groups = {cracky = 1},
        -- N.B. "stone" in original code
        sounds = unilib.global.sound_table.metal,

        -- N.B. is_ground_content = false not in original code; added to match other decor items
        is_ground_content = false,
    })
    unilib.register_craft({
        -- From steel:plate_hard
        type = "cooking",
        output = "unilib:decor_plate_steel_hard",
        recipe = "unilib:decor_plate_steel_soft",
    })
    if unilib.global.pkg_executed_table["material_scrap_steel"] ~= nil then

        unilib.register_craft({
            -- From steel:strut
            output = "unilib:material_scrap_steel 4",
            recipe = {
                {"unilib:decor_plate_steel_hard"},
            },
        })

    end

end
