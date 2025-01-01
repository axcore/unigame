---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_jet = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_jet.init()

    return {
        description = "Jet (as a mineral)",
        optional = "machine_polishing",
    }

end

function unilib.pkg.mineral_jet.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "jet",
        description = S("Jet"),

        hardness = 1,
    })

    unilib.register_craftitem("unilib:mineral_jet_lump", "real_minerals:jet", mode, {
        -- From real_minerals:jet
        description = S("Jet Lump"),
        inventory_image = "unilib_mineral_jet_lump.png",
    })

    if unilib.global.pkg_executed_table["machine_polishing"] ~= nil then

        unilib.register_craftitem("unilib:mineral_jet_gem", nil, mode, {
            -- Original to unilib
            description = S("Jet Gem"),
            inventory_image = "unilib_mineral_jet_gem.png",
        })
        unilib.register_craft({
            -- Original to unilib
            output = "unilib:mineral_jet_gem 9",
            recipe = {
                {"unilib:mineral_jet_block"},
            },
        })

        unilib.register_node("unilib:mineral_jet_block", nil, mode, {
            -- Original to unilib
            description = S("Jet Block"),
            tiles = {"unilib_mineral_jet_block.png"},
            groups = {cracky = 1, level = 3},
            sounds = unilib.global.sound_table.glass,

            is_ground_content = false,
        })
        unilib.register_craft_3x3({
            -- Original to unilib
            output = "unilib:mineral_jet_block",
            ingredient = "unilib:mineral_jet_gem",
        })
        unilib.register_stairs("unilib:mineral_jet_block")
        unilib.register_carvings("unilib:mineral_jet_block", {
            millwork_flag = true,
        })

    end

end
