---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    uchutechnic
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.meta_uchu_technic_extra = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.uchutechnic.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.meta_uchu_technic_extra.init()

    return {
        description = "Extra grinder/compressor/extractor/separator recipes for various items" ..
                " from technic",
        mod_depends = "technic",
        optional = {
            "clay_ordinary",
            "flower_fire",
            "mineral_coal",
            "mineral_ruby",
            "misc_granules_coal",
            "misc_granules_fiery",
            "misc_granules_ruby",
            "mushroom_green",
            "sand_ordinary",
            "stone_slimestone_green_extra",
            "vine_underground",
        },
    }

end

function unilib.pkg.meta_uchu_technic_extra.exec()

    if unilib.setting.technic_extra_flag then

        if unilib.global.pkg_executed_table["vine_underground"] ~= nil then

            technic.register_grinder_recipe({
                input = {"unilib:vine_underground"},
                output = "technic:sawdust",
            })

        end

        if unilib.global.pkg_executed_table["mineral_ruby"] ~= nil and
                unilib.global.pkg_executed_table["misc_granules_ruby"] ~= nil then

            technic.register_grinder_recipe({
                input = {"unilib:mineral_ruby_gem"},
                output = "unilib:misc_granules_ruby_block",
            })

            technic.register_compressor_recipe({
                input = {"unilib:misc_granules_ruby_block"},
                output = "unilib:mineral_ruby_gem",
            })

        end

        if unilib.global.pkg_executed_table["mineral_coal"] ~= nil and
                unilib.global.pkg_executed_table["misc_granules_coal"] ~= nil then

            technic.register_compressor_recipe({
                input = {"unilib:misc_granules_coal_block"},
                output = "unilib:mineral_coal_lump",
            })

        end

        if unilib.global.pkg_executed_table["mushroom_green"] ~= nil and
                unilib.global.pkg_executed_table["stone_slimestone_green_extra"] ~= nil then

            technic.register_extractor_recipe({
                input = {"unilib:mushroom_green 10"},
                output = "unilib:stone_slimestone_green_block_slimy",
            })

        end

        if unilib.global.pkg_executed_table["clay_ordinary"] ~= nil and
                unilib.global.pkg_executed_table["flower_fire"] ~= nil and
                unilib.global.pkg_executed_table["misc_granules_fiery"] ~= nil and
                unilib.global.pkg_executed_table["sand_ordinary"] ~= nil then

            technic.register_separating_recipe({
                input = {"unilib:misc_granules_fiery_block 4"},
                output = {
                    "unilib:sand_ordinary 3",
                    "unilib:clay_ordinary_lump 4",
                    "unilib:flower_fire_dust",
                },
            })

        end

    end

end
