---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_seashells = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_seashells.init()

    return {
        description = "Seashells",
        notes = "Classified as a sand, because that's how it's used in aotearoa biomes (and to" ..
                " distinguish it from the items from the decorations_sea mod)",
    }

end

function unilib.pkg.sand_seashells.exec()

    unilib.register_node("unilib:sand_seashells", "aotearoa:seashells", mode, {
        -- From aotearoa:seashells
        description = S("Seashells"),
        tiles = {"unilib_sand_seashells.png"},
        groups = {crumbly = 3, falling_node = 1},
        sounds = unilib.sound_table.gravel,
    })

end
