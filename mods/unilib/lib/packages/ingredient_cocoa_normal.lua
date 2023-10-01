---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/cacaotree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_cocoa_normal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cacaotree.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_cocoa_normal.init()

    return {
        description = "Normal cocoa beans and powder",
        notes = "Normal cocoa beans are dropped when digging pods on cacao trees. Throughout" ..
                " unilib, the tree is spelled \"cacao\", and the beans are spelled \"cocoa\"",
    }

end

function unilib.pkg.ingredient_cocoa_normal.exec()

    unilib.register_craftitem(
        -- From cacaotree:cacao_beans
        "unilib:ingredient_cocoa_normal_beans",
        "cacaotree:cacao_beans",
        mode,
        {
            description = S("Normal Cocoa Beans"),
            inventory_image = "unilib_ingredient_cocoa_normal_beans.png"
        }
    )

    unilib.register_craftitem(
        -- From cacaotree:cocoa_powder
        "unilib:ingredient_cocoa_normal_powder",
        "cacaotree:cocoa_powder",
        mode,
        {
            description = S("Normal Cocoa Powder"),
            inventory_image = "unilib_ingredient_cocoa_normal_powder.png"
        }
    )
    unilib.register_craft({
        -- From cacaotree:cocoa_powder
        type = "cooking",
        output = "unilib:ingredient_cocoa_normal_powder",
        recipe = "unilib:ingredient_cocoa_normal_beans",
        cooktime = 2,
    })

end
