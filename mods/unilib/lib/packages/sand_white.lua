---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_white = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_white.init()

    return {
        description = "White sand",
        notes = "GLEMr4 uses inappropriate textures for its white sandstone and white sandstone" ..
                " gravel nodes, having copied them from the \"node_texture_modifier\" mod. Here," ..
                " and in the \"stone_sandstone_white\" package, we insert new code that better" ..
                " matches the textures, converting the sandstone to a sand, and the sandstone" ..
                " gravel to a sandstone",
    }

end

function unilib.pkg.sand_white.exec()

    unilib.register_node("unilib:sand_white", "lib_materials:stone_sandstone_white", mode, {
        -- From GLEMr4, lib_materials:stone_sandstone_white, originally from "node texture modifier"
        --      mod
        description = S("White Sand"),
        -- N.B. Originally lib_materials_stone_sandstone_white.png
        tiles = {"unilib_sand_white.png"},
        -- N.B. Originally cracky = 3, stone = 1, level = 2
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        -- N.B. Originally gravel sounds
        sounds = unilib.sound_table.sand,
    })

end
