---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    tsm_pyramids
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_tsm_pyramids_engravings = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_tsm_pyramids_engravings.do_engravings(base, ingredient)

    -- Create a set of six engravings on the node whose name is "base" (e.g.
    --      "unilib:stone_sandstone_ordinary"), with craft recipes using "ingredient" (e.g.
    --      "unilib:sand_ordinary)
    -- "base" and "ingredient" should be different nodes, as the craft recipes use several
    --      "ingredients" to create one engraved "base"

    local eye_orig_name, man_orig_name, sun_orig_name
    local ankh_orig_name, scarab_orig_name, cactus_orig_name

    local base_def_table = core.registered_nodes[base]
    if base_def_table == nil then
        return
    end

    local base_img = base_def_table.tiles[1]

    if base == "unilib:stone_sandstone_ordinary" then
        eye_orig_name = "tsm_pyramids:deco_stone1"
    end

    unilib.register_node(base .. "_with_engraving_eye", eye_orig_name, mode, {
        -- From tsm_pyramids:deco_stone1
        description = unilib.utils.brackets(base_def_table.description, S("Eye Engraving")),
        tiles = {base_img .. "^unilib_stone_engraving_eye_overlay.png"},
        groups = {cracky = 3, crumbly = 2},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- Original to unilib
        output = base .. "_with_engraving_eye",
        recipe = {
            {ingredient, "unilib:dye_blue", ingredient},
            {"unilib:dye_blue", ingredient, "unilib:dye_blue"},
            {ingredient, "unilib:dye_blue", ingredient},
        },
    })

    if base == "unilib:stone_sandstone_ordinary" then
        man_orig_name = "tsm_pyramids:deco_stone2"
    end

    unilib.register_node(base .. "_with_engraving_man", man_orig_name, mode, {
        -- From tsm_pyramids:deco_stone2
        description = unilib.utils.brackets(base_def_table.description, S("Man Engraving")),
        tiles = {base_img .. "^unilib_stone_engraving_man_overlay.png"},
        groups = {cracky = 3, crumbly = 2},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- Original to unilib
        output = base .. "_with_engraving_man",
        recipe = {
            {ingredient, "unilib:dye_brown", ingredient},
            {ingredient, "unilib:dye_brown", ingredient},
            {"unilib:dye_brown", ingredient, "unilib:dye_brown"},
        },
    })

    if base == "unilib:stone_sandstone_ordinary" then
        sun_orig_name = "tsm_pyramids:deco_stone3"
    end

    unilib.register_node(base .. "_with_engraving_sun", sun_orig_name, mode, {
        -- From tsm_pyramids:deco_stone3
        description = unilib.utils.brackets(base_def_table.description, S("Sun Engraving")),
        tiles = {base_img .. "^unilib_stone_engraving_sun_overlay.png"},
        groups = {cracky = 3, crumbly = 2},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- Original to unilib
        output = base .. "_with_engraving_sun",
        recipe = {
            {ingredient, "unilib:dye_yellow", ingredient},
            {"unilib:dye_yellow", ingredient, "unilib:dye_yellow"},
            {ingredient, "unilib:dye_yellow", ingredient},
        },
    })

    if base == "unilib:stone_sandstone_desert" then
        ankh_orig_name = "tsm_pyramids:deco_stone4"
    end

    unilib.register_node(base .. "_with_engraving_ankh", ankh_orig_name, mode, {
        -- From tsm_pyramids:deco_stone4
        description = unilib.utils.brackets(base_def_table.description, S("Ankh Engraving")),
        tiles = {base_img .. "^unilib_stone_engraving_ankh_overlay.png"},
        groups = {cracky = 3, crumbly = 2},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- Original to unilib
        output = base .. "_with_engraving_ankh",
        recipe = {
            {ingredient, "unilib:dye_white", ingredient},
            {"unilib:dye_white", ingredient, "unilib:dye_white"},
            {ingredient, "unilib:dye_white", ingredient},
        },
    })

    if base == "unilib:stone_sandstone_desert" then
        scarab_orig_name = "tsm_pyramids:deco_stone5"
    end

    unilib.register_node(base .. "_with_engraving_scarab", scarab_orig_name, mode, {
        -- From tsm_pyramids:deco_stone5
        description = unilib.utils.brackets(base_def_table.description, S("Scarab Engraving")),
        tiles = {base_img .. "^unilib_stone_engraving_scarab_overlay.png"},
        groups = {cracky = 3, crumbly = 2},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- Original to unilib
        output = base .. "_with_engraving_scarab",
        recipe = {
            {ingredient, "unilib:dye_red", ingredient},
            {"unilib:dye_red", ingredient, "unilib:dye_red"},
            {ingredient, "unilib:dye_red", ingredient},
        },
    })

    if base == "unilib:stone_sandstone_desert" then
        cactus_orig_name = "tsm_pyramids:deco_stone6"
    end

    unilib.register_node(base .. "_with_engraving_cactus", cactus_orig_name, mode, {
        -- From tsm_pyramids:deco_stone6
        description = unilib.utils.brackets(base_def_table.description, S("Cactus Engraving")),
        tiles = {base_img .. "^unilib_stone_engraving_cactus_overlay.png"},
        groups = {cracky = 3, crumbly = 2},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- Original to unilib
        output = base .. "_with_engraving_cactus",
        recipe = {
            {"unilib:dye_green", ingredient, "unilib:dye_green"},
            {ingredient, "unilib:dye_green", ingredient},
            {ingredient, "unilib:dye_green", ingredient},
        },
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_tsm_pyramids_engravings.init()

    return {
        description = "Shared functions for sandstone engravings (from tsm_pyramids mod)",
        notes = "This package is designed for use with sandstones, but it could be used with" ..
                " other types of stone, or even completely different materials, if desired",
        depends = "dye_basic",
    }

end
