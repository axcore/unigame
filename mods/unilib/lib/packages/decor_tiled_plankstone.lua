---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_tiled_plankstone = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_tiled_plankstone.init()

    return {
        description = "Decorative plankstone tiles",
        optional = "item_stick_ordinary",
    }

end

function unilib.pkg.decor_tiled_plankstone.exec()

    local wood_img = "unilib_tree_apple_wood.png"
    local tile_img = "unilib_decor_tiled_plankstone_overlay.png"
    local full_img = "unilib_decor_tiled_plankstone_full.png"

    unilib.register_node("unilib:decor_tiled_plankstone", "moreblocks:plankstone", mode, {
        -- From moreblocks:plankstone
        description = S("Decorative Plankstone Tile"),
        tiles = {
            wood_img .. "^" .. tile_img,
            wood_img .. "^" .. tile_img,
            wood_img .. "^" .. tile_img,
            wood_img .. "^" .. tile_img,
            wood_img .. "^" .. tile_img .. "^[transformR90",
            wood_img .. "^" .. tile_img .. "^[transformR90",
        },
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
        paramtype2 = "facedir",
        place_param2 = 0,
    })
    unilib.register_craft({
        -- From moreblocks:plankstone
        output = "unilib:decor_tiled_plankstone 4",
        recipe = {
            {"group:stone", "group:wood"},
            {"group:wood", "group:stone"},
        },
    })
    unilib.register_craft({
        -- From moreblocks:plankstone
        output = "unilib:decor_tiled_plankstone 4",
        recipe = {
            {"group:wood", "group:stone"},
            {"group:stone", "group:wood"},
        },
    })
    unilib.register_stairs("unilib:decor_tiled_plankstone", {
        img_rotate_flag = true,
    })

    unilib.register_node("unilib:decor_tiled_plankstone_centre", nil, mode, {
        -- Original to unilib
        description = S("Decorative Centred Plankstone Tile"),
        tiles = {wood_img .. "^unilib_decor_tiled_plankstone_centre_overlay.png"},
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:decor_tiled_plankstone_centre 9",
        recipe = {
            {"group:wood", "group:wood", "group:wood"},
            {"group:wood", "unilib:decor_tiled_plankstone", "group:wood"},
            {"group:wood", "group:wood", "group:wood"},
        },
    })
    unilib.register_stairs("unilib:decor_tiled_plankstone_centre")

    if unilib.global.pkg_executed_table["item_stick_ordinary"] ~= nil then

        unilib.register_node("unilib:decor_tiled_plankstone_offset", nil, mode, {
            -- Original to unilib
            description = S("Decorative Offset Plankstone Tile"),
            tiles = {wood_img .. "^unilib_decor_tiled_plankstone_offset_overlay.png"},
            groups = {cracky = 3},
            sounds = unilib.global.sound_table.stone,

            is_ground_content = false,
        })
        unilib.register_craft({
            -- Original to unilib
            output = "unilib:decor_tiled_plankstone_offset",
            recipe = {
                {"unilib:item_stick_ordinary"},
                {"unilib:decor_tiled_plankstone_centre"},
            },
        })

    end

end
