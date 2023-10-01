---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_beetroot_merlin = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_beetroot_merlin.init()

    return {
        description = "Merlin beetroot",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_beetroot_merlin.exec()

    local fertility_list = {"ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 4 do
        table.insert(orig_name_list, "better_farming:beetroot_" .. i)
    end

    unilib.register_crop_mtgame({
        -- From better_farming:beetroot (creates unilib:crop_beetroot_merlin_harvest),
        --      better_farming:seed_beetroot (creates unilib:crop_beetroot_merlin_seed),
        --      better_farming:beetroot_1 etc (creates unilib:crop_beetroot_merlin_grow_1 etc)
        part_name = "beetroot_merlin",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "better_farming:beetroot",
        seed_orig_name = "better_farming:seed_beetroot",
        steps = 4,

        replace_mode = mode,
        eat = 1,
        fertility_list = fertility_list,
        harvest_description = S("Merlin Beetroot"),
        -- N.B. food_beetroot not in original code
        harvest_group_table = {flammable = 4, food_beetroot = 1},
        min_light = 7,
        seed_description = S("Merlin Beetroot Seed"),
        seed_group_table = {attached_node = 1, flammable = 2, seed = 1, snappy = 3},
    })
    if unilib.dye_from_crops_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_magenta 2",
            recipe = {
                {"unilib:crop_beetroot_merlin_harvest"},
            },
        })

    end

    unilib.register_decoration("better_farming_crop_beetroot_merlin", {
        -- From better_farming:beetroot_4
        deco_type = "simple",
        decoration = "unilib:crop_beetroot_merlin_grow_4",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            -- N.B. scale was 0.1 in original code
            scale = 0.001,
            seed = 5620,
            spread = {x = 50, y = 50, z = 50},
        },
        param2 = 3,
        sidelen = 16,
    })

end
