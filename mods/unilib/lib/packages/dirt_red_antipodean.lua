---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_red_antipodean = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_red_antipodean.init()

    return {
        description = "Antipodean red dirt",
    }

end

function unilib.pkg.dirt_red_antipodean.exec()

    local full_name = "unilib:dirt_red_antipodean"
    local compressed_name = full_name .. "_compressed"

    unilib.register_node(full_name, "australia:red_dirt", mode, {
        -- From australia:red_dirt
        description = S("Antipodean Red Dirt"),
        tiles = {"unilib_dirt_red_antipodean.png"},
        groups = {crumbly = 3, soil = 1},
        sounds = unilib.global.sound_table.dirt,

        is_ground_content = unilib.setting.caves_chop_dirt_flag,
    })
    unilib.register_other_dirt(full_name)

    if unilib.setting.squeezed_dirt_flag then

        unilib.register_node(compressed_name, nil, mode, {
            -- Original to unilib
            description = S("Compressed Antipodean Red Dirt"),
            tiles = {"unilib_dirt_red_antipodean_compressed.png"},
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
