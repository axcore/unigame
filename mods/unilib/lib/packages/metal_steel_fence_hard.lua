---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    steel
-- Code:    GPL-2.0
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_steel_fence_hard = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.steel.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_steel_fence_hard.init()

    return {
        description = "Hardened steel fence",
        depends = "metal_steel_fence_soft",
        optional = "metal_steel_scrap",
    }

end

function unilib.pkg.metal_steel_fence_hard.exec()

    unilib.register_node("unilib:metal_steel_fence_hard", "steel:grate_hard", mode, {
        -- From steel:grate_hard
        description = S("Hardened Steel Fence"),
        tiles = {"unilib_metal_steel_fence_hard.png"},
        -- N.B. dig_stone = 1 in original code
        groups = {choppy = 1, cracky = 1},
        -- N.B. "wood" in original code
        sounds = unilib.sound_table.metal,

        drawtype = "fencelike",
        inventory_image = "unilib_metal_steel_fence_hard_inv.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
        },
        wield_image = "unilib_metal_steel_fence_hard_inv.png",
    })
    unilib.register_craft({
        -- From steel:grate_hard
        type = "cooking",
        output = "unilib:metal_steel_fence_hard",
        recipe = "unilib:metal_steel_fence_soft",
    })
    if unilib.pkg_executed_table["metal_steel_scrap"] ~= nil then

        unilib.register_craft({
            -- From steel:strut
            output = "unilib:metal_steel_scrap 2",
            recipe = {
                {"unilib:metal_steel_fence_hard"},
            },
        })

    end

end
