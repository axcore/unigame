---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_corn_dent = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_corn_dent.init()

    return {
        description = "Dent corn",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_corn_dent.exec()

    local fertility_list = {"desert_soil", "ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "cropocalypse:corn_" .. i)
    end

    unilib.register_crop_mtgame({
        -- From cropocalypse:corn (creates unilib:crop_corn_dent_harvest),
        --      cropocalypse:seed_corn (creates unilib:crop_corn_dent_seed),
        --      cropocalypse:corn_1 etc (creates unilib:crop_corn_dent_grow_1 etc)
        part_name = "corn_dent",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "cropocalypse:corn",
        seed_orig_name = "cropocalypse:seed_corn",
        steps = 8,

        replace_mode = mode,
        eat = 2,
        fertility_list = fertility_list,
        harvest_description = S("Dent Corn"),
        -- N.B. food = 1 not in original code
        harvest_group_table = {flammable = 4, food = 1, food_corn = 1},
        max_light = unilib.light_max,
        min_light = 13,
        paramtype2 = "meshoptions",
        place_param2 = 3,
        seed_description = S("Dent Corn Seed"),
    })

    for i = 4, 5 do

        unilib.override_item("unilib:crop_corn_dent_grow_" .. i, {
            visual_scale = 2.0,
        })

    end

    for i = 6, 8 do

        unilib.override_item("unilib:crop_corn_dent_grow_" .. i, {
            visual_scale = 3.0,
        })

    end

    if unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From cropocalypse:corn
            output = "unilib:dye_yellow 2",
            recipe = {
                {"unilib:crop_corn_dent_harvest"},
            },
        })

    end

end
