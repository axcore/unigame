---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores_rainbow
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_block_rainbow_stone = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores_rainbow.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_block_rainbow_stone.init()

    return {
        description = "Stone rainbow block",
        depends = {
            "glass_ordinary",
            "metal_adamantite",
            "metal_ozymandium",
            "metal_planexium",
            "metal_rarium",
            "metal_sybilline",
            "mineral_diamond",
            "mineral_mese",
        },
    }

end

function unilib.pkg.decor_block_rainbow_stone.exec()

    unilib.register_node("unilib:decor_block_rainbow_stone", "xtraores_rainbow:rainbow", mode, {
        -- From xtraores_rainbow:rainbow
        description = S("Stone Rainbow Block"),
        tiles = {"unilib_decor_block_rainbow_stone.png"},
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.stone,

        light_source = unilib.constant.light_max - 1,
        -- N.B. is_ground_content = true in original code
        is_ground_content = false,
    })
    unilib.register_craft({
        -- From xtraores_rainbow:rainbow
        output = "unilib:decor_block_rainbow_stone 8",
        recipe = {
            {
                "unilib:metal_adamantite_ingot",
                "unilib:metal_rarium_ingot",
                "unilib:metal_planexium_ingot",
            },
            {
                "unilib:metal_sybilline_ingot",
                "unilib:glass_ordinary",
                "unilib:metal_ozymandium_ingot",
            },
            {
                "unilib:mineral_diamond_gem",
                "unilib:mineral_mese_crystal",
                "unilib:metal_copper_ingot",
            },
        },
    })

end
