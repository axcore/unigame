---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_rockwall_stone_desert = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_rockwall_stone_desert.init()

    return {
        description = "Rockwall of desert stone",
        depends = "stone_desert",
    }

end

function unilib.pkg.decor_rockwall_stone_desert.exec()

    local c_stone = "unilib:stone_desert"
    local c_cobble = "unilib:stone_desert_cobble"

    unilib.register_node(
        -- Texture from GLEMr4, lib_materials_rockwall_stone_desert.png. Code adapted from
        --      unilib:decor_rockwall_stone_ordinary
        "unilib:decor_rockwall_stone_desert",
        "lib_materials:rockwall_stone",
        mode,
        {
            description = S("Rockwall of Desert Stone"),
            tiles = {"unilib_decor_rockwall_stone_desert.png"},
            groups = {cracky = 3, level = 2, stone = 1},
            sounds = unilib.sound_table.stone,

            drop = "unilib:stone_desert_cobble",
            -- N.B. no is_ground_content in original code, this matches
            --      unilib:decor_rockwall_stone_desert_dark
            is_ground_content = false,
        }
    )
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:decor_rockwall_stone_desert 9",
        recipe = {
            {c_stone, c_stone, c_stone},
            {c_cobble, c_cobble, c_cobble},
            {c_stone, c_stone, c_stone},
        },
    })

end
