---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    steel
-- Code:    GPL-2.0
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_steel_plate_soft = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.steel.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_steel_plate_soft.init()

    return {
        description = "Soft steel plate",
        depends = "metal_steel",
        optional = "metal_steel_scrap",
    }

end

function unilib.pkg.metal_steel_plate_soft.exec()

    local c_ingot = "unilib:metal_steel_ingot"

    unilib.register_node("unilib:metal_steel_plate_soft", "steel:plate_soft", mode, {
        -- From steel:plate_soft
        description = S("Soft Steel Plate"),
        tiles = {"unilib_metal_steel_plate_soft.png"},
        -- N.B. dig_stone = 1 in original code
        groups = {cracky = 2},
        -- N.B. "stone" in original code
        sounds = unilib.sound_table.metal,
    })
    -- N.B. Original craft recipe conflicts with recipe in "trapdoor_steel" package
    --[[
    unilib.register_craft({
        -- From steel:plate_soft
        output = "unilib:metal_steel_plate_soft 2",
        recipe = {
            {c_ingot, c_ingot},
            {c_ingot, c_ingot},
        },
    })
    ]]--
    unilib.register_craft({
        -- From steel:plate_soft
        output = "unilib:metal_steel_plate_soft 2",
        recipe = {
            {c_ingot, "", c_ingot},
            {"", "", ""},
            {c_ingot, "", c_ingot},
        },
    })
    if unilib.pkg_executed_table["metal_steel_scrap"] ~= nil then

        unilib.register_craft({
            -- From steel:strut
            output = "unilib:metal_steel_scrap 4",
            recipe = {
                {"unilib:metal_steel_plate_soft"},
            },
        })

    end

end
