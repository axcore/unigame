---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_polluted = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_polluted.init()

    return {
        description = "Polluted dirt",
    }

end

function unilib.pkg.dirt_polluted.exec()

    local full_name = "unilib:dirt_polluted"
    local compressed_name = full_name .. "_compressed"

    -- Not in original code: if technic is available, use its radioactivity feature to hurt a
    --      nearby player. Otherwise, this node is purely decorative
    -- 3 is the lowest value for "radioactivity" in technic
    local radioactivity = nil
    if core.get_modpath("technic") then
        radioactivity = 3
    end

    unilib.register_node(full_name, nil, mode, {
        -- Texture from PFAA, pollutedSoil.png. Original code
        description = S("Polluted Dirt"),
        tiles = {"unilib_dirt_polluted.png"},
        groups = {crumbly = 3, radioactive = radioactivity, soil = 1},
        sounds = unilib.global.sound_table.dirt,

        is_ground_content = unilib.setting.caves_chop_dirt_flag,
    })

    if unilib.setting.squeezed_dirt_flag then

        unilib.register_node(compressed_name, nil, mode, {
            -- Original to unilib
            description = S("Compressed Polluted Dirt"),
            tiles = {"unilib_dirt_polluted_compressed.png"},
            groups = {compresseddirt = 1, crumbly = 2, radioactive = radioactivity},
            sounds = unilib.global.sound_table.dirt,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        -- Original to unilib
        unilib.misc.set_squeezed_recipes(full_name, compressed_name)
        unilib.register_stairs(compressed_name)

    end

end
