---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_obsidian = {}

local S = unilib.intllib
local default_add_mode = unilib.global.imported_mod_table.default.add_mode
local moreblocks_add_mode = unilib.global.imported_mod_table.moreblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_obsidian.init()

    return {
        description = "Obsidian glass",
        depends = "stone_obsidian",
        optional = "mineral_mese",
    }

end

function unilib.pkg.glass_obsidian.exec()

    unilib.register_node("unilib:glass_obsidian", "default:obsidian_glass", default_add_mode, {
        -- From default:obsidian_glass
        description = S("Obsidian Glass"),
        tiles = {"unilib_glass_obsidian.png", "unilib_glass_obsidian_detail.png"},
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.glass,

        drawtype = "glasslike_framed_optional",
        is_ground_content = false,
        paramtype = "light",
        sunlight_propagates = true,
        -- Notes from default:
        -- Only needed for stairs API
        use_texture_alpha = "clip",
    })
    unilib.register_craft({
        -- From default:obsidian_glass
        type = "cooking",
        output = "unilib:glass_obsidian",
        recipe = "unilib:stone_obsidian_shard",
    })
    if unilib.setting.mtgame_tweak_flag and
            unilib.global.pkg_executed_table["mineral_mese"] ~= nil and
            (moreblocks_add_mode ~= "defer" or not core.get_modpath("moreblocks")) then

        unilib.register_glass_trap({
            -- From moreblocks:trap_obsidian_glass. Creates unilib:glass_obsidian_trap
            orig_name = "moreblocks:trap_obsidian_glass",
            ingredient = "unilib:glass_obsidian",
            replace_mode = moreblocks_add_mode,
            group_table = {cracky = 3, oddly_breakable_by_hand = 3},
        })

    end

    -- Note from default:
    -- Glass stair nodes need to be registered individually to utilise specialised textures
    unilib.register_stairs("unilib:glass_obsidian", {
        basic_flag = true,          -- Create only stairs from minetest_game/stairs
    })
    -- (The stairs were not created if unilib.setting.add_stairs_basic_flag is false)
    if core.registered_nodes["unilib:glass_obsidian_stair_simple"] ~= nil then

        unilib.override_item("unilib:glass_obsidian_stair_simple", {
            tiles = {
                "unilib_glass_obsidian_stair_split.png",
                "unilib_glass_obsidian.png",
                "unilib_glass_obsidian_stair_side.png^[transformFX",
                "unilib_glass_obsidian_stair_side.png",
                "unilib_glass_obsidian.png",
                "unilib_glass_obsidian_stair_split.png",
            },
        })
        unilib.override_item("unilib:glass_obsidian_stair_inner", {
            tiles = {
                "unilib_glass_obsidian_stair_side.png^[transformR270",
                "unilib_glass_obsidian.png",
                "unilib_glass_obsidian_stair_side.png^[transformFX",
                "unilib_glass_obsidian.png",
                "unilib_glass_obsidian.png",
                "unilib_glass_obsidian_stair_side.png",
            },
        })
        unilib.override_item("unilib:glass_obsidian_stair_outer", {
            tiles = {
                "unilib_glass_obsidian_stair_side.png^[transformR90",
                "unilib_glass_obsidian.png",
                "unilib_glass_obsidian_stair_outer.png",
                "unilib_glass_obsidian_stair_side.png",
                "unilib_glass_obsidian_stair_side.png^[transformR90",
                "unilib_glass_obsidian_stair_outer.png",
            },
        })
        unilib.override_item("unilib:glass_obsidian_stair_slab", {
            tiles = {
                "unilib_glass_obsidian.png",
                "unilib_glass_obsidian.png",
                "unilib_glass_obsidian_stair_split.png",
            },
        })

    end
    unilib.register_carvings("unilib:glass_obsidian", {
        millwork_flag = true,
    })

end
