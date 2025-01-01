---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_ironsand_with_pipi = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_ironsand_with_pipi.init()

    return {
        description = "Ironsand with pipi",
        depends = {"food_clam_pipi", "sand_ironsand"},
    }

end

function unilib.pkg.sand_ironsand_with_pipi.exec()

    unilib.register_node("unilib:sand_ironsand_with_pipi", "aotearoa:iron_sand_with_pipi", mode, {
        -- From aotearoa:iron_sand_with_pipi
        description = S("Ironsand with Pipi"),
        tiles = {"unilib_sand_ironsand_with_pipi.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.global.sound_table.sand,

        on_punch = function(pos, node, puncher)

            -- Dig up pipi
            puncher:get_inventory():add_item("main", "unilib:food_clam_pipi")
            core.set_node(pos, {name = "unilib:sand_ironsand"})

        end,
    })

end
