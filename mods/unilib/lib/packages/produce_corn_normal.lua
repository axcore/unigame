---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_corn_normal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_corn_normal.init()

    return {
        description = "Normal corn",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_corn_normal.exec()

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "farming:corn_" .. i)
    end

    unilib.register_produce_fredo({
        -- From farming:corn (creates unilib:produce_corn_normal_harvest), farming:corn_1 etc
        --      (creates unilib:produce_corn_normal_grow_1 etc)
        part_name = "corn_normal",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "farming:corn",
        description = S("Normal Corn"),

        replace_mode = mode,
        eat = 3,
        grow_list = {
            {},
            {},
            {},
            {},
            {},
            {
                visual_scale = 1.90,
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_corn_normal_harvest"}, rarity = 1},
                        {items = {"unilib:produce_corn_normal_harvest"}, rarity = 2},
                        {items = {"unilib:produce_corn_normal_harvest"}, rarity = 3},
                    }
                },
                visual_scale = 1.90,
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_corn_normal_harvest 2"}, rarity = 1},
                        {items = {"unilib:produce_corn_normal_harvest 2"}, rarity = 2},
                        {items = {"unilib:produce_corn_normal_harvest 2"}, rarity = 2},
                    }
                },
                visual_scale = 1.90,
            },
        },
        harvest_group_table = {flammable = 2, food_corn = 1, seed = 2},
    })
    if unilib.dye_from_produce_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_yellow",
            recipe = {
                {"unilib:produce_corn_normal_harvest"},
            },
        })

    end

    unilib.register_decoration("farming_redo_produce_corn_normal", {
        -- From farming_redo/mapgen.lua
        -- N.B. The original code does not use the final growth stage for the decoration
        deco_type = "simple",
        decoration = "unilib:produce_corn_normal_grow_7",

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
