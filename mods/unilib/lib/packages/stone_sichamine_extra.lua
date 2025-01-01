---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sichamine_extra = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sichamine_extra.init()

    return {
        description = "Extra sichamine items",
        depends = {"mineral_coal", "stone_sichamine"},
    }

end

function unilib.pkg.stone_sichamine_extra.exec()

    local c_sichamine = "unilib:stone_sichamine"

    unilib.register_node("unilib:stone_sichamine_dark", "underch:dark_sichamine", mode, {
        -- From underch:dark_sichamine
        description = S("Dark Sichamine"),
        tiles = {"unilib_stone_sichamine_dark.png"},
        groups = {cracky = 3, stone = 1},
        sounds = unilib.global.sound_table.stone,
    })
    unilib.register_craft({
        -- From underch:dark_sichamine
        type = "shapeless",
        output = "unilib:stone_sichamine_dark 3",
        recipe = {c_sichamine, c_sichamine, c_sichamine, "unilib:mineral_coal_lump"},
    })

    unilib.register_node("unilib:stone_sichamine_weedy", "underch:weedy_sichamine", mode, {
        -- From underch:weedy_sichamine. Not to be confused with underch:sichamine_mossy_cobble,
        --      named "Weedy Sichamine Cobble"
        description = S("Weedy Sichamine"),
        tiles = {"unilib_stone_sichamine_weedy.png"},
        groups = {cracky = 3, stone = 1},
        sounds = unilib.global.sound_table.stone,
    })
    unilib.register_craft({
        -- From underch:weedy_sichamine
        type = "shapeless",
        output = "unilib:stone_sichamine_weedy",
        recipe = {c_sichamine, "group:leaves"},
    })

end
