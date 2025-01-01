---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_beef_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_beef_normal.init()

    return {
        description = "Normal beef",
        mod_optional = {"animalia", "mobs_animal", "petz"},
    }

end

function unilib.pkg.food_beef_normal.exec()

    unilib.register_craftitem("unilib:food_beef_normal_raw", "bbq:beef_raw", mode, {
        -- From bbq:beef_raw
        description = S("Raw Normal Beef"),
        inventory_image = "unilib_food_beef_normal_raw.png",

        on_use = unilib.cuisine.eat_on_use("unilib:food_beef_normal_raw", 3),
    })

    unilib.register_craftitem("unilib:food_beef_normal_cooked", "bbq:beef", mode, {
        -- From bbq:beef
        description = S("Normal Beef"),
        inventory_image = "unilib_food_beef_normal_cooked.png",

        on_use = unilib.cuisine.eat_on_use("unilib:food_beef_normal_cooked", 8),
    })
    unilib.register_craft({
        -- From bbq:beef
        type = "cooking",
        output = "unilib:food_beef_normal_cooked",
        recipe = "unilib:food_beef_normal_raw",
        cooktime = 5,
    })

    -- N.B. The original code override cows from the "mobs_animal" mod to drop this, instead of that
    --      mod's own beef (but doesn't do the same for any other animal product
    if core.registered_items["mobs_animal:cow"] ~= nil then

        local def_table = core.registered_entities["mobs_animal:cow"]
        def_table.drops = {
            {name = "unilib:food_beef_normal_raw", chance = 1, min = 1, max = 3},
            {name = "mobs:leather", chance = 1, min = 1, max = 2},
        }

    end

    -- N.B. For consistency, we have to do the same thing with petz and animalia
    if core.registered_items["animalia:cow"] ~= nil then

        local def_table = core.registered_entities["animalia:cow"]
        def_table.drops = {
            {name = "unilib:food_beef_normal_raw", min = 1, max = 3, chance = 1},
            {name = "animalia:leather", min = 1, max = 3, chance = 2}
        }

    end

    if core.registered_items["petz:calf"] ~= nil then

        local def_table = core.registered_entities["petz:calf"]
        def_table.drops = {
            {name = "unilib:food_beef_normal_raw", chance = 1, min = 1, max = 1},
            {name = "petz:leather", chance = 2, min = 1, max = 1},
            {name = "petz:bone", chance = 4, min = 1, max = 1},
        }

    end

end
