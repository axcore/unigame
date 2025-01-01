---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_hotpot_dandelion = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_hotpot_dandelion.init()

    return {
        description = "Dandelion hotpot",
        depends = "flower_dandelion_yellow",
        suggested = {
            "bucket_steel",                     -- group:potable_bucket
        },
    }

end

function unilib.pkg.food_hotpot_dandelion.exec()

    unilib.register_craftitem(
        -- From cucina_vegana:dandelion_suds
        "unilib:food_hotpot_dandelion_raw",
        "cucina_vegana:dandelion_suds",
        mode,
        {
            description = S("Uncooked Dandelion Hotpot"),
            inventory_image = "unilib_food_hotpot_dandelion_raw.png",
            -- N.B. sud = 1 in original code
            groups = {food_hotpot = 1},
        }
    )

    unilib.register_craftitem(
        -- From cucina_vegana:dandelion_suds_cooking
        "unilib:food_hotpot_dandelion_cooked",
        "cucina_vegana:dandelion_suds_cooking",
        mode,
        {
            description = S("Cooked Dandelion Hotpot"),
            inventory_image = "unilib_food_hotpot_dandelion_cooked.png",
            -- N.B. sud = 1 in original code
            groups = {food_hotpot = 1},
        }
    )
    unilib.register_craft({
        -- From cucina_vegana:dandelion_suds_cooking
        type = "cooking",
        output = "unilib:food_hotpot_dandelion_cooked",
        recipe = "unilib:food_hotpot_dandelion_raw",
        cooktime = 20,
    })

end

function unilib.pkg.food_hotpot_dandelion.post()

    local c_dandelion = "unilib:flower_dandelion_yellow"

    unilib.register_craft({
        -- From cucina_vegana:dandelion_suds
        output = "unilib:food_hotpot_dandelion_raw",
        recipe = {
            {c_dandelion, c_dandelion, c_dandelion},
            {c_dandelion, c_dandelion, c_dandelion},
            {"", "group:potable_bucket", ""},
        },
        -- N.B. Not in original code
        replacements = unilib.global.potable_bucket_list,
    })

end
