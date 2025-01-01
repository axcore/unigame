---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_peridot = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_peridot.init()

    return {
        description = "Peridot (as a mineral)",
        optional = "machine_polishing",
    }

end

function unilib.pkg.mineral_peridot.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "peridot",
        description = S("Peridot"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_peridot_lump", nil, mode, {
        -- Texture from AATO, peridot.png. Original code
        description = unilib.utils.brackets(S("Peridot Lump"), S("Chrysolite")),
        inventory_image = "unilib_mineral_peridot_lump.png",
    })

    if unilib.global.pkg_executed_table["machine_polishing"] ~= nil then

        unilib.register_craftitem("unilib:mineral_peridot_gem", nil, mode, {
            -- Original to unilib
            description = S("Peridot Gem"),
            inventory_image = "unilib_mineral_peridot_gem.png",
        })
        unilib.register_craft({
            -- Original to unilib
            output = "unilib:mineral_peridot_gem 9",
            recipe = {
                {"unilib:mineral_peridot_block"},
            },
        })

        unilib.register_node("unilib:mineral_peridot_block", nil, mode, {
            -- Original to unilib
            description = S("Peridot Block"),
            tiles = {"unilib_mineral_peridot_block.png"},
            groups = {cracky = 1, level = 3},
            sounds = unilib.global.sound_table.glass,

            is_ground_content = false,
        })
        unilib.register_craft_3x3({
            -- Original to unilib
            output = "unilib:mineral_peridot_block",
            ingredient = "unilib:mineral_peridot_gem",
        })
        unilib.register_stairs("unilib:mineral_peridot_block")
        unilib.register_carvings("unilib:mineral_peridot_block", {
            millwork_flag = true,
        })

    end

end
