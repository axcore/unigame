---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_flax_brown = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_flax_brown.init()

    return {
        description = "Brown flax",
        optional = {"dye_basic", "item_string_ordinary"},
    }

end

function unilib.pkg.crop_flax_brown.exec()

    local c_harvest = "unilib:crop_flax_brown_harvest"

    local fertility_list = {"desert_soil", "ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "cropocalypse:flax_" .. i)
    end

    unilib.register_crop_mtgame({
        -- From cropocalypse:flax (creates unilib:crop_flax_brown_harvest),
        --      cropocalypse:seed_flax (creates unilib:crop_flax_brown_seed),
        --      cropocalypse:flax_1 etc (creates unilib:crop_flax_brown_grow_1 etc)
        part_name = "flax_brown",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "cropocalypse:flax",
        seed_orig_name = "cropocalypse:seed_flax",
        steps = 8,

        replace_mode = mode,
        fertility_list = fertility_list,
        harvest_description = S("Brown Flax"),
        -- N.B. string = 1 not in original code; added to match "crop_flax_golden" package
        harvest_group_table = {crop_flax = 1, flammable = 4, string = 1},
        max_light = unilib.constant.light_max,
        min_light = 13,
        place_param2 = 3,
        seed_description = S("Brown Flax Seed"),
        -- N.B. Not in original code; added to match code in "crop_flax_brown" package
        seed_group_table = {attached_node = 1, flammable = 4, seed_flax = 1},
    })
    if unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        -- N.B. In original code, flax creates a light blue dye (but that dye was not imported)
        unilib.register_craft({
            -- From cropocalypse:flax
            output = "unilib:dye_cyan 2",
            recipe = {
                {"unilib:crop_flax_brown_harvest"},
            },
        })

    end
    if unilib.global.pkg_executed_table["item_string_ordinary"] ~= nil then

        unilib.register_craft({
            -- From cropocalypse:flax
            type = "shapeless",
            output = "unilib:item_string_ordinary 2",
            recipe = {c_harvest, c_harvest, c_harvest},
        })

    end

end
