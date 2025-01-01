---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_peat = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_peat.init()

    return {
        description = "Peat",
    }

end

function unilib.pkg.dirt_peat.exec()

    local full_name = "unilib:dirt_peat"
    local compressed_name = full_name .. "_compressed"

    unilib.register_node(full_name, "real_minerals:peat", mode, {
        -- From real_minerals:peat
        description = S("Peat"),
        tiles = {"unilib_dirt_peat.png"},
        groups = {crumbly = 3, falling_node = 1},
        sounds = unilib.global.sound_table.dirt,

        is_ground_content = unilib.setting.caves_chop_dirt_flag,
    })
    unilib.register_craft({
        -- From real_minerals:peat
        type = "fuel",
        recipe = full_name,
        burntime = 15,
    })

    if unilib.setting.squeezed_dirt_flag then

        unilib.register_node(compressed_name, nil, mode, {
            -- Original to unilib
            description = S("Compressed Peat"),
            tiles = {"unilib_dirt_peat_compressed.png"},
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
