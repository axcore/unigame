---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_leafstone = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_leafstone.init()

    return {
        description = "Leafstone",
        depends = "gravel_mossy",
        optional = "metal_tin",
    }

end

function unilib.pkg.stone_leafstone.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "leafstone",
        description = S("Leafstone"),

        category = "other",
        fictional_flag = true,
        grinder_flag = false,
        hardness = 1,
        not_super_flag = true,
    })

    unilib.register_node("unilib:stone_leafstone", "underch:leafstone", mode, {
        -- From underch:leafstone
        description = S("Leafstone"),
        tiles = {"unilib_stone_leafstone.png"},
        groups = {cracky = 3, stone = 1},
        sounds = unilib.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- From underch:leafstone
        type = "cooking",
        output = "unilib:stone_leafstone",
        recipe = "unilib:gravel_mossy",
    })
    --[[
    unilib.register_stairs("unilib:stone_leafstone", {
        group_type = "smooth",
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "leafstone",

        drop_name = "unilib:stone_leafstone",
    })

    if unilib.pkg_executed_table["metal_tin"] ~= nil then

        local c_ingot = "unilib:metal_tin_ingot"
        local c_leafstone = "unilib:stone_leafstone"

        unilib.register_node("unilib:stone_leafstone_light", "underch:light_leafstone", mode, {
            -- From underch:light_leafstone
            description = S("Light Leafstone"),
            tiles = {"unilib_stone_leafstone_light.png"},
            groups = {cracky = 3, stone = 1},
            sounds = unilib.sound_table.stone,

            is_ground_content = false,
        })
        unilib.register_craft({
            type = "shapeless",
            output = "unilib:stone_leafstone_light 5",
            recipe = {
                c_ingot, c_ingot, c_ingot, c_ingot,
                c_leafstone, c_leafstone, c_leafstone, c_leafstone,
            },
        })
        if unilib.super_stone_table["leafstone"] ~= nil then
            unilib.register_stairs("unilib:stone_leafstone_light")
        end

    end

    -- (no block/brick/cobble/rubble variants)

end
