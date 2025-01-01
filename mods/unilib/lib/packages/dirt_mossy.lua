---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_mossy = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_mossy.init()

    return {
        description = "Mossy dirt",
        optional = "moss_green",
    }

end

function unilib.pkg.dirt_mossy.exec()

    local full_name = "unilib:dirt_mossy"
    local compressed_name = full_name .. "_compressed"

    unilib.register_node(full_name, "underch:mossy_dirt", mode, {
        -- From underch:mossy_dirt
        description = S("Mossy Dirt"),
        tiles = {"unilib_dirt_mossy.png"},
        groups = {crumbly = 3, soil = 1},
        sounds = unilib.global.sound_table.dirt,

        is_ground_content = unilib.setting.caves_chop_dirt_flag,
    })
    if unilib.global.pkg_executed_table["moss_green"] ~= nil then
        unilib.tools.make_cuttable(full_name, "unilib:dirt_ordinary", "unilib:moss_green")
    end
    unilib.register_stairs(full_name)

    if unilib.setting.squeezed_dirt_flag then

        unilib.register_node(compressed_name, nil, mode, {
            -- Original to unilib
            description = S("Compressed Mossy Dirt"),
            tiles = {"unilib_dirt_mossy_compressed.png"},
            groups = {compresseddirt = 1, crumbly = 2},
            sounds = unilib.global.sound_table.dirt,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        -- Original to unilib
        unilib.misc.set_squeezed_recipes(full_name, compressed_name)
        unilib.register_stairs(compressed_name)

    end

end
