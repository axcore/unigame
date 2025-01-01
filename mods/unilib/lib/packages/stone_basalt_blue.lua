---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
--
-- From:    uchu/compressed
-- Code:    MIT
-- Media:   CC BY-SA 3.0
--
-- From:    uchu/condensed
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_basalt_blue = {}

local S = unilib.intllib
local underch_add_mode = unilib.global.imported_mod_table.underch.add_mode
local compressed_add_mode = unilib.global.imported_mod_table.compressed.add_mode
local condensed_add_mode = unilib.global.imported_mod_table.condensed.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_basalt_blue.init()

    return {
        description = "Blue basalt",
        optional = "liquid_lava_ordinary",
    }

end

function unilib.pkg.stone_basalt_blue.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "basalt_blue",
        description = S("Blue Basalt"),

        category = "extrusive",
        colour = "#4C5566",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match original mod's code, should be 3)
        hardness = 1,
        hardness_real = 3,
        moss_flag = true,
        platform_flag = true,
    })

    unilib.register_stone_smooth({
        -- From underch:basalt. Creates unilib:stone_basalt_blue
        part_name = "basalt_blue",
        orig_name = "underch:basalt",

        replace_mode = underch_add_mode,
        cobble_mode = "cobble",
        description = S("Blue Basalt"),
    })

    unilib.register_stone_block({
        -- From underch:basalt_block. Creates unilib:stone_basalt_blue_block
        part_name = "basalt_blue",
        orig_name = "underch:basalt_block",

        replace_mode = underch_add_mode,
        description = S("Blue Basalt Block"),
    })

    unilib.register_stone_brick({
        -- From underch:basalt_brick. Creates unilib:stone_basalt_blue_brick
        part_name = "basalt_blue",
        orig_name = "underch:basalt_brick",

        replace_mode = underch_add_mode,
        description = S("Blue Basalt Bricks"),
    })

    unilib.register_stone_cobble({
        -- From underch:basalt_cobble. Creates unilib:stone_basalt_blue_cobble
        part_name = "basalt_blue",
        orig_name = "underch:basalt_cobble",

        replace_mode = underch_add_mode,
        description = S("Blue Basalt Cobble"),
        wall_orig_name = "underch:basalt_cobble_wall",
    })

    unilib.register_stone_cobble_mossy({
        -- From underch:basalt_mossy_cobble. Creates unilib:stone_basalt_blue_cobble_mossy
        part_name = "basalt_blue",
        orig_name = "underch:basalt_mossy_cobble",

        replace_mode = underch_add_mode,
        description = S("Mossy Blue Basalt Cobble"),
        wall_orig_name = "underch:basalt_mossy_cobble_wall",
    })

    unilib.register_stone_cobble_compressed({
        -- From compressed:basalt. Creates unilib:stone_basalt_blue_cobble_compressed
        part_name = "basalt_blue",
        orig_name = "compressed:basalt",

        replace_mode = compressed_add_mode,
        description = S("Compressed Blue Basalt Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- From condensed:basalt. Creates unilib:stone_basalt_blue_cobble_condensed
        part_name = "basalt_blue",
        orig_name = "condensed:basalt",

        replace_mode = condensed_add_mode,
        description = S("Condensed Blue Basalt Cobble"),
    })

end

function unilib.pkg.stone_basalt_blue.post()

    if unilib.setting.underch_override_abm_flag and
            unilib.global.pkg_executed_table["liquid_lava_ordinary"] ~= nil then

        -- Update the global variable, so that cooled flowing lava solidifies into blue basalt,
        --      rather than ordinary stone
        -- N.B. If the minetest_game ABM is still running, both blue basalt and ordinary stone will
        --      be produced. To avoid this problem, run unilib on top of unigame, instead
        unilib.global.lava_cooling_table["unilib:liquid_lava_ordinary_flowing"] =
                "unilib:stone_basalt_blue"

    end

end
