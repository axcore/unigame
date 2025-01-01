---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_moonstone = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_moonstone.init()

    return {
        description = "Moonstone (as a mineral)",
        optional = "machine_polishing",
    }

end

function unilib.pkg.mineral_moonstone.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "moonstone",
        description = S("Moonstone"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_moonstone_lump", nil, mode, {
        -- Texture from AATO, moonstone.png. Original code
        description = S("Moonstone Lump"),
        inventory_image = "unilib_mineral_moonstone_lump.png",
    })

    if unilib.global.pkg_executed_table["machine_polishing"] ~= nil then

        unilib.register_craftitem("unilib:mineral_moonstone_gem", nil, mode, {
            -- Original to unilib
            description = S("Moonstone Gem"),
            inventory_image = "unilib_mineral_moonstone_gem.png",
        })
        unilib.register_craft({
            -- Original to unilib
            output = "unilib:mineral_moonstone_gem 9",
            recipe = {
                {"unilib:mineral_moonstone_block"},
            },
        })

        unilib.register_node("unilib:mineral_moonstone_block", nil, mode, {
            -- Original to unilib
            description = S("Moonstone Block"),
            tiles = {"unilib_mineral_moonstone_block.png"},
            groups = {cracky = 1, level = 3},
            sounds = unilib.global.sound_table.glass,

            is_ground_content = false,
        })
        unilib.register_craft_3x3({
            -- Original to unilib
            output = "unilib:mineral_moonstone_block",
            ingredient = "unilib:mineral_moonstone_gem",
        })
        unilib.register_stairs("unilib:mineral_moonstone_block")
        unilib.register_carvings("unilib:mineral_moonstone_block", {
            millwork_flag = true,
        })

    end

end
