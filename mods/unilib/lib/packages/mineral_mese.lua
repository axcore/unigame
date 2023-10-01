---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_mese = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_mese.init()

    return {
        description = "Mese (as a mineral)",
        notes = "Produces mese crystals (instead of lumps), which in turn produce mese crystal" ..
                " fragments",
    }

end

function unilib.pkg.mineral_mese.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "mese",
        description = S("Mese"),

        fictional_flag = true,
        hardness = 3,
        no_lump_flag = true,
    })

    unilib.register_craftitem("unilib:mineral_mese_crystal", "default:mese_crystal", mode, {
        -- From default:mese_crystal
        description = S("Mese Crystal"),
        inventory_image = "unilib_mineral_mese_crystal.png",
    })
    unilib.register_craft({
        -- From default:mese_crystal
        output = "unilib:mineral_mese_crystal 9",
        recipe = {
            {"unilib:mineral_mese_block"},
        }
    })
    unilib.register_craft_3x3({
        -- From default:mese_crystal
        output = "unilib:mineral_mese_crystal",
        ingredient = "unilib:mineral_mese_crystal_fragment",
    })

    unilib.register_craftitem(
        -- From default:mese_crystal_fragment
        "unilib:mineral_mese_crystal_fragment",
        "default:mese_crystal_fragment",
        mode,
        {
            description = S("Mese Crystal Fragment"),
            inventory_image = "unilib_mineral_mese_crystal_fragment.png",
        }
    )
    unilib.register_craft({
        -- From default:mese_crystal_fragment
        output = "unilib:mineral_mese_crystal_fragment 9",
        recipe = {
            {"unilib:mineral_mese_crystal"},
        }
    })

    unilib.register_node("unilib:mineral_mese_block", "default:mese", mode, {
        -- From default:mese
        description = S("Mese Block"),
        tiles = {"unilib_mineral_mese_block.png"},
        groups = {cracky = 1, level = 2},
        sounds = unilib.sound_table.stone,

        light_source = 3,
        paramtype = "light",
    })
    unilib.register_craft_3x3({
        -- From default:mese
        output = "unilib:mineral_mese_block",
        ingredient = "unilib:mineral_mese_crystal",
    })
    unilib.register_carvings("unilib:mineral_mese_block", {
        millwork_flag = true,
    })

end
