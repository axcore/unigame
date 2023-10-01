---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    steel
-- Code:    GPL-2.0
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_steel_fence_soft = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.steel.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_steel_fence_soft.init()

    return {
        description = "Soft steel fence",
        depends = "metal_steel",
        optional = "metal_steel_scrap",
    }

end

function unilib.pkg.metal_steel_fence_soft.exec()

    local c_ingot = "unilib:metal_steel_ingot"

    unilib.register_node("unilib:metal_steel_fence_soft", "steel:grate_soft", mode, {
        -- From steel:grate_soft
        description = S("Soft Steel Fence"),
        tiles = {"unilib_metal_steel_fence_soft.png"},
        -- N.B. dig_stone = 1 in original code
        groups = {choppy = 2, cracky = 2},
        -- N.B. "wood" in original code
        sounds = unilib.sound_table.metal,

        drawtype = "fencelike",
        inventory_image = "unilib_metal_steel_fence_soft_inv.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
        },
        wield_image = "unilib_metal_steel_fence_soft_inv.png",
    })
    unilib.register_craft({
        -- From steel:grate_soft
        output = "unilib:metal_steel_fence_soft 3",
        recipe = {
            {c_ingot, "", c_ingot},
            {c_ingot, "", c_ingot},
        },
    })
    if unilib.pkg_executed_table["metal_steel_scrap"] ~= nil then

        unilib.register_craft({
            -- From steel:strut
            output = "unilib:metal_steel_scrap 2",
            recipe = {
                {"unilib:metal_steel_fence_soft"},
            },
        })

    end

end
