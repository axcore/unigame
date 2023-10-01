---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_ironsand = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_ironsand.init()

    return {
        description = "Ironsand",
        optional = "metal_iron",
    }

end

function unilib.pkg.sand_ironsand.exec()

    unilib.register_node("unilib:sand_ironsand", "aotearoa:iron_sand", mode, {
        -- From aotearoa:iron_sand
        description = S("Ironsand"),
        tiles = {"unilib_sand_ironsand.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,
    })
    if unilib.pkg_executed_table["metal_iron"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:iron_sand
            type = "cooking",
            output = "unilib:metal_iron_lump",
            recipe = "unilib:sand_ironsand",
            cooktime = 30,
        })

    end

end
