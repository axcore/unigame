---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.potion_lycanthropy = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.potion_lycanthropy.init()

    return {
        description = "Lycanthropy remedy",
        depends = {
            "dye_basic",
            "ingredient_oil_beaver",
            "organ_fur_wolf",
            "organ_jaw_wolf",
            "shared_petz_lycanthropy",
            "vessel_bottle_glass_empty",
        },
    }

end

function unilib.pkg.potion_lycanthropy.exec()

    unilib.register_craftitem("unilib:potion_lycanthropy", "petz:lycanthropy_remedy", mode, {
        -- From petz:lycanthropy_remedy
        description = S("Lycanthropy Remedy"),
        inventory_image = "unilib_potion_lycanthropy.png",

        wield_image = "unilib_potion_lycanthropy.png",

        on_use = function(itemstack, user, pointed_thing)

            if unilib.pkg.shared_petz_lycanthropy.has_lycanthropy(user) then
                unilib.pkg.shared_petz_lycanthropy.cure_player(user)
            end

            -- N.B. Advanced cuisine does not apply to this item
            return core.do_item_eat(
                0, "unilib:vessel_bottle_glass_empty", itemstack, user, pointed_thing
            )

        end,
    })
    unilib.register_craft({
        -- From petz:lycanthropy_remedy
        type = "shaped",
        output = "unilib:potion_lycanthropy",
        recipe = {
            {"", "unilib:organ_jaw_wolf", ""},
            {"unilib:dye_white", "unilib:organ_fur_wolf", "unilib:dye_violet"},
            {"", "unilib:ingredient_oil_beaver", ""},
        },
    })

end
