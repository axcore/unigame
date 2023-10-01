---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.material_gum_kauri = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.material_gum_kauri.init()

    return {
        description = "Kauri gum",
        optional = {"dye_basic", "torch_ordinary"},
    }

end

function unilib.pkg.material_gum_kauri.exec()

    unilib.register_craftitem("unilib:material_gum_kauri", "aotearoa:kauri_gum", mode, {
        -- From aotearoa:kauri_gum
        description = S("Kauri Gum"),
        inventory_image = "unilib_material_gum_kauri.png",
    })
    unilib.register_craft({
        -- From aotearoa:kauri_gum
        type = "fuel",
        recipe = "unilib:material_gum_kauri",
        burntime = 3,
    })
    if unilib.pkg_executed_table["torch_ordinary"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:kauri_gum
            output = "unilib:torch_ordinary 4",
            recipe = {
                {"unilib:material_gum_kauri"},
                {"group:stick"},
            }
        })

        if unilib.pkg_executed_table["dye_basic"] ~= nil then

            -- Black dye from Kauri gum soot
            unilib.register_craft({
                 -- From aotearoa:kauri_gum
                output = "unilib:dye_black 4",
                recipe = {
                    {"unilib:material_gum_kauri"},
                    {"unilib:torch_ordinary"},
                },
                replacements = {
                    {"unilib:torch_ordinary", "unilib:torch_ordinary"},
                },
            })

        end

    end

end
