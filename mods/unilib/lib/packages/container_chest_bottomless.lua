---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    twchests
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.container_chest_bottomless = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.twchests.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_chest_bottomless.init()

    return {
        description = "Bottomless chest",
        notes = "A lockable chest with an infinite capacity. Can be used with skeleton keys",
        depends = {
            "container_chest_ordinary",
            "metal_steel",
            "mineral_diamond",
            "shared_default_chest",
        },
        optional = {"metal_bronze", "metal_copper", "metal_gold"},
    }

end

function unilib.pkg.container_chest_bottomless.exec()

    local c_ord_chest = "unilib:container_chest_ordinary"
    local c_diamond = "unilib:mineral_diamond_block"
    local grid_x = 12
    local grid_y = 5

    unilib.pkg.shared_default_chest.register_chest({
        -- Original to unilib. Creates unilib:container_chest_bottomless
        part_name = "bottomless",
        orig_name_list = {nil, nil},
        def_table = {
            description = S("Bottomless Chest"),
            tiles = {
                "unilib_container_chest_bottomless_top.png",
                "unilib_container_chest_bottomless_top.png",
                "unilib_container_chest_bottomless_side.png",
                "unilib_container_chest_bottomless_side.png",
                "unilib_container_chest_bottomless_front.png",
                "unilib_container_chest_bottomless_inside.png",
            },
            groups = {choppy = 2, oddly_breakable_by_hand = 2},
            sounds = unilib.global.sound_table.wood,

            sound_close = "unilib_chest_close",
            sound_open = "unilib_chest_open",
        },

        replace_mode = mode,
        grid_x = grid_x,
        grid_y = grid_y,
        large_flag = true,
        max_pages = 0,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:container_chest_bottomless",
        recipe = {
            {c_diamond, c_ord_chest, c_diamond},
            {c_ord_chest, "", c_ord_chest},
            {c_diamond, c_ord_chest, c_diamond},
        },
    })
    unilib.register_craft({
        -- Original to unilib
        type = "fuel",
        recipe = "unilib:container_chest_bottomless",
        burntime = 60,
    })

    unilib.pkg.shared_default_chest.register_chest({
        -- Original to unilib. Creates unilib:container_chest_bottomless_locked
        part_name = "bottomless_locked",
        orig_name_list = {nil, nil},
        def_table = {
            description = S("Locked Bottomless Chest"),
            tiles = {
                "unilib_container_chest_bottomless_top.png",
                "unilib_container_chest_bottomless_top.png",
                "unilib_container_chest_bottomless_side.png",
                "unilib_container_chest_bottomless_side.png",
                "unilib_container_chest_bottomless_locked.png",
                "unilib_container_chest_bottomless_inside.png",
            },
            groups = {choppy = 2, oddly_breakable_by_hand = 2},
            sounds = unilib.global.sound_table.wood,

            protected = true,
            sound_close = "unilib_chest_close",
            sound_open = "unilib_chest_open",
        },

        replace_mode = mode,
        grid_x = grid_x,
        grid_y = grid_y,
        large_flag = true,
        max_pages = 0,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:container_chest_bottomless_locked",
        recipe = {
            {c_diamond, c_ord_chest, c_diamond},
            {c_ord_chest, "unilib:metal_steel_ingot", c_ord_chest},
            {c_diamond, c_ord_chest, c_diamond},
        },
    })
    unilib.register_craft({
        -- Original to unilib
        type = "shapeless",
        output = "unilib:container_chest_bottomless_locked",
        recipe = {"unilib:container_chest_bottomless", "unilib:metal_steel_ingot"},
    })
    if unilib.setting.mtgame_tweak_flag then

        if unilib.global.pkg_executed_table["metal_bronze"] ~= nil then

            unilib.register_craft({
                -- From moreblocks
                type = "shapeless",
                output = "unilib:container_chest_bottomless_locked",
                recipe = {"unilib:container_chest_bottomless", "unilib:metal_bronze_ingot"},
            })

        end

        if unilib.global.pkg_executed_table["metal_copper"] ~= nil then

            unilib.register_craft({
                -- From moreblocks
                type = "shapeless",
                output = "unilib:container_chest_bottomless_locked",
                recipe = {"unilib:container_chest_bottomless", "unilib:metal_copper_ingot"},
            })

        end

        if unilib.global.pkg_executed_table["metal_gold"] ~= nil then

            unilib.register_craft({
                -- From moreblocks
                type = "shapeless",
                output = "unilib:container_chest_bottomless_locked",
                recipe = {"unilib:container_chest_bottomless", "unilib:metal_gold_ingot"},
            })

        end

    end
    unilib.register_craft({
        -- From default:chest_locked
        type = "fuel",
        recipe = "unilib:container_chest_bottomless_locked",
        burntime = 60,
    })

end
