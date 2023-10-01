---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.material_lime_slaked = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.earthbuild.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.material_lime_slaked.init()

    return {
        description = "Whitewash (slaked lime)",
        notes = "Used to whitewash several items from earthbuild, which therefore look identical",
        depends = "material_quicklime",
    }

end

function unilib.pkg.material_lime_slaked.exec()

    unilib.register_craftitem("unilib:material_lime_slaked", "earthbuild:whitewash", mode, {
        -- From earthbuild:whitewash
        description = unilib.brackets(S("Whitewash"), S("Slaked Lime")),
        inventory_image = "unilib_material_lime_slaked.png",
    })

end

function unilib.pkg.material_lime_slaked.post()

    local c_quicklime = "unilib:material_quicklime"

    unilib.register_craft({
        -- From earthbuild:whitewash
        output = "unilib:material_lime_slaked 6",
        recipe = {
            {c_quicklime, c_quicklime, c_quicklime},
            {c_quicklime, c_quicklime, c_quicklime},
            {"", "group:craftable_bucket", ""},
        },
        replacements = unilib.craftable_bucket_list,
    })

end
