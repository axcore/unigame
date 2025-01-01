---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_ruby_dark = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_ruby_dark.init()

    return {
        description = "Dark ruby (as a mineral)",
        optional = "machine_polishing",
    }

end

function unilib.pkg.mineral_ruby_dark.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "ruby_dark",
        description = S("Dark Ruby"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_ruby_dark_lump", nil, mode, {
        -- Texture from AATO, ruby.png. Original code
        description = S("Dark Ruby Lump"),
        inventory_image = "unilib_mineral_ruby_dark_lump.png",
    })

    if unilib.global.pkg_executed_table["machine_polishing"] ~= nil then

        unilib.register_craftitem("unilib:mineral_ruby_dark_gem", nil, mode, {
            -- Original to unilib
            description = S("Dark Ruby Gem"),
            inventory_image = "unilib_mineral_ruby_dark_gem.png",
        })
        unilib.register_craft({
            -- Original to unilib
            output = "unilib:mineral_ruby_dark_gem 9",
            recipe = {
                {"unilib:mineral_ruby_dark_block"},
            },
        })

        unilib.register_node("unilib:mineral_ruby_dark_block", nil, mode, {
            -- Original to unilib
            description = S("Dark Ruby Block"),
            tiles = {"unilib_mineral_ruby_dark_block.png"},
            groups = {cracky = 1, level = 3},
            sounds = unilib.global.sound_table.glass,

            is_ground_content = false,
        })
        unilib.register_craft_3x3({
            -- Original to unilib
            output = "unilib:mineral_ruby_dark_block",
            ingredient = "unilib:mineral_ruby_dark_gem",
        })
        unilib.register_stairs("unilib:mineral_ruby_dark_block")
        unilib.register_carvings("unilib:mineral_ruby_dark_block", {
            millwork_flag = true,
        })

    end

end
