---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_seed_sunflower_dwarf = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_seed_sunflower_dwarf.init()

    return {
        description = "Dwarf sunflower seeds (as food)",
        depends = {"crop_sunflower_dwarf", "dye_basic"},
        optional = "flower_helianthus",
    }

end

function unilib.pkg.food_seed_sunflower_dwarf.exec()

    unilib.register_craftitem(
        -- From cucina_vegana:sunflower_seeds
        "unilib:food_seed_sunflower_dwarf",
        "cucina_vegana:sunflower_seeds",
        mode,
        {
            description = S("Dwarf Sunflower Seeds"),
            inventory_image = "unilib_food_seed_sunflower_dwarf.png",
            groups = {eatable = 1, food = 1, food_sunflower = 1, seed = 1},

            on_use = unilib.cuisine_eat_on_use("unilib:food_seed_sunflower_dwarf", 1),
        }
    )
    unilib.register_craft({
        -- From cucina_vegana:sunflower_seeds
        type = "shapeless",
        output = "unilib:food_seed_sunflower_dwarf 4",
        recipe = {"unilib:crop_sunflower_dwarf_harvest"},
        replacements = {
            {"unilib:crop_sunflower_dwarf_harvest", "unilib:dye_yellow"}
        },
    })
    unilib.register_craft({
        -- From cucina_vegana:sunflower_seeds
        type = "fuel",
        recipe = "unilib:food_seed_sunflower_dwarf",
        burntime = 2,
    })

    unilib.register_craftitem(
        -- From cucina_vegana:sunflower_seeds_roasted
        "unilib:food_seed_sunflower_dwarf_roasted",
        "cucina_vegana:sunflower_seeds_roasted",
        mode,
        {
            description = S("Roasted Dwarf Sunflower Seeds"),
            inventory_image = "unilib_food_seed_sunflower_dwarf_roasted.png",
            groups = {eatable = 1, food = 1},

            on_use = unilib.cuisine_eat_on_use("unilib:food_seed_sunflower_dwarf_roasted", 2),
        }
    )
    unilib.register_craft({
        -- From cucina_vegana:sunflower_seeds_roasted
        type = "cooking",
        output = "unilib:food_seed_sunflower_dwarf_roasted",
        recipe = "unilib:food_seed_sunflower_dwarf",
        -- N.B. no cooktime in original code
        cooktime = 10,
    })
    unilib.register_craft({
        -- From cucina_vegana:sunflower_seeds_roasted
        type = "fuel",
        recipe = "unilib:food_seed_sunflower_dwarf_roasted",
        burntime = 2,
    })
    if unilib.technic_extra_flag then

        technic.register_separating_recipe({
            -- From cucina_vegana:sunflower_seeds
            output = {"unilib:food_seed_sunflower_dwarf 4", "unilib:dye_yellow", nil},
            input = {"unilib:crop_sunflower_dwarf_harvest"},
        })

        if unilib.pkg_executed_table["flower_helianthus"] ~= nil then

            technic.register_separating_recipe({
                -- From cucina_vegana:sunflower_seeds
                output = {"unilib:food_seed_sunflower_dwarf 4", "unilib:dye_yellow", nil},
                input = {"unilib:flower_helianthus"},
            })

            technic.register_extractor_recipe({
                -- From cucina_vegana:sunflower_seeds
                output = "unilib:food_seed_sunflower_dwarf 4",
                input = {"unilib:flower_helianthus"},
            })

        end

        technic.register_extractor_recipe({
            -- From cucina_vegana:sunflower_seeds
            output = "unilib:food_seed_sunflower_dwarf 4",
            input = {"unilib:crop_sunflower_dwarf_harvest"},
        })

    end

end
