---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_onion_wild = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_onion_wild.init()

    return {
        description = "Wild onion",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_onion_wild.exec()

    local orig_name_list = {}
    for i = 1, 5 do
        table.insert(orig_name_list, "ethereal:onion_" .. i)
    end

    unilib.register_produce_fredo({
        -- From ethereal:wild_onion_plant (creates unilib:produce_onion_wild_harvest),
        --      ethereal:onion_1 etc (creates unilib:produce_onion_wild_grow_1 etc)
        part_name = "onion_wild",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "ethereal:wild_onion_plant",
        description = S("Wild Onion"),

        replace_mode = mode,
        eat = 2,
        grow_list = {
            {},
            {},
            {},
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_onion_wild_harvest"}, rarity = 1},
                        {items = {"unilib:produce_onion_wild_harvest 2"}, rarity = 3},
                    }
                },
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_onion_wild_harvest 2"}, rarity = 1},
                        {items = {"unilib:produce_onion_wild_harvest 3"}, rarity = 2},
                    }
                },
            },
        },
        -- N.B. seed = 2 not in original code
        harvest_group_table = {flammable = 2, food_onion = 1, seed = 2},
        min_light = 13,
    })
    if unilib.dye_from_produce_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_white",
            recipe = {
                {"unilib:produce_onion_wild_harvest"},
            },
        })

    end

    unilib.register_decoration("ethereal_produce_onion_wild", {
         -- From ethereal-ng/decor.lua
        deco_type = "simple",
        decoration = "unilib:produce_onion_wild_grow_4",

        fill_ratio = 0.25,
        sidelen = 80,
    })

end
