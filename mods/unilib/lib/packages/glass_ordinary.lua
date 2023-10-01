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
--
-- From:    vessels
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_ordinary = {}

local S = unilib.intllib
local default_add_mode = unilib.imported_mod_table.default.add_mode
local moreblocks_add_mode = unilib.imported_mod_table.moreblocks.add_mode
local vessels_add_mode = unilib.imported_mod_table.vessels.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_ordinary.init()

    return {
        description = "Ordinary glass",
        notes = "Glass vessels can be recycled by crafting glass fragments, then cooking them",
        optional = "mineral_mese",
    }

end

function unilib.pkg.glass_ordinary.exec()

    unilib.register_node("unilib:glass_ordinary", "default:glass", default_add_mode, {
        -- From default:glass
        description = S("Ordinary Glass"),
        tiles = {"unilib_glass_ordinary.png", "unilib_glass_ordinary_detail.png"},
        groups = {cracky = 3, oddly_breakable_by_hand = 3},
        sounds = unilib.sound_table.glass,

        drawtype = "glasslike_framed_optional",
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "glasslikeliquidlevel",
        sunlight_propagates = true,
        -- Notes from default:
        -- Only needed for stairs API
        use_texture_alpha = "clip",
    })
    unilib.register_craft({
        -- From default:glass
        type = "cooking",
        output = "unilib:glass_ordinary",
        recipe = "group:sand",
    })
    if vessels_add_mode ~= "defer" then

        unilib.register_craft({
            -- From vessels:glass_fragments
            type = "cooking",
            output = "unilib:glass_ordinary",
            recipe = "unilib:glass_ordinary_fragments",
        })

    end
    if unilib.mtgame_tweak_flag and
            unilib.pkg_executed_table["mineral_mese"] ~= nil and
            moreblocks_add_mode ~= "defer" then

        unilib.register_glass_trap({
            -- From moreblocks:trap_glass. Creates unilib:glass_ordinary_trap
            orig_name = "moreblocks:trap_glass",
            ingredient = "unilib:glass_ordinary",
            replace_mode = moreblocks_add_mode,
            group_table = {cracky = 3, oddly_breakable_by_hand = 3},
        })

    end

    -- Notes from default:
    -- Glass stair nodes need to be registered individually to utilize specialised textures
    unilib.register_stairs("unilib:glass_ordinary", {
        basic_flag = true,          -- Create only stairs from minetest_game/stairs
        img_rotate_flag = true,
    })
    -- (The stairs were not created if unilib.add_stairs_basic_flag is false)
    if minetest.registered_nodes["unilib:glass_ordinary_stair_simple"] ~= nil then

        unilib.override_item("unilib:glass_ordinary_stair_simple", {
            tiles = {
                "unilib_glass_ordinary_stair_split.png",
                "unilib_glass_ordinary.png",
                "unilib_glass_ordinary_stair_side.png^[transformFX",
                "unilib_glass_ordinary_stair_side.png",
                "unilib_glass_ordinary.png",
                "unilib_glass_ordinary_stair_split.png",
            },
        })
        unilib.override_item("unilib:glass_ordinary_stair_inner", {
            tiles = {
                "unilib_glass_ordinary_stair_side.png^[transformR270",
                "unilib_glass_ordinary.png",
                "unilib_glass_ordinary_stair_side.png^[transformFX",
                "unilib_glass_ordinary.png",
                "unilib_glass_ordinary.png",
                "unilib_glass_ordinary_stair_side.png",
            },
        })
        unilib.override_item("unilib:glass_ordinary_stair_outer", {
            tiles = {
                "unilib_glass_ordinary_stair_side.png^[transformR90",
                "unilib_glass_ordinary.png",
                "unilib_glass_ordinary_stair_outer.png",
                "unilib_glass_ordinary_stair_side.png",
                "unilib_glass_ordinary_stair_side.png^[transformR90",
                "unilib_glass_ordinary_stair_outer.png",
            },
        })
        unilib.override_item("unilib:glass_ordinary_stair_slab", {
            tiles = {
                "unilib_glass_ordinary.png",
                "unilib_glass_ordinary.png",
                "unilib_glass_ordinary_stair_split.png",
            },
        })

    end
    unilib.register_carvings("unilib:glass_ordinary", {
        millwork_flag = true,
    })

    -- Glass recycling: glass fragments are used with various vessels
    if vessels_add_mode ~= "defer" then

        unilib.register_craftitem(
            -- From vessels:glass_fragments
            "unilib:glass_ordinary_fragments",
            "vessels:glass_fragments",
            vessels_add_mode,
            {
                description = S("Ordinary Glass Fragments"),
                inventory_image = "unilib_glass_ordinary_fragments.png",
            }
        )

    end

    -- This package provides deliberate craft recipe conflicts
    unilib.register_craft_conflicts(
        {"unilib:glass_ordinary", "unilib:stone_obsidian"}
    )

end
