---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_beautiflowers_mixed = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_beautiflowers_mixed.init()

    return {
        description = "Generic decoration package placing flowers from the beautiflowers mod on" ..
                " grass from default",
        depends = "dirt_ordinary",
    }

end

function unilib.pkg.deco_beautiflowers_mixed.post()

    for _, part_name in ipairs({
        "ada", "agnes", "alicia", "alma", "amaya", "anastasia", "anni", "arcoiris", "arleth",
        "astrid", "beatrice", "belen", "berta", "bianca", "carla", "cassandra", "chloe",
        "christina", "clara", "claudia", "dana", "daphne", "delia", "diana", "elena", "erica",
        "estella", "eva", "fabiola", "fiona", "gala", "genesis", "gisela", "gloria", "hadassa",
        "ingrid", "irene", "iris", "jennifer", "lara", "laura", "lucy", "lydia", "mara", "martina",
        "melania", "michelle", "minerva", "mireia", "miriam", "nadya", "nazareth", "nerea",
        "noelia", "noemi", "olga", "olympia", "oriana", "paula", "pia", "raquel", "regina", "rocio",
        "ruth", "sabrina", "sandra", "sara", "sonya", "sophia", "suri", "sylvia", "talia", "thais",
        "valentina", "valeria", "vanessa", "vera", "victoria", "virginia", "xena", "xenia",
        "yvette", "zaida",
    }) do

        if unilib.global.pkg_executed_table["flower_" .. part_name] ~= nil then

            unilib.register_decoration_complete("beautiflowers_flower_" .. part_name, nil, {
                -- From beautiflowers/spawn.lua
                -- Completes decoration in shared function unilib.register_beautiflower()
                place_on = "unilib:dirt_ordinary_with_turf",
                y_max = 30000,
                y_min = 1,
            })

        end

    end

end
