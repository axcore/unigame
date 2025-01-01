---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_pietersite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_pietersite.init()

    return {
        description = "Pietersite (as a mineral)",
        optional = "machine_polishing",
    }

end

function unilib.pkg.mineral_pietersite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "pietersite",
        description = S("Pietersite"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_pietersite_lump", nil, mode, {
        -- Original to unilib
        description = S("Pietersite Lump"),
        inventory_image = "unilib_mineral_pietersite_lump.png",
    })

    if unilib.global.pkg_executed_table["machine_polishing"] ~= nil then

        unilib.register_craftitem("unilib:mineral_pietersite_gem", nil, mode, {
            -- Original to unilib
            description = S("Pietersite Gem"),
            inventory_image = "unilib_mineral_pietersite_gem.png",
        })
        unilib.register_craft({
            -- Original to unilib
            output = "unilib:mineral_pietersite_gem 9",
            recipe = {
                {"unilib:mineral_pietersite_block"},
            },
        })

        unilib.register_node("unilib:mineral_pietersite_block", nil, mode, {
            -- Original to unilib
            description = S("Pietersite Block"),
            tiles = {"unilib_mineral_pietersite_block.png"},
            groups = {cracky = 1, level = 3},
            sounds = unilib.global.sound_table.glass,

            is_ground_content = false,
        })
        unilib.register_craft_3x3({
            -- Original to unilib
            output = "unilib:mineral_pietersite_block",
            ingredient = "unilib:mineral_pietersite_gem",
        })
        unilib.register_stairs("unilib:mineral_pietersite_block")
        unilib.register_carvings("unilib:mineral_pietersite_block", {
            millwork_flag = true,
        })

    end

end
