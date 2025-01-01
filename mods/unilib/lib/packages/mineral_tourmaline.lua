---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_tourmaline = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_tourmaline.init()

    return {
        description = "Tourmaline (as a mineral)",
        optional = "machine_polishing",
    }

end

function unilib.pkg.mineral_tourmaline.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "tourmaline",
        description = S("Tourmaline"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_tourmaline_lump", nil, mode, {
        -- Texture from AATO, tourmaline.png. Original code
        description = S("Tourmaline Lump"),
        inventory_image = "unilib_mineral_tourmaline_lump.png",
    })

    if unilib.global.pkg_executed_table["machine_polishing"] ~= nil then

        unilib.register_craftitem("unilib:mineral_tourmaline_gem", nil, mode, {
            -- Original to unilib
            description = S("Tourmaline Gem"),
            inventory_image = "unilib_mineral_tourmaline_gem.png",
        })
        unilib.register_craft({
            -- Original to unilib
            output = "unilib:mineral_tourmaline_gem 9",
            recipe = {
                {"unilib:mineral_tourmaline_block"},
            },
        })

        unilib.register_node("unilib:mineral_tourmaline_block", nil, mode, {
            -- Original to unilib
            description = S("Tourmaline Block"),
            tiles = {"unilib_mineral_tourmaline_block.png"},
            groups = {cracky = 1, level = 3},
            sounds = unilib.global.sound_table.glass,

            is_ground_content = false,
        })
        unilib.register_craft_3x3({
            -- Original to unilib
            output = "unilib:mineral_tourmaline_block",
            ingredient = "unilib:mineral_tourmaline_gem",
        })
        unilib.register_stairs("unilib:mineral_tourmaline_block")
        unilib.register_carvings("unilib:mineral_tourmaline_block", {
            millwork_flag = true,
        })

    end

end
