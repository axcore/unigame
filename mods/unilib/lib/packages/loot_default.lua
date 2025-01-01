---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.loot_default = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.loot_default.init()

    return {
        description = "Dungeon loot from the \"default\" mod (but actually declared in the" ..
               " \"dungeon_loot\" mod)",
        notes = "Very few mods (besides those in minetest_game) provide dungeon_loot; therefore," ..
                " only dungeon loot from minetest_game itself has been imported into unilib." ..
                " Remix writers who want a wider variety of items as dungeon loot should write" ..
                " their own packages, modelled after this one. This package registers items" ..
                " from default as dungeon loot, if available",
        mod_depends = "dungeon_loot",
        -- (Don't declare optional packages; it's up to the remix to decide which of these packages
        --      should be executed)
        --[[
        optional = {
            "dirt_ordinary",
            "fruit_apple",
            "item_stick_ordinary",
            "metal_gold",
            "metal_steel",
            "mineral_coal",
            "mineral_flint",
            "mineral_mese",
            "plant_cactus_ordinary",
            "sand_desert",
            "sand_ordinary",
            "snow_ordinary",
            "stone_desert",
            "stone_obsidian",
            "tool_axe_diamond",
            "tool_pick_stone",
            "tool_sword_wood",
        },
        ]]--
    }

end

function unilib.pkg.loot_default.post()

    -- Adapted from dungeon_loot/loot.lua
    local loot_table = {}

    if unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil then

        table.insert(loot_table, {
            name = "unilib:dirt_ordinary",
            chance = 0.6,
            count = {2, 16},
            types = {"desert", "normal", "sandstone"},
            y = {-64, 32768},
        })

    end

    if unilib.global.pkg_executed_table["fruit_apple"] ~= nil then

        table.insert(loot_table, {
            name = "unilib:fruit_apple",
            chance = 0.4,
            count = {1, 4},
        })

    end

    if unilib.global.pkg_executed_table["item_stick_ordinary"] ~= nil then

        table.insert(loot_table, {
            name = "unilib:item_stick_ordinary",
            chance = 0.6,
            count = {3, 6},
        })

    end

    if unilib.global.pkg_executed_table["metal_gold"] ~= nil then

        table.insert(loot_table, {
            name = "unilib:metal_gold_ingot",
            chance = 0.5,
        })

    end

    if unilib.global.pkg_executed_table["metal_steel"] ~= nil then

        table.insert(loot_table, {
            name = "unilib:metal_steel_ingot",
            chance = 0.4,
            count = {1, 6},
        })

    end

    if unilib.global.pkg_executed_table["mineral_coal"] ~= nil then

        table.insert(loot_table, {
            name = "unilib:mineral_coal_lump",
            chance = 0.9,
            count = {1, 12},
        })

    end

    if unilib.global.pkg_executed_table["mineral_flint"] ~= nil then

        table.insert(loot_table, {
            name = "unilib:mineral_flint_lump",
            chance = 0.4,
            count = {1, 3},
        })

    end

    if unilib.global.pkg_executed_table["mineral_mese"] ~= nil then

        table.insert(loot_table, {
            name = "unilib:mineral_mese_crystal",
            chance = 0.1,
            count = {2, 3},
        })

        table.insert(loot_table, {
            name = "unilib:mineral_mese_block",
            chance = 0.15,
            y = {-32768, -512},
        })

    end

    if unilib.global.pkg_executed_table["plant_cactus_ordinary"] ~= nil then

        table.insert(loot_table, {
            name = "unilib:plant_cactus_ordinary",
            chance = 0.4,
            count = {1, 4},
            types = {"desert", "sandstone"},
        })

    end

    if unilib.global.pkg_executed_table["sand_desert"] ~= nil then

        table.insert(loot_table, {
            name = "unilib:sand_desert",
            chance = 0.8,
            count = {4, 32},
            types = {"sandstone"},
            y = {-64, 32768},
        })

    end

    if unilib.global.pkg_executed_table["sand_ordinary"] ~= nil then

        table.insert(loot_table, {
            name = "unilib:sand_ordinary",
            chance = 0.8,
            count = {4, 32},
            types = {"normal"},
            y = {-64, 32768},
        })

    end

    if unilib.global.pkg_executed_table["snow_ordinary"] ~= nil then

        table.insert(loot_table, {
            name = "unilib:snow_ordinary",
            chance = 0.8,
            count = {8, 64},
            types = {"ice"},
            y = {-64, 32768},
        })

    end

    if unilib.global.pkg_executed_table["stone_desert"] ~= nil then

        table.insert(loot_table, {
            name = "unilib:stone_desert_cobble",
            chance = 0.8,
            count = {4, 32},
            types = {"desert"},
        })

    end

    if unilib.global.pkg_executed_table["stone_obsidian"] ~= nil then

        table.insert(loot_table, {
            name = "unilib:stone_obsidian",
            chance = 0.25,
            count = {1, 3},
            y = {-32768, -512},
        })

    end

    if unilib.global.pkg_executed_table["tool_axe_diamond"] ~= nil then

        table.insert(loot_table, {
            name = "unilib:tool_axe_diamond",
            chance = 0.05,
        })

    end

    if unilib.global.pkg_executed_table["tool_pick_stone"] ~= nil then

        table.insert(loot_table, {
            name = "unilib:tool_pick_stone",
            chance = 0.3,
        })

    end

    if unilib.global.pkg_executed_table["tool_sword_wood"] ~= nil then

        table.insert(loot_table, {
            name = "unilib:tool_sword_wood",
            chance = 0.6,
        })

    end

    if #loot_table > 0 then
        dungeon_loot.register(loot_table)
    end

end
