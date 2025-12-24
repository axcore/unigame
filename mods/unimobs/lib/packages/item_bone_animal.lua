---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_bone_animal = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_bone_animal.init()

    return {
        description = "Animal bone",
        notes = "This is the only body part from the petz modpack which isn't in the \"organ\"" ..
                " category",
        optional = "item_bone",
    }

end

function unilib.pkg.item_bone_animal.exec()

    unilib.register_craftitem("unilib:item_bone_animal", "petz:bone", mode, {
        -- From petz:bone
        description = S("Animal bone"),
        inventory_image = "unilib_item_bone_animal.png",
        groups = {bone = 1},

        wield_image = "unilib_item_bone_animal.png",
    })
    if unilib.global.pkg_executed_table["item_bone"] ~= nil then

        -- (Convert bones from the petz and bonemeal mods)
        unilib.register_craft({
            -- From petz:bone
            type = "shapeless",
            output = "unilib:item_bone_animal 2",
            recipe = {"unilib:item_bone", "unilib:item_bone"},
        })

        unilib.register_craft({
            -- From petz:bone
            type = "shapeless",
            output = "unilib:item_bone 2",
            recipe = {"unilib:item_bone_animal", "unilib:item_bone_animal"},
        })

    end

end
