---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_polluted = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_polluted.init()

    return {
        description = "Polluted dirt",
    }

end

function unilib.pkg.dirt_polluted.exec()

    -- Not in original code: if technic is available, use its radioactivity feature to hurt a
    --      nearby player. Otherwise, this node is purely decorative
    -- 3 is the lowest value for "radioactivity" in technic
    local radioactivity = nil
    if minetest.get_modpath("technic") then
        radioactivity = 3
    end

    unilib.register_node("unilib:dirt_polluted", nil, mode, {
        -- Texture from PFAA, pollutedSoil.png. Original code
        description = S("Polluted Dirt"),
        tiles = {"unilib_dirt_polluted.png"},
        groups = {crumbly = 3, radioactive = radioactivity, soil = 1},
        sounds = unilib.sound_table.dirt,

        is_ground_content = unilib.caves_chop_dirt_flag,
    })

end
