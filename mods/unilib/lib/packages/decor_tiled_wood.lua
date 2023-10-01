---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_tiled_wood = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_tiled_wood.init()

    return {
        description = "Decorative wood tiles",
        notes = "The moreblocks nodes marked \"deprecated\" are not included",
        optional = "item_stick_ordinary",
    }

end

function unilib.pkg.decor_tiled_wood.exec()

    local wood_img = "unilib_tree_apple_wood.png"
    local tile_img = "unilib_decor_tiled_wood_overlay.png"
    local full_img = "unilib_decor_tiled_wood_full.png"

    unilib.register_node("unilib:decor_tiled_wood", "moreblocks:wood_tile", mode, {
        -- From moreblocks:wood_tile
        description = S("Decorative Wood Tile"),
        tiles = {
            wood_img .. "^" .. tile_img,
            wood_img .. "^" .. tile_img,
            wood_img .. "^" .. tile_img,
            wood_img .. "^" .. tile_img,
            wood_img .. "^" .. tile_img .. "^[transformR90",
            wood_img .. "^" .. tile_img .. "^[transformR90",
        },
        groups = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
        sounds = unilib.sound_table.wood,

        is_ground_content = false,
        paramtype2 = "facedir",
        place_param2 = 0,
    })
    -- N.B. Original craft recipe conflicts with recipe in "shared_fachwerk" package
    --[[
    unilib.register_craft({
        output = "unilib:decor_tiled_wood 9",
        -- From moreblocks:wood_tile
        recipe = {
            {"group:wood", "group:wood", "group:wood"},
            {"group:wood", "group:wood", "group:wood"},
            {"group:wood", "group:wood", "group:wood"},
        }
    })
    ]]--
    unilib.register_craft({
        output = "unilib:decor_tiled_wood 8",
        -- From moreblocks:wood_tile
        recipe = {
            {"group:wood", "group:wood", "group:wood"},
            {"group:wood", "unilib:item_stick_ordinary", "group:wood"},
            {"group:wood", "group:wood", "group:wood"},
        }
    })
    unilib.register_stairs("unilib:decor_tiled_wood")

    unilib.register_node(
        "unilib:decor_tiled_wood_centre",
        "moreblocks:wood_tile_center",
        mode,
        {
            -- From moreblocks:wood_tile_center
            description = S("Decorative Centred Wood Tile"),
            tiles = {wood_img .. "^unilib_decor_tiled_wood_centre_overlay.png"},
            groups = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
            sounds = unilib.sound_table.wood,

            is_ground_content = false,
        }
    )
    -- Notes from moreblocks:
    -- This must be registered after "moreblocks:wood_tile" to avoid recipe conflicts, since
    --      "moreblocks:wood_tile" is part of "group:wood"
    -- N.B. Output was 9 in original code; here it is 8, to match the modified craft recipe above
    unilib.register_craft({
        -- From moreblocks:wood_tile_center
        output = "unilib:decor_tiled_wood_centre 8",
        recipe = {
            {"group:wood", "group:wood", "group:wood"},
            {"group:wood", "unilib:decor_tiled_wood", "group:wood"},
            {"group:wood", "group:wood", "group:wood"},
        }
    })
    unilib.register_stairs("unilib:decor_tiled_wood_centre")

    unilib.register_node("unilib:decor_tiled_wood_full", "moreblocks:wood_tile_full", mode, {
        -- From moreblocks:wood_tile_full
        description = S("Decorative Full Wood Tile"),
        tiles = {
            wood_img .. "^" .. full_img,
            wood_img .. "^" .. full_img,
            wood_img .. "^" .. full_img,
            wood_img .. "^" .. full_img,
            wood_img .. "^" .. full_img .. "^[transformR90",
            wood_img .. "^" .. full_img .. "^[transformR90",
        },
        groups = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
        sounds = unilib.sound_table.wood,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- From moreblocks:wood_tile_full
        output = "unilib:decor_tiled_wood_full 4",
        recipe = {
            {"unilib:decor_tiled_wood", "unilib:decor_tiled_wood"},
            {"unilib:decor_tiled_wood", "unilib:decor_tiled_wood"},
        }
    })
    unilib.register_stairs("unilib:decor_tiled_wood_full")

    if unilib.pkg_executed_table["item_stick_ordinary"] ~= nil then

        unilib.register_node(
            "unilib:decor_tiled_wood_offset",
            "moreblocks:wood_tile_offset",
            mode,
            {
                -- From moreblocks:wood_tile_offset
                description = S("Decorative Offset Wood Tile"),
                tiles = {wood_img .. "^unilib_decor_tiled_wood_offset_overlay.png"},
                groups = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
                sounds = unilib.sound_table.wood,

                is_ground_content = false,
                paramtype2 = "facedir",
                place_param2 = 0,
            }
        )
        unilib.register_craft({
            -- From moreblocks:wood_tile_offset
            output = "unilib:decor_tiled_wood_offset",
            recipe = {
                {"unilib:item_stick_ordinary"},
                {"unilib:decor_tiled_wood_centre"},
            }
        })

    end

end
