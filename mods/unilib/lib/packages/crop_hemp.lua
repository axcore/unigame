---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_hemp = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_hemp.init()

    return {
        description = "Hemp",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_hemp.exec()

    local fertility_list = {"ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "farming:hemp_" .. i)
    end

    unilib.register_crop_fredo({
        -- From farming:hemp (creates unilib:crop_hemp_harvest), farming:seed_hemp (creates
        --      unilib:crop_hemp_seed), farming:hemp_1 etc (creates unilib:crop_hemp_grow_1 etc)
        part_name = "hemp",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "farming:hemp_leaf",
        seed_orig_name = "farming:seed_hemp",
        steps = 8,

        replace_mode = mode,
        fertility_list = fertility_list,
        grow_list = {
            {},
            {},
            {},
            {},
            {},
            {
                drop = {
                    items = {
                        {items = {"unilib:crop_hemp_harvest"}, rarity = 2},
                        {items = {"unilib:crop_hemp_seed"}, rarity = 1},
                    },
                },
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:crop_hemp_harvest"}, rarity = 1},
                        {items = {"unilib:crop_hemp_harvest"}, rarity = 3},
                        {items = {"unilib:crop_hemp_seed"}, rarity = 1},
                        {items = {"unilib:crop_hemp_seed"}, rarity = 3},
                    },
                },
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:crop_hemp_harvest 2"}, rarity = 1},
                        {items = {"unilib:crop_hemp_harvest"}, rarity = 2},
                        {items = {"unilib:crop_hemp_seed"}, rarity = 1},
                        {items = {"unilib:crop_hemp_seed"}, rarity = 2},
                    },
                },
            },
        },
        harvest_description = S("Hemp Leaf"),
        harvest_group_table = {},
        seed_description = S("Hemp Seed"),
    })
    if unilib.setting.dye_from_crops_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_green 2",
            recipe = {
                {"unilib:crop_hemp_harvest"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:crop_hemp_harvest",
        juice_description = S("Hemp"),
        juice_type = "hemp",
        rgb = "#a9b17d",

        orig_flag = false,
    })

    unilib.register_decoration_generic("farming_redo_crop_hemp", {
        -- From farming_redo/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:crop_hemp_grow_7",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.003,
            seed = 420,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
