---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_volcanic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_volcanic.init()

    return {
        description = "Volcanic sand",
        optional = "stone_obsidian",
    }

end

function unilib.pkg.sand_volcanic.exec()

    unilib.register_node("unilib:sand_volcanic", "aotearoa:volcanic_sand", mode, {
        -- From aotearoa:volcanic_sand
        description = S("Volcanic Sand"),
        tiles = {"unilib_sand_volcanic.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,
    })
    if unilib.pkg_executed_table["stone_obsidian"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:volcanic_sand
            type = "cooking",
            output = "unilib:stone_obsidian",
            recipe = "unilib:sand_volcanic",
        })

    end

end
