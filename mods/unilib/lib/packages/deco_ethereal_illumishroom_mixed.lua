---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_illumishroom_mixed = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_illumishroom_mixed.init()

    return {
        description = "Places illumishrooms in caves on top of coal",
        depends = "stone_ordinary_with_coal",
        at_least_one = {
            "mushroom_illumishroom_cyan",
            "mushroom_illumishroom_green",
            "mushroom_illumishroom_red",
        },
    }

end

function unilib.pkg.deco_ethereal_illumishroom_mixed.exec()

    if unilib.global.pkg_executed_table["mushroom_illumishroom_red"] ~= nil then

        unilib.register_decoration_generic("ethereal_mushroom_illumishroom_red", {
            -- From ethereal-ng/decor.lua
            deco_type = "simple",
            decoration = "unilib:mushroom_illumishroom_red",

            fill_ratio = 0.5,
            flags = "force_placement, all_floors",
            sidelen = 16,
        })

    end

    if unilib.global.pkg_executed_table["mushroom_illumishroom_green"] ~= nil then

        unilib.register_decoration_generic("ethereal_mushroom_illumishroom_green", {
            -- From ethereal-ng/decor.lua
            deco_type = "simple",
            decoration = "unilib:mushroom_illumishroom_green",

            fill_ratio = 0.5,
            flags = "force_placement, all_floors",
            sidelen = 16,
        })

    end

    if unilib.global.pkg_executed_table["mushroom_illumishroom_cyan"] ~= nil then

        unilib.register_decoration_generic("ethereal_mushroom_illumishroom_cyan", {
            -- From ethereal-ng/decor.lua
            deco_type = "simple",
            decoration = "unilib:mushroom_illumishroom_cyan",

            fill_ratio = 0.5,
            flags = "force_placement, all_floors",
            sidelen = 16,
        })

    end

end

function unilib.pkg.deco_ethereal_illumishroom_mixed.post()

    if unilib.global.pkg_executed_table["mushroom_illumishroom_red"] ~= nil then

        unilib.register_decoration_complete("ethereal_mushroom_illumishroom_red", nil, {
            -- From ethereal-ng/decor.lua
            place_on = "unilib:stone_ordinary_with_coal",
            y_max = -50,
            y_min = -1000,
        })

    end

    if unilib.global.pkg_executed_table["mushroom_illumishroom_green"] ~= nil then

        unilib.register_decoration_complete("ethereal_mushroom_illumishroom_green", nil, {
            -- From ethereal-ng/decor.lua
            place_on = "unilib:stone_ordinary_with_coal",
            y_max = -1000,
            y_min = -2000,
        })

    end

    if unilib.global.pkg_executed_table["mushroom_illumishroom_cyan"] ~= nil then

        unilib.register_decoration_complete("ethereal_mushroom_illumishroom_cyan", nil, {
            -- From ethereal-ng/decor.lua
            place_on = "unilib:stone_ordinary_with_coal",
            y_max = -2000,
            y_min = -3000,
        })

    end

end

