---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    steel
-- Code:    GPL-2.0
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_fence_steel_soft = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.steel.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_fence_steel_soft.init()

    return {
        description = "Soft steel fence",
        depends = "metal_steel",
        optional = "material_scrap_steel",
    }

end

function unilib.pkg.misc_fence_steel_soft.exec()

    local c_ingot = "unilib:metal_steel_ingot"

    unilib.register_node("unilib:misc_fence_steel_soft", "steel:grate_soft", mode, {
        -- From steel:grate_soft
        description = S("Soft Steel Fence"),
        tiles = {"unilib_misc_fence_steel_soft.png"},
        -- N.B. dig_stone = 1 in original code
        groups = {choppy = 2, cracky = 2},
        -- N.B. "wood" in original code
        sounds = unilib.global.sound_table.metal,

        drawtype = "fencelike",
        inventory_image = "unilib_misc_fence_steel_soft_inv.png",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
        },
        wield_image = "unilib_misc_fence_steel_soft_inv.png",
    })
    -- N.B. Original craft recipe conflicts with recipe in "armour_boots_steel" package
    --[[
    unilib.register_craft({
        -- From steel:grate_soft
        output = "unilib:misc_fence_steel_soft 3",
        recipe = {
            {c_ingot, "", c_ingot},
            {c_ingot, "", c_ingot},
        },
    })
    ]]--
    unilib.register_craft({
        -- From steel:grate_soft
        output = "unilib:misc_fence_steel_soft 4",
        recipe = {
            {c_ingot, "", c_ingot},
            {c_ingot, "", c_ingot},
            {c_ingot, "", c_ingot},
        },
    })
    if unilib.global.pkg_executed_table["material_scrap_steel"] ~= nil then

        unilib.register_craft({
            -- From steel:strut
            output = "unilib:material_scrap_steel 2",
            recipe = {
                {"unilib:misc_fence_steel_soft"},
            },
        })

    end

end
