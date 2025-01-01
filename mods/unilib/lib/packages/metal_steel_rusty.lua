---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_steel_rusty = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_steel_rusty.init()

    return {
        description = "Rusty steel bricks",
        depends = "metal_steel",
        optional = "material_scrap_steel",
    }

end

function unilib.pkg.metal_steel_rusty.exec()

    -- (No call to unilib.register_metal(), as this is not really a new type of metal)

    unilib.register_node("unilib:metal_steel_rusty_brick", "decoblocks:rusty_steel_plating", mode, {
        -- From farlands, decoblocks:rusty_steel_plating
        description = S("Rusty Steel Bricks"),
        tiles = {"unilib_metal_steel_rusty_brick.png"},
        groups = {cracky = 1, level = 2},
        sounds = unilib.global.sound_table.metal,

        -- N.B. is_ground_content = false not in original code; added to match other bricks
        is_ground_content = false,
    })
    if unilib.global.pkg_executed_table["material_scrap_steel"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:material_scrap_steel 4",
            recipe = {
                {"unilib:metal_steel_rusty_brick"},
            },
        })

    end
    unilib.register_stairs("unilib:metal_steel_rusty_brick", {
        img_rotate_flag = true,
    })
    unilib.utils.set_auto_rotate(
        "unilib:metal_steel_rusty_brick", unilib.setting.auto_rotate_brick_flag
    )

end

function unilib.pkg.metal_steel_rusty.post()

    unilib.register_craft({
        -- From farlands, decoblocks:rusty_steel_plating
        type = "shapeless",
        output = "unilib:metal_steel_rusty_brick 4",
        recipe = {
            "unilib:metal_steel_block",
            -- N.B. In original code, group:water_bucket
            "group:craftable_bucket",
        },
        replacements = unilib.global.craftable_bucket_list,
    })

end
