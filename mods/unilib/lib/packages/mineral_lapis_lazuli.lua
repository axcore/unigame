---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_lapis_lazuli = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_lapis_lazuli.init()

    return {
        description = "Lapis lazuli (as mineral)",
        optional = "machine_polishing",
    }

end

function unilib.pkg.mineral_lapis_lazuli.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "lapis_lazuli",
        description = S("Lapis Lazuli"),

        hardness = 2,
    })

    unilib.register_craftitem("unilib:mineral_lapis_lazuli_lump", nil, mode, {
        -- Original to unilib
        description = S("Lapis Lazuli Lump"),
        inventory_image = "unilib_mineral_lapis_lazuli_lump.png",
    })

    if unilib.global.pkg_executed_table["machine_polishing"] ~= nil then

        unilib.register_craftitem("unilib:mineral_lapis_lazuli_gem", nil, mode, {
            -- Original to unilib
            description = S("Lapis Lazuli Gem"),
            inventory_image = "unilib_mineral_lapis_lazuli_gem.png",
        })
        unilib.register_craft({
            -- Original to unilib
            output = "unilib:mineral_lapis_lazuli_gem 9",
            recipe = {
                {"unilib:mineral_lapis_lazuli_block"},
            },
        })

        unilib.register_node("unilib:mineral_lapis_lazuli_block", nil, mode, {
            -- Original to unilib
            description = S("Lapis Lazuli Block"),
            tiles = {"unilib_mineral_lapis_lazuli_block.png"},
            groups = {cracky = 1, level = 3},
            sounds = unilib.global.sound_table.glass,

            is_ground_content = false,
        })
        unilib.register_craft_3x3({
            -- Original to unilib
            output = "unilib:mineral_lapis_lazuli_block",
            ingredient = "unilib:mineral_lapis_lazuli_gem",
        })
        unilib.register_stairs("unilib:mineral_lapis_lazuli_block")
        unilib.register_carvings("unilib:mineral_lapis_lazuli_block", {
            millwork_flag = true,
        })

    end

end
