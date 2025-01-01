---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    steel
-- Code:    GPL-2.0
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_plate_steel_soft = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.steel.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_plate_steel_soft.init()

    return {
        description = "Soft steel plate",
        depends = "metal_steel",
        optional = "material_scrap_steel",
    }

end

function unilib.pkg.decor_plate_steel_soft.exec()

    local c_ingot = "unilib:metal_steel_ingot"

    unilib.register_node("unilib:decor_plate_steel_soft", "steel:plate_soft", mode, {
        -- From steel:plate_soft
        description = S("Soft Steel Plate"),
        tiles = {"unilib_decor_plate_steel_soft.png"},
        -- N.B. dig_stone = 1 in original code
        groups = {cracky = 2},
        -- N.B. "stone" in original code
        sounds = unilib.global.sound_table.metal,

        -- N.B. is_ground_content = false not in original code; added to match other decor items
        is_ground_content = false,
    })
    -- N.B. Original craft recipe conflicts with recipe in "trapdoor_steel" package
    --[[
    unilib.register_craft({
        -- From steel:plate_soft
        output = "unilib:decor_plate_steel_soft 2",
        recipe = {
            {c_ingot, c_ingot},
            {c_ingot, c_ingot},
        },
    })
    ]]--
    unilib.register_craft({
        -- From steel:plate_soft
        output = "unilib:decor_plate_steel_soft 2",
        recipe = {
            {c_ingot, "", c_ingot},
            {"", "", ""},
            {c_ingot, "", c_ingot},
        },
    })
    if unilib.global.pkg_executed_table["material_scrap_steel"] ~= nil then

        unilib.register_craft({
            -- From steel:strut
            output = "unilib:material_scrap_steel 4",
            recipe = {
                {"unilib:decor_plate_steel_soft"},
            },
        })

    end

end
