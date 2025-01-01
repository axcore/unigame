---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bonemeal
-- Code:    MIT
-- Media:   CC0-1.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_gelatin_powder = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bonemeal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_gelatin_powder.init()

    return {
        description = "Gelatin powder",
        depends = "torch_ordinary",
        suggested = {
            "bucket_steel",                     -- group:potable_bucket
            "item_bone",                        -- group:bone
        },
    }

end

function unilib.pkg.ingredient_gelatin_powder.exec()

    unilib.register_craftitem("unilib:ingredient_gelatin_powder", "bonemeal:gelatin_powder", mode, {
        -- From bonemeal:gelatin_powder
        description = S("Gelatin Powder"),
        inventory_image = "unilib_ingredient_gelatin_powder.png",
        groups = {flammable = 2, food_gelatin = 1}
    })

end

function unilib.pkg.ingredient_gelatin_powder.post()

    local replace_list = {}
    for _, mini_list in pairs(unilib.global.potable_bucket_list) do
        table.insert(replace_list, {mini_list[1], mini_list[2] .. " 5"})
    end

    unilib.register_craft({
        -- From bonemeal:gelatin_powder
        output = "unilib:ingredient_gelatin_powder 4",
        recipe = {
            {"group:bone", "group:bone", "group:bone"},
            {"group:potable_bucket", "group:potable_bucket", "group:potable_bucket"},
            {"group:potable_bucket", "unilib:torch_ordinary", "group:potable_bucket"},
        },
        replacements = replace_list,
    })

end
