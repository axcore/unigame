---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    steel
-- Code:    GPL-2.0
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_steel_plate_hard = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.steel.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_steel_plate_hard.init()

    return {
        description = "Hardened steel plate",
        depends = "metal_steel_plate_soft",
        optional = "metal_steel_scrap",
    }

end

function unilib.pkg.metal_steel_plate_hard.exec()

    unilib.register_node("unilib:metal_steel_plate_hard", "steel:plate_hard", mode, {
        -- From steel:plate_hard
        description = S("Hardened Steel Plate"),
        tiles = {"unilib_metal_steel_plate_hard.png"},
        -- N.B. dig_stone = 1 in original code
        groups = {cracky = 1},
        -- N.B. "stone" in original code
        sounds = unilib.sound_table.metal,
    })
    unilib.register_craft({
        -- From steel:plate_hard
        type = "cooking",
        output = "unilib:metal_steel_plate_hard",
        recipe = "unilib:metal_steel_plate_soft",
    })
    if unilib.pkg_executed_table["metal_steel_scrap"] ~= nil then

        unilib.register_craft({
            -- From steel:strut
            output = "unilib:metal_steel_scrap 4",
            recipe = {
                {"unilib:metal_steel_plate_hard"},
            },
        })

    end

end
