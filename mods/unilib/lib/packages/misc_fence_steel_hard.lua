---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    steel
-- Code:    GPL-2.0
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_fence_steel_hard = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.steel.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_fence_steel_hard.init()

    return {
        description = "Hardened steel fence",
        depends = "misc_fence_steel_soft",
        optional = "material_scrap_steel",
    }

end

function unilib.pkg.misc_fence_steel_hard.exec()

    unilib.register_node("unilib:misc_fence_steel_hard", "steel:grate_hard", mode, {
        -- From steel:grate_hard
        description = S("Hardened Steel Fence"),
        tiles = {"unilib_misc_fence_steel_hard.png"},
        -- N.B. dig_stone = 1 in original code
        groups = {choppy = 1, cracky = 1},
        -- N.B. "wood" in original code
        sounds = unilib.global.sound_table.metal,

        drawtype = "fencelike",
        inventory_image = "unilib_misc_fence_steel_hard_inv.png",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
        },
        wield_image = "unilib_misc_fence_steel_hard_inv.png",
    })
    unilib.register_craft({
        -- From steel:grate_hard
        type = "cooking",
        output = "unilib:misc_fence_steel_hard",
        recipe = "unilib:misc_fence_steel_soft",
    })
    if unilib.global.pkg_executed_table["material_scrap_steel"] ~= nil then

        unilib.register_craft({
            -- From steel:strut
            output = "unilib:material_scrap_steel 2",
            recipe = {
                {"unilib:misc_fence_steel_hard"},
            },
        })

    end

end
