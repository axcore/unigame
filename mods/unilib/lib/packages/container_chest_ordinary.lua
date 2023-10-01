---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.container_chest_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_chest_ordinary.init()

    return {
        description = "Ordinary lockable chest",
        notes = "A lockable chest with a capacity of 8x4. Can be used with skeleton keys",
        depends = {"metal_steel", "shared_default_chest"},
        optional = {"metal_bronze", "metal_copper", "metal_gold"},
    }

end

function unilib.pkg.container_chest_ordinary.exec()

    -- N.B. This function has only been adapted for the "container_chest_ordinary" package; it will
    --      not work as a general chest-creating function
    unilib.pkg.shared_default_chest.register_chest({
        -- From default:chest. Creates unilib:container_chest_ordinary
        part_name = "ordinary",
        orig_name = {"default:chest", "default:chest_open"},
        def_table = {
            description = S("Ordinary Chest"),
            tiles = {
                "unilib_container_chest_ordinary_top.png",
                "unilib_container_chest_ordinary_top.png",
                "unilib_container_chest_ordinary_side.png",
                "unilib_container_chest_ordinary_side.png",
                "unilib_container_chest_ordinary_front.png",
                "unilib_container_chest_ordinary_inside.png",
            },
            groups = {choppy = 2, oddly_breakable_by_hand = 2},
            sounds = unilib.sound_table.wood,

            sound_close = "unilib_chest_close",
            sound_open = "unilib_chest_open",
        },

        replace_mode = mode,
    })
    unilib.register_craft({
        -- From default:chest
        output = "unilib:container_chest_ordinary",
        recipe = {
            {"group:wood", "group:wood", "group:wood"},
            {"group:wood", "", "group:wood"},
            {"group:wood", "group:wood", "group:wood"},
        }
    })
    unilib.register_craft({
        -- From default:chest
        type = "fuel",
        recipe = "unilib:container_chest_ordinary",
        burntime = 30,
    })

    unilib.pkg.shared_default_chest.register_chest({
        -- From default:chest_locked. Creates unilib:container_chest_ordinary_locked
        part_name = "ordinary_locked",
        orig_name = {"default:chest_locked", "default:chest_locked_open"},
        def_table = {
            description = S("Locked Ordinary Chest"),
            tiles = {
                "unilib_container_chest_ordinary_top.png",
                "unilib_container_chest_ordinary_top.png",
                "unilib_container_chest_ordinary_side.png",
                "unilib_container_chest_ordinary_side.png",
                "unilib_container_chest_ordinary_locked.png",
                "unilib_container_chest_ordinary_inside.png",
            },
            groups = {choppy = 2, oddly_breakable_by_hand = 2},
            sounds = unilib.sound_table.wood,

            protected = true,
            sound_close = "unilib_chest_close",
            sound_open = "unilib_chest_open",
        },

        replace_mode = mode,
    })
    unilib.register_craft({
        -- From default:chest_locked
        output = "unilib:container_chest_ordinary_locked",
        recipe = {
            {"group:wood", "group:wood", "group:wood"},
            {"group:wood", "unilib:metal_steel_ingot", "group:wood"},
            {"group:wood", "group:wood", "group:wood"},
        }
    })
    unilib.register_craft({
        -- From default:chest_locked
        type = "shapeless",
        output = "unilib:container_chest_ordinary_locked",
        recipe = {"unilib:container_chest_ordinary", "unilib:metal_steel_ingot"},
    })
    if unilib.mtgame_tweak_flag then

        if unilib.pkg_executed_table["metal_bronze"] ~= nil then

            unilib.register_craft({
                -- From moreblocks
                type = "shapeless",
                output = "unilib:container_chest_ordinary_locked",
                recipe = {"unilib:container_chest_ordinary", "unilib:metal_bronze_ingot"},
            })

        end

        if unilib.pkg_executed_table["metal_copper"] ~= nil then

            unilib.register_craft({
                -- From moreblocks
                type = "shapeless",
                output = "unilib:container_chest_ordinary_locked",
                recipe = {"unilib:container_chest_ordinary", "unilib:metal_copper_ingot"},
            })

        end

        if unilib.pkg_executed_table["metal_gold"] ~= nil then

            unilib.register_craft({
                -- From moreblocks
                type = "shapeless",
                output = "unilib:container_chest_ordinary_locked",
                recipe = {"unilib:container_chest_ordinary", "unilib:metal_gold_ingot"},
            })

        end

    end
    unilib.register_craft({
        -- From default:chest_locked
        type = "fuel",
        recipe = "unilib:container_chest_ordinary_locked",
        burntime = 30,
    })

end
