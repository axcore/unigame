---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    carts
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.cart_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.carts.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.cart_ordinary.init()

    return {
        description = "Ordinary cart",
        depends = {"metal_steel", "shared_carts"},
    }

end

function unilib.pkg.cart_ordinary.exec()

    unilib.pkg.shared_carts.register_cart({
        -- From carts:cart. Creates unilib:cart_ordinary
        part_name = "ordinary",
        orig_name = "carts:cart",

        replace_mode = mode,
        description = S("Ordinary Cart"),
        ingredient = "unilib:metal_steel_ingot",
    })

end
