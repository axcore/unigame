---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_potato_sweet = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_potato_sweet.init()

    return {
        description = "Sweet potato",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_potato_sweet.exec()

    local fertility_list = {"desert_soil", "ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "cropocalypse:potato_" .. i)
    end

    unilib.register_crop_mtgame({
        -- From cropocalypse:potato (creates unilib:crop_potato_sweet_harvest),
        --      cropocalypse:seed_potato (creates unilib:crop_potato_sweet_seed),
        --      cropocalypse:potato_1 etc (creates unilib:crop_potato_sweet_grow_1 etc)
        part_name = "potato_sweet",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "cropocalypse:potato",
        seed_orig_name = "cropocalypse:potato",
        steps = 8,

        replace_mode = mode,
        eat = 1,
        fertility_list = fertility_list,
        harvest_description = S("Sweet Potato"),
        -- N.B. food = 1 not in original code
        harvest_group_table = {flammable = 4, food = 1, food_potato = 1},
        max_light = unilib.light_max,
        min_light = 13,
        paramtype2 = "meshoptions",
        place_param2 = 3,
        seed_description = S("Sweet Potato Seed"),
    })

    if unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From cropocalypse:potato
            output = "unilib:dye_magenta 2",
            recipe = {
                {"unilib:crop_potato_sweet_harvest"},
            },
        })

    end

end
