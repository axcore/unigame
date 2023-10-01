---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_schist_antipodean = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_schist_antipodean.init()

    return {
        description = "Antipodean schist",
        optiona = {
            "stone_andesite_antipodean",
            "stone_basalt_black",
            "stone_greywacke_dark",
            "stone_scoria",
        },
    }

end

function unilib.pkg.stone_schist_antipodean.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "schist_antipodean",
        description = S("Antipodean Schist"),

        category = "metamorphic",
        grinder_flag = true,
        hardness = 2,
    })

    unilib.register_node("unilib:stone_schist_antipodean", "aotearoa:schist", mode, {
        -- From aotearoa:schist
        description = S("Antipodean Schist"),
        tiles = {"unilib_stone_schist_antipodean.png"},
        -- N.B. smoothstone = 1 not in original code
        groups = {cracky = 2, smoothstone = 1, stone = 1},
        sounds = unilib.sound_table.stone,

        -- N.B. drops smoothstone in original code
        drop = "unilib:stone_schist_antipodean_cobble",
    })
    if unilib.pkg_executed_table["stone_andesite_antipodean"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:schist
            type = "cooking",
            output = "unilib:stone_schist_antipodean",
            recipe = "unilib:stone_andesite_antipodean",
            cooktime = 120,
        })

    end
    if unilib.pkg_executed_table["stone_basalt_black"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:schist
            type = "cooking",
            output = "unilib:stone_schist_antipodean",
            recipe = "unilib:stone_basalt_black",
            cooktime = 120,
        })

    end
    if unilib.pkg_executed_table["stone_greywacke_dark"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:schist
            type = "cooking",
            output = "unilib:stone_schist_antipodean",
            recipe = "unilib:stone_greywacke_dark",
            cooktime = 120,
        })

    end
    if unilib.pkg_executed_table["stone_scoria"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:schist
            type = "cooking",
            output = "unilib:stone_schist_antipodean",
            recipe = "unilib:stone_scoria",
            cooktime = 120,
        })

    end
    --[[
    unilib.register_stairs("unilib:stone_schist_antipodean", {
        basic_flag = true,
        drop_name = "unilib:stone_schist_antipodean_cobble",
        group_type = "smooth",
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "schist_antipodean",

        drop_name = "unilib:stone_schist_antipodean_cobble",
    })


    unilib.register_node("unilib:stone_schist_antipodean_block", "aotearoa:schist_block", mode, {
        -- From aotearoa:schist_block
        description = S("Antipodean Schist Block"),
        tiles = {"unilib_stone_schist_antipodean_block.png"},
        -- N.B. stoneblock = 1 not in original code
        groups = {cracky = 2, stone = 1, stoneblock = 1},
        sounds = unilib.sound_table.stone,
    })
    unilib.register_craft_3x3x9({
        -- From aotearoa:schist_block
        output = "unilib:stone_schist_antipodean_block",
        ingredient = "unilib:stone_schist_antipodean",
    })
    --[[
    unilib.register_stairs("unilib:stone_schist_antipodean_block", {
        basic_flag = true,
    })
    ]]--
    unilib.register_stone_block_cuttings({
        part_name = "schist_antipodean",
    })

    unilib.register_node("unilib:stone_schist_antipodean_brick", "aotearoa:schistbrick", mode, {
        -- From aotearoa:schistbrick
        description = S("Antipodean Schist Bricks"),
        tiles = {"unilib_stone_schist_antipodean_brick.png"},
        -- N.B. stonebrick = 1 not in original code
        groups = {cracky = 2, stone = 1, stonebrick = 1},
        sounds = unilib.sound_table.stone,
    })
    unilib.register_craft_2x2x4({
        -- From aotearoa:schistbrick
        output = "unilib:stone_schist_antipodean_brick",
        ingredient = "unilib:stone_schist_antipodean",
    })
    --[[
    unilib.register_stairs("unilib:stone_schist_antipodean_brick", {
        basic_flag = true,
    })
    ]]--
    unilib.register_stone_brick_cuttings({
        part_name = "schist_antipodean",
    })
    unilib.set_auto_rotate("unilib:stone_schist_antipodean_brick", unilib.auto_rotate_brick_flag)

    unilib.register_stone_cobble({
        -- Original to unilib. Creates unilib:stone_schist_antipodean_cobble
        part_name = "schist_antipodean",
        orig_name = nil,

        replace_mode = mode,
        description = S("Antipodean Schist Cobble"),
        img_list = {"unilib_stone_schist_antipodean.png^unilib_stone_cobble_overlay.png"},
    })

    unilib.register_decoration("aotearoa_stone_schist_antipodean", {
        -- From aotearoa/spawn_plants.lua
        deco_type = "simple",
        decoration = "unilib:stone_schist_antipodean",

        noise_params = {
            octaves = 2,
            offset = 0,
            persist = 0.7,
            scale = 0.095,
            seed = 81209,
            spread = {x = 6, y = 6, z = 6},
        },
        sidelen = 16,
    })

end
