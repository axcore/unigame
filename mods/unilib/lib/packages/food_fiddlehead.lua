---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/ferns
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_fiddlehead = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ferns.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_fiddlehead.init()

    return {
        description = "Fiddlehead",
        notes = "Harvested from ordinary ferns and fern trees. Slightly poisonous when raw," ..
                "  edible when cooked",
        at_least_one = {"fern_ordinary", "fern_ordinary_tuber", "tree_fern"},
    }

end

function unilib.pkg.food_fiddlehead.exec()

    unilib.register_craftitem("unilib:food_fiddlehead", "ferns:fiddlehead", mode, {
        -- From ferns:fiddlehead
        description = S("Raw Fiddlehead"),
        inventory_image = "unilib_food_fiddlehead.png",
        -- N.B. No groups in original code
        groups = {food_fiddlehead = 1},

        -- N.B. No call to unilib.cuisine.eat_on_use(); checking food history doesn't matter for
        --      poisonous foods
        on_use = core.item_eat(-1),
    })
    if unilib.global.pkg_executed_table["fern_ordinary"] ~= nil and
            unilib.global.pkg_executed_table["fern_ordinary_tuber"] ~= nil then

        unilib.register_craft({
            -- From ferns:fiddlehead
            type = "shapeless",
            output = "unilib:food_fiddlehead 3",
            recipe = {
                "unilib:fern_ordinary_1",
            },
            replacements = {
                {"unilib:fern_ordinary_1", "unilib:fern_ordinary_tuber"},
            },
        })

    end
    if unilib.global.pkg_executed_table["tree_fern"] ~= nil then

        unilib.register_craft({
            -- From ferns:fiddlehead
            type = "shapeless",
            output = "unilib:food_fiddlehead 3",
            recipe = {
                "unilib:tree_fern_crown_large",
            },
            replacements = {
                {"unilib:tree_fern_crown_large", "unilib:tree_fern_sapling"},
            },
        })

    end

    unilib.register_craftitem("unilib:food_fiddlehead_cooked", "ferns:fiddlehead_roasted", mode, {
        -- From ferns:fiddlehead_roasted
        description = S("Roasted Fiddlehead"),
        inventory_image = "unilib_food_fiddlehead_cooked.png",
        -- N.B. No groups in original code
        groups = {food_fiddlehead = 1},

--      on_use = core.item_eat(1),
        on_use = unilib.cuisine.eat_on_use("unilib:food_fiddlehead_cooked", 1),
    })
    unilib.register_craft({
        -- From ferns:fiddlehead_roasted
        type = "cooking",
        output = "unilib:food_fiddlehead_cooked",
        recipe = "unilib:food_fiddlehead",
        cooktime = 1,
    })

end
