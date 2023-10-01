---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    twchests
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.container_chest_compact = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.twchests.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_chest_compact.init()

    return {
        description = "Compact chest",
        notes = "A lockable chest with a capacity of 3x2. Can be used with skeleton keys",
        depends = {"metal_steel", "shared_default_chest"},
        optional = {"metal_bronze", "metal_copper", "metal_gold"},
    }

end

function unilib.pkg.container_chest_compact.exec()

    local grid_x = 3
    local grid_y = 2

    unilib.pkg.shared_default_chest.register_chest({
        -- Original to unilib. Creates unilib:container_chest_compact
        part_name = "compact",
        orig_name = {},
        def_table = {
            description = S("Compact Chest"),
            tiles = {
                "unilib_container_chest_compact_top.png",
                "unilib_container_chest_compact_top.png",
                "unilib_container_chest_compact_side.png",
                "unilib_container_chest_compact_side.png",
                "unilib_container_chest_compact_front.png",
                "unilib_container_chest_compact_inside.png",
            },
            groups = {choppy = 2, oddly_breakable_by_hand = 2},
            sounds = unilib.sound_table.wood,

            sound_close = "unilib_chest_close",
            sound_open = "unilib_chest_open",
        },

        replace_mode = mode,
        grid_x = grid_x,
        grid_y = grid_y,
    })
    -- N.B. Original craft recipe conflicts with recipe in "decor_tiled_wood" package
    --[[
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:container_chest_compact",
        recipe = {
            {"", "group:wood", ""},
            {"group:wood", "", "group:wood"},
            {"", "group:wood", ""},
        },
    })
    ]]--
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:container_chest_compact",
        recipe = {
            {"group:wood", "", "group:wood"},
            {"", "", ""},
            {"group:wood", "", "group:wood"},
        },
    })
    unilib.register_craft({
        -- Original to unilib
        type = "fuel",
        recipe = "unilib:container_chest_compact",
        burntime = 15,
    })

    unilib.pkg.shared_default_chest.register_chest({
        -- Original to unilib. Creates unilib:container_chest_compact_locked
        part_name = "compact_locked",
        orig_name = {},
        def_table = {
            description = S("Locked Compact Chest"),
            tiles = {
                "unilib_container_chest_compact_top.png",
                "unilib_container_chest_compact_top.png",
                "unilib_container_chest_compact_side.png",
                "unilib_container_chest_compact_side.png",
                "unilib_container_chest_compact_locked.png",
                "unilib_container_chest_compact_inside.png",
            },
            groups = {choppy = 2, oddly_breakable_by_hand = 2},
            sounds = unilib.sound_table.wood,

            protected = true,
            sound_close = "unilib_chest_close",
            sound_open = "unilib_chest_open",
        },

        replace_mode = mode,
        grid_x = grid_x,
        grid_y = grid_y,
    })
    --[[
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:container_chest_compact_locked",
        recipe = {
            {"", "group:wood", ""},
            {"group:wood", "unilib:metal_steel_ingot", "group:wood"},
            {"", "group:wood", ""},
        }
    })
    ]]--
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:container_chest_compact_locked",
        recipe = {
            {"group:wood", "", "group:wood"},
            {"", "unilib:metal_steel_ingot", ""},
            {"group:wood", "", "group:wood"},
        },
    })
    unilib.register_craft({
        -- Original to unilib
        type = "shapeless",
        output = "unilib:container_chest_compact_locked",
        recipe = {"unilib:container_chest_compact", "unilib:metal_steel_ingot"},
    })
    if unilib.mtgame_tweak_flag then

        if unilib.pkg_executed_table["metal_bronze"] ~= nil then

            unilib.register_craft({
                -- From moreblocks
                type = "shapeless",
                output = "unilib:container_chest_compact_locked",
                recipe = {"unilib:container_chest_compact", "unilib:metal_bronze_ingot"},
            })

        end

        if unilib.pkg_executed_table["metal_copper"] ~= nil then

            unilib.register_craft({
                -- From moreblocks
                type = "shapeless",
                output = "unilib:container_chest_compact_locked",
                recipe = {"unilib:container_chest_compact", "unilib:metal_copper_ingot"},
            })

        end

        if unilib.pkg_executed_table["metal_gold"] ~= nil then

            unilib.register_craft({
                -- From moreblocks
                type = "shapeless",
                output = "unilib:container_chest_compact_locked",
                recipe = {"unilib:container_chest_compact", "unilib:metal_gold_ingot"},
            })

        end

    end
    unilib.register_craft({
        -- From default:chest_locked
        type = "fuel",
        recipe = "unilib:container_chest_compact_locked",
        burntime = 15,
    })

end
