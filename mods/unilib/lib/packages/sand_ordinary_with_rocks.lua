---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    valleys_c
-- Code:    GPL 3.0/BSD/WTFPL
-- Media:   GPL 3.0/BSD/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_ordinary_with_rocks = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.valleys_c.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_ordinary_with_rocks.init()

    return {
        description = "Ordinary sand with rocks",
--      depends = "sand_ordinary",
    }

end

function unilib.pkg.sand_ordinary_with_rocks.exec()

    unilib.register_node("unilib:sand_ordinary_with_rocks", "valleys_c:sand_with_rocks", mode, {
        -- From valleys_c:sand_with_rocks
        description = S("Ordinary Sand with Rocks"),
        tiles = {"unilib_sand_ordinary_with_rocks.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,

        --[[
        drop = {
            max_items=2,
            items = {
                {items = {"valleys_c:small_rocks"}, rarity = 1},
                {items = {"unilib:sand_ordinary"}, rarity = 1},
            },
        },
        ]]--
    })

end
