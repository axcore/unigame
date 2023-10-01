---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_beet_common = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_beet_common.init()

    return {
        description = "Common beet",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_beet_common.exec()

    local fertility_list = {"desert_soil", "ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "cropocalypse:beet_" .. i)
    end

    unilib.register_crop_mtgame({
        -- From cropocalypse:beet (creates unilib:crop_beet_common_harvest),
        --      cropocalypse:seed_beet (creates unilib:crop_beet_common_seed),
        --      cropocalypse:beet_1 etc (creates unilib:crop_beet_common_grow_1 etc)
        part_name = "beet_common",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "cropocalypse:beet",
        seed_orig_name = "cropocalypse:seed_beet",
        steps = 8,

        replace_mode = mode,
        eat = 1,
        fertility_list = fertility_list,
        harvest_description = S("Common Beet"),
        -- N.B. food = 1 not in original code
        harvest_group_table = {flammable = 4, food = 1, food_beet = 1},
        max_light = unilib.light_max,
        min_light = 13,
        seed_description = S("Common Beet Seed"),
    })

    if unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From cropocalypse:beet
            output = "unilib:dye_white 2",
            recipe = {
                {"unilib:crop_beet_common_harvest"},
            },
        })

    end

end
