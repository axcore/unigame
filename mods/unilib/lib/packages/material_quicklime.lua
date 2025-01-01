---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
--
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.material_quicklime = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.material_quicklime.init()

    return {
        description = "Quicklime",
        notes = "Used in the production of Antipodean concrete",
        at_least_one = {"coral_block_skeleton", "gravel_ordinary", "material_lime_crushed"},
    }

end

function unilib.pkg.material_quicklime.exec()

    unilib.register_craftitem(
        -- From aotearoa:quicklime
        "unilib:material_quicklime",
        {"aotearoa:quicklime", "earthbuild:quicklime"},
        mode,
        {
            description = S("Quicklime"),
            inventory_image = "unilib_material_quicklime.png",
        }
    )
    if unilib.global.pkg_executed_table["material_lime_crushed"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:quicklime
            type = "cooking",
            output = "unilib:material_quicklime",
            recipe = "unilib:material_lime_crushed",
        })

    -- If other aotearoa packages are loaded, then don't use this easily-found ingredient...
    elseif unilib.global.pkg_executed_table["gravel_ordinary"] ~= nil then

        unilib.register_craft({
            -- From earthbuild:quicklime
            type = "cooking",
            output = "unilib:material_quicklime 6",
            recipe = "unilib:gravel_ordinary",
            cooktime = 3,
        })

    end

    -- ...but do use this one, if possible
    if unilib.global.pkg_executed_table["coral_block_skeleton"] ~= nil then

        unilib.register_craft({
            -- From earthbuild:quicklime
            type = "cooking",
            output = "unilib:material_quicklime 9",
            recipe = "unilib:coral_block_skeleton",
            cooktime = 3,
        })

    end

end
