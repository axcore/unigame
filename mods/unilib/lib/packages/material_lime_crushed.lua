---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
--
-- From:    plaster
-- Code:    CC BY-SA 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.material_lime_crushed = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.material_lime_crushed.init()

    return {
        description = "Crushed lime",
        notes = "Used in the production of plaster blocks and Antipodean concrete",
        depends = "metal_steel",
        optional = "coral_block_skeleton",
        suggested = {
            "stone_limestone_coquina",          -- group:limestone
        },
    }

end

function unilib.pkg.material_lime_crushed.exec()

    unilib.register_craftitem(
        -- From aotearoa:crushed_lime, also replaces plaster:lime
        "unilib:material_lime_crushed",
        {"aotearoa:crushed_lime", "plaster:lime"},
        mode,
        {
            description = S("Crushed Lime"),
            inventory_image = "unilib_material_lime_crushed.png",
        }
    )
    -- N.B. In original code, only aotearoa limestones could be used in this craft recipe
    unilib.register_craft({
        -- From aotearoa:crushed_lime
        output = "aotearoa:crushed_lime",
        recipe = {
            {"unilib:metal_steel_ingot"},
            {"group:limestone"},
            {"unilib:metal_steel_ingot"},
        },
        replacements = {
            {"unilib:metal_steel_ingot", "unilib:metal_steel_ingot"},
            {"unilib:metal_steel_ingot", "unilib:metal_steel_ingot"},
        },
    })
    if unilib.global.pkg_executed_table["coral_block_skeleton"] ~= nil then

        unilib.register_craft({
            -- From plaster:lime
            type = "shapeless",
            output = "unilib:material_lime_crushed 6",
            recipe = {"unilib:coral_block_skeleton"},
        })

    end

end
