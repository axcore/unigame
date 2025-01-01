---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_carnelian = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_carnelian.init()

    return {
        description = "Carnelian (as a mineral)",
        optional = "machine_polishing",
    }

end

function unilib.pkg.mineral_carnelian.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "carnelian",
        description = S("Carnelian"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_carnelian_lump", nil, mode, {
        -- Texture from AATO, carnelian.png. Original code
        description = S("Carnelian Lump"),
        inventory_image = "unilib_mineral_carnelian_lump.png",
    })

    if unilib.global.pkg_executed_table["machine_polishing"] ~= nil then

        unilib.register_craftitem("unilib:mineral_carnelian_gem", nil, mode, {
            -- Original to unilib
            description = S("Carnelian Gem"),
            inventory_image = "unilib_mineral_carnelian_gem.png",
        })
        unilib.register_craft({
            -- Original to unilib
            output = "unilib:mineral_carnelian_gem 9",
            recipe = {
                {"unilib:mineral_carnelian_block"},
            },
        })

        unilib.register_node("unilib:mineral_carnelian_block", nil, mode, {
            -- Original to unilib
            description = S("Carnelian Block"),
            tiles = {"unilib_mineral_carnelian_block.png"},
            groups = {cracky = 1, level = 3},
            sounds = unilib.global.sound_table.glass,

            is_ground_content = false,
        })
        unilib.register_craft_3x3({
            -- Original to unilib
            output = "unilib:mineral_carnelian_block",
            ingredient = "unilib:mineral_carnelian_gem",
        })
        unilib.register_stairs("unilib:mineral_carnelian_block")
        unilib.register_carvings("unilib:mineral_carnelian_block", {
            millwork_flag = true,
        })

    end

end
