---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_ordinary_hardened = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_ordinary_hardened.init()

    return {
        description = "Hardened ordinary clay",
        depends = "clay_ordinary",
    }

end

function unilib.pkg.clay_ordinary_hardened.exec()

    unilib.register_node("unilib:clay_ordinary_hardened", "xdecor:hard_clay", mode, {
        -- From xdecor:hard_clay
        description = S("Hardened Ordinary Clay"),
        tiles = {"unilib_clay_ordinary_hardened.png"},
        groups = {cracky = 1},
        sounds = unilib.global.sound_table.stone,

        paramtype2 = "facedir",
    })
    -- N.B. Original craft recipe conflicts with recipe in "stone_claystone_white" package
    --[[
    unilib.register_craft({
        -- From xdecor:hard_clay
        output = "unilib:clay_ordinary_hardened",
        recipe = {
            {"unilib:clay_ordinary", "unilib:clay_ordinary"},
            {"unilib:clay_ordinary", "unilib:clay_ordinary"},
        },
    })
    ]]--
    unilib.register_craft({
        -- From xdecor:hard_clay
        output = "unilib:clay_ordinary_hardened 2",
        recipe = {
            {"unilib:clay_ordinary", "unilib:clay_ordinary", "unilib:clay_ordinary"},
            {"unilib:clay_ordinary", "unilib:clay_ordinary", "unilib:clay_ordinary"},
            {"unilib:clay_ordinary", "unilib:clay_ordinary", "unilib:clay_ordinary"},
        },
    })

end
