---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_brown = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_brown.init()

    return {
        description = "Brown clay",
        optional = "brick_ordinary",
    }

end

function unilib.pkg.clay_brown.exec()

    unilib.register_node("unilib:clay_brown", "underch:clay", mode, {
        -- From underch:clay
        description = S("Brown Clay"),
        tiles = {"unilib_clay_brown.png"},
        -- N.B. clay = 1 not in original code
        groups = {clay = 1, crumbly = 3},
        sounds = unilib.global.sound_table.dirt,

        drop = 'unilib:clay_brown_lump 4',
    })
    unilib.register_craft_2x2({
        -- From underch:clay
        output = "unilib:clay_brown",
        ingredient = "unilib:clay_brown_lump",
    })
    unilib.register_carvings("unilib:clay_brown", {
        facade_flag = true,
        millwork_flag = true,
    })

    unilib.register_craftitem("unilib:clay_brown_lump", "underch:clay_lump", mode, {
        -- From underch:clay_lump
        description = S("Brown Clay Lump"),
        inventory_image = "unilib_clay_brown_lump.png",
    })
    unilib.register_craft({
        -- From underch:clay_lump
        output = "unilib:clay_brown_lump 4",
        recipe = {
            {"unilib:clay_brown"},
        },
    })
    if unilib.global.pkg_executed_table["brick_ordinary"] ~= nil then

        unilib.register_craft({
            -- From underch:clay_lump
            type = "cooking",
            output = "unilib:brick_ordinary",
            recipe = "unilib:clay_brown_lump",
        })

    end

end
