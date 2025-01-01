---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_schist_grey = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_schist_grey.init()

    return {
        description = "Grey schist",
        optional = "stone_slate_grey",
    }

end

function unilib.pkg.stone_schist_grey.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "schist_grey",
        description = S("Grey Schist"),

        category = "metamorphic",
        colour = "#82817F",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match cracky groups below, should be 2/3)
        hardness = 1,
        hardness_real = 2,
    })

    local smooth_cracky, block_cracky = unilib.stone.get_adjusted_cracky("schist_grey", 3, nil)

    unilib.register_node("unilib:stone_schist_grey", "darkage:schist", mode, {
        -- From darkage:schist
        description = S("Grey Schist"),
        tiles = {"unilib_stone_schist_grey.png"},
        -- N.B. stone = 1 not in original code
        groups = {cracky = smooth_cracky, smoothstone = 1, stone = 1},
        sounds = unilib.global.sound_table.stone,
    })
    if unilib.global.pkg_executed_table["stone_slate_grey"] ~= nil then

        unilib.register_craft({
            -- From darkage:schist
            type = "cooking",
            output = "unilib:stone_schist_grey",
            recipe = "unilib:stone_slate_grey",
        })

    end
    --[[
    unilib.register_stairs("unilib:stone_schist_grey", {
        drop_name = "unilib:stone_schist_grey_rubble",
        group_type = "smooth",
    })
    unilib.register_carvings("unilib:stone_schist_grey", {
        facade_flag = true,
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "schist_grey",
    })

    unilib.register_stone_block({
        -- Original to unilib. Creates unilib:stone_schist_grey_block
        part_name = "schist_grey",
        orig_name = nil,

        replace_mode = mode,
        description = S("Grey Schist Block"),
        img_list = {"unilib_stone_schist_grey.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Original to unilib. Creates unilib:stone_schist_grey_brick
        part_name = "schist_grey",
        orig_name = nil,

        replace_mode = mode,
        description = S("Grey Schist Bricks"),
        img_list = {"unilib_stone_schist_grey.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_cobble_or_rubble_or_nothing({
        -- Original to unilib. Depending on real hardness, creates unilib:stone_schist_grey_cobble,
        --      or unilib:stone_schist_grey_rubble, or nothing
        part_name = "schist_grey",
        cobble_description = S("Grey Schist Cobble"),
        cobble_compressed_description = S("Compressed Grey Schist Cobble"),
        cobble_condensed_description = S("Condensed Grey Schist Cobble"),
        rubble_description = S("Grey Schist Rubble"),
        rubble_compressed_description = S("Compressed Grey Schist Rubble"),
        rubble_condensed_description = S("Condensed Grey Schist Rubble"),
        smooth_compressed_description = S("Compressed Grey Schist"),
        smooth_condensed_description = S("Condensed Grey Schist"),

        replace_mode = mode,
        override_drop_flag = true,
    })

end
