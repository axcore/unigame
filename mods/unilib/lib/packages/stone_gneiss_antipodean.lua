---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_gneiss_antipodean = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_gneiss_antipodean.init()

    return {
        description = "Antipodean gneiss",
        optional = {"stone_granite_antipodean", "stone_schist_antipodean"},
    }

end

function unilib.pkg.stone_gneiss_antipodean.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "gneiss_antipodean",
        description = S("Antipodean Gneiss"),

        category = "metamorphic",
        grinder_flag = true,
        hardness = 3,
    })

    unilib.register_node("unilib:stone_gneiss_antipodean", "aotearoa:gneiss", mode, {
        -- From aotearoa:gneiss
        description = S("Antipodean Gneiss"),
        tiles = {"unilib_stone_gneiss_antipodean.png"},
        -- N.B. smoothstone = 1 not in original code
        groups = {cracky = 1, stone = 1},
        sounds = unilib.sound_table.stone,

        -- N.B. drops smoothstone in original code
        drop = "unilib:stone_gneiss_antipodean_cobble",
    })
    if unilib.pkg_executed_table["stone_granite_antipodean"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:gneiss
            type = "cooking",
            output = "unilib:stone_gneiss_antipodean",
            recipe = "unilib:stone_granite_antipodean",
            cooktime = 120,
        })

    end
    if unilib.pkg_executed_table["stone_schist_antipodean"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:gneiss
            type = "cooking",
            output = "unilib:stone_gneiss_antipodean",
            recipe = "unilib:stone_schist_antipodean",
            cooktime = 120,
        })

    end
    --[[
    unilib.register_stairs("unilib:stone_gneiss_antipodean", {
        basic_flag = true,
        drop_name = "unilib:stone_gneiss_antipodean_cobble",
        group_type = "smooth",
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "gneiss_antipodean",

        drop_name = "unilib:stone_gneiss_antipodean_cobble",
    })

    unilib.register_node("unilib:stone_gneiss_antipodean_block", "aotearoa:gneiss_block", mode, {
        -- From aotearoa:gneiss_block
        description = S("Antipodean Gneiss"),
        tiles = {"unilib_stone_gneiss_antipodean_block.png"},
        -- N.B. stoneblock = 1 not in original code
        groups = {cracky = 1, stone = 1, stoneblock = 1},
        sounds = unilib.sound_table.stone,
    })
    unilib.register_craft_3x3x9({
        -- From aotearoa:gneiss_block
        output = "unilib:stone_gneiss_antipodean_block",
        ingredient = "unilib:stone_gneiss_antipodean",
    })
    --[[
    unilib.register_stairs("unilib:stone_gneiss_antipodean_block", {
        basic_flag = true,
    })
    ]]--
    unilib.register_stone_block_cuttings({
        part_name = "gneiss_antipodean",
    })

    unilib.register_node("unilib:stone_gneiss_antipodean_brick", "aotearoa:gneissbrick", mode, {
        -- From aotearoa:gneissbrick
        description = S("Antipodean Gneiss"),
        tiles = {"unilib_stone_gneiss_antipodean_brick.png"},
        -- N.B. stonebrick = 1 not in original code
        groups = {cracky = 1, stone = 1, stonebrick = 1},
        sounds = unilib.sound_table.stone,
    })
    unilib.register_craft_2x2x4({
        -- From aotearoa:gneissbrick
        output = "unilib:stone_gneiss_antipodean_brick",
        ingredient = "unilib:stone_gneiss_antipodean",
    })
    --[[
    unilib.register_stairs("unilib:stone_gneiss_antipodean_brick", {
        basic_flag = true,
    })
    ]]--
    unilib.register_stone_brick_cuttings({
        part_name = "gneiss_antipodean",
    })
    unilib.set_auto_rotate("unilib:stone_gneiss_antipodean_brick", unilib.auto_rotate_brick_flag)

    unilib.register_stone_cobble({
        -- Original to unilib. Creates unilib:stone_gneiss_antipodean_cobble
        part_name = "gneiss_antipodean",
        orig_name = nil,

        replace_mode = mode,
        description = S("Antipodean Gneiss Cobble"),
        img_list = {"unilib_stone_gneiss_antipodean.png^unilib_stone_cobble_overlay.png"},
    })

end
