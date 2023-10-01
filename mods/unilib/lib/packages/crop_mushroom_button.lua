---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_mushroom_button = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_mushroom_button.init()

    return {
        description = "Button mushroom (as a crop)",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_mushroom_button.exec()

    local fertility_list = {"desert_soil", "ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "cropocalypse:button_mushroom_" .. i)
    end

    unilib.register_crop_mtgame({
        -- From cropocalypse:button_mushroom (creates unilib:crop_mushroom_button_harvest),
        --      cropocalypse:seed_button_mushroom (creates unilib:crop_mushroom_button_seed),
        --      cropocalypse:button_mushroom_1 etc (creates unilib:crop_mushroom_button_grow_1 etc)
        part_name = "mushroom_button",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "cropocalypse:button_mushroom",
        seed_orig_name = "cropocalypse:button_mushroom",
        steps = 8,

        replace_mode = mode,
        eat = 1,
        fertility_list = fertility_list,
        harvest_description = S("Button Mushroom"),
        -- N.B. food = 1 not in original code
        harvest_group_table = {flammable = 4, food = 1, food_button_mushroom = 1},
        max_light = unilib.light_max,
        min_light = 0,
        paramtype2 = "meshoptions",
        place_param2 = 3,
        seed_description = S("Button Mushroom Spore"),
    })
    if unilib.dye_from_crops_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            -- N.B. For mushroom crops, output is only 1 instead of the usual 2
            output = "unilib:dye_white",
            recipe = {
                {"unilib:crop_mushroom_button_harvest"},
            },
        })

    end

end
