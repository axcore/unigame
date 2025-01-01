---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_ethereal_fish = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_ethereal_fish.register_fish(data_table)

    -- Registers a fish that can be caught with a fishing rod
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "cod"
    --      description (str): e.g. "Raw Cod"; descriptions for inedible or poisonous fish should
    --          not contain the word "Raw" (as a hint to the player)
    --      tastiness (int): e.g. 2 for an edible fish, -2 for a poisonous fish, or 0 for an
    --          inedible fish
    --
    -- data_table optional fields:
    --      orig_name (str): e.g. "ethereal:fish_cod"
    --      biome_part_name (str): A string matching a specific biome (e.g. "ethereal_sakura") or a
    --          general biome (e.g. "ocean", which matches any biome containing that word, e.g.
    --          "my_ocean_biome")
    --      sci_name (str): e.g.

    local part_name = data_table.part_name
    local description = data_table.description
    local tastiness = data_table.tastiness

    local orig_name = data_table.orig_name or nil
    local biome_part_name = data_table.biome_part_name or nil
    local sci_name = data_table.sci_name or nil

    -- The "food_fish_cookable" group replaces ethereal-ng's "ethereal_fish" group, and is used to
    --      craft items like cooked fish and fish and chips (thus, poisonous items like pufferfish
    --      become edible when "cooked")
    -- The "food_fish_raw" group is used to craft items like sushi, so it excludes pufferfish
    -- (This is a change from ethereal-ng's code, in which pufferfish could not be used as crafting
    --      ingredients for cooked fish or fish and chips)
    local group_table
    if tastiness < 0 then
        group_table = {flammable = 2, food_fish_cookable = 1}
    elseif tastiness == 0 then
        group_table = {flammable = 2}
    else
        group_table = {flammable = 2, food_fish_cookable = 1, food_fish_raw = 1}
    end

    local on_use
    if tastiness ~= 0 then

        on_use = unilib.cuisine.eat_on_use(
            "unilib:ingredient_fish_" .. part_name, tastiness
        )

    end

    if sci_name ~= nil then
        description = unilib.utils.annotate(description, sci_name)
    end

    -- (Make Neon Tetra glow slightly)
    local light_source
    if part_name == "tetra" then
        light_source = 3
    end

    -- Register the fish
    unilib.register_craftitem("unilib:ingredient_fish_" .. part_name, orig_name, mode, {
        -- From ethereal:fish_angler, etc. Creates unilib:ingredient_fish_angler, etc
        description = description,
        inventory_image = "unilib_ingredient_fish_" .. part_name .. ".png",
        groups = group_table,

        light_source = light_source,

        on_use = on_use,
    })

    -- These fish can be caught with any rod, but some require a specific biome
    unilib.fishing.register_fish({
        full_name = "unilib:ingredient_fish_" .. part_name,
        biome_part_name = biome_part_name,
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_ethereal_fish.init()

    return {
        description = "Shared functions for fishing (from ethereal-ng)",
    }

end
