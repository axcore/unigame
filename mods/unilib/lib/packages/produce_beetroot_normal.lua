---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_beetroot_normal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_beetroot_normal.init()

    return {
        description = "Normal beetroot",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_beetroot_normal.exec()

    local orig_name_list = {}
    for i = 1, 5 do
        table.insert(orig_name_list, "farming:beetroot_" .. i)
    end

    unilib.register_produce_fredo({
        -- From farming:beetroot (creates unilib:produce_beetroot_normal_harvest),
        --      farming:beetroot_1 etc (creates unilib:produce_beetroot_normal_grow_1 etc)
        part_name = "beetroot_normal",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "farming:beetroot",
        description = S("Normal Beetroot"),

        replace_mode = mode,
        eat = 1,
        grow_list = {
            {},
            {},
            {},
            {},
            {
                drop = {
                    max_items = 4,
                    items = {
                        {items = {"unilib:produce_beetroot_normal_harvest"}, rarity = 1},
                        {items = {"unilib:produce_beetroot_normal_harvest"}, rarity = 2},
                        {items = {"unilib:produce_beetroot_normal_harvest"}, rarity = 3},
                        {items = {"unilib:produce_beetroot_normal_harvest"}, rarity = 4},
                    },
                },
            },
        },
        harvest_group_table = {flammable = 2, food_beetroot = 1, seed = 2},
        waving = 1,
    })
    if unilib.dye_from_produce_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From farming:beetroot
            output = "unilib:dye_red",
            recipe = {
                -- N.B. group:food_beetroot in original code
                {"unilib:produce_beetroot_normal_harvest"},
            },
        })

    end

    unilib.register_decoration("farming_redo_produce_beetroot_normal", {
        -- From farming_redo/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:produce_beetroot_normal_grow_5",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.001,
            seed = 329,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
