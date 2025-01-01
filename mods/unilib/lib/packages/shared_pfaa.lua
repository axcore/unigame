---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_pfaa = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

local band_list = {
    {
        clust_num_ores          = 5,
        clust_scarcity          = 7 * 7 * 7,
        clust_size              = 3,
        y_max                   = 64,
        y_min                   = -64,
    },
    {
        clust_num_ores          = 5,
        clust_scarcity          = 8 * 8 * 8,
        clust_size              = 3,
        y_max                   = 0,
        y_min                   = -128,
    },
    {
        clust_num_ores          = 5,
        clust_scarcity          = 9 * 9 * 9,
        clust_size              = 3,
        y_max                   = -64,
        y_min                   = -192,
    },
    {
        clust_num_ores          = 5,
        clust_scarcity          = 10 * 10 * 10,
        clust_size              = 3,
        y_max                   = -128,
        y_min                   = -256,
    },
    {
        clust_num_ores          = 5,
        clust_scarcity          = 11 * 11 * 11,
        clust_size              = 3,
        y_max                   = -192,
        y_min                   = -320,
    },
    {
        clust_num_ores          = 5,
        clust_scarcity          = 12 * 12 * 12,
        clust_size              = 5,
        y_max                   = -256,
        y_min                   = -512,
    },
    {
        clust_num_ores          = 5,
        clust_scarcity          = 13 * 13 * 13,
        clust_size              = 5,
        y_max                   = -512,
        y_min                   = -1024,
    },
    {
        clust_num_ores          = 5,
        clust_scarcity          = 14 * 14 * 14,
        clust_size              = 5,
        y_max                   = -1024,
        y_min                   = -2048,
    },
    {
        clust_num_ores          = 5,
        clust_scarcity          = 15 * 15 * 15,
        clust_size              = 5,
        y_max                   = -2048,
        y_min                   = unilib.constant.y_min,
    },
}

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_pfaa.register_clay_ore(part_name, i)

    if tonumber(i) == nil or i < 1 or i > 9 then
        i = 1
    end

    local mini_table = band_list[i]

    unilib.register_ore({
        -- Original to unilib
        ore_type                = "scatter",
        ore                     = "unilib:clay_ordinary_with_" .. part_name,
        wherein                 = "unilib:clay_ordinary",

        clust_num_ores          = mini_table.clust_num_ores,
        clust_scarcity          = mini_table.clust_scarcity,
        clust_size              = mini_table.clust_size,
        y_max                   = mini_table.y_max,
        y_min                   = mini_table.y_min,
    })

end

function unilib.pkg.shared_pfaa.register_dirt_ore(part_name, i)

    if tonumber(i) == nil or i < 1 or i > 9 then
        i = 1
    end

    local mini_table = band_list[i]

    unilib.register_ore({
        -- Original to unilib
        ore_type                = "scatter",
        ore                     = "unilib:dirt_ordinary_with_" .. part_name,
        wherein                 = "unilib:dirt_ordinary",

        clust_num_ores          = mini_table.clust_num_ores,
        clust_scarcity          = mini_table.clust_scarcity,
        clust_size              = mini_table.clust_size,
        y_max                   = mini_table.y_max,
        y_min                   = mini_table.y_min,
    })

end

function unilib.pkg.shared_pfaa.register_stone_ore(part_name, i)

    if tonumber(i) == nil or i < 1 or i > 9 then
        i = 1
    end

    local mini_table = band_list[i]

    unilib.register_ore({
        -- Original to unilib
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_" .. part_name,
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = mini_table.clust_num_ores,
        clust_scarcity          = mini_table.clust_scarcity,
        clust_size              = mini_table.clust_size,
        y_max                   = mini_table.y_max,
        y_min                   = mini_table.y_min,
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_pfaa.init()

    return {
        description = "Shared functions for ordinary stone ores (from PFAA)",
        notes = "To add some variety to worlds containing mostly ordinary stone, this package" ..
                " defines eight \"bands\" at which PFAA ores can be found." ..
                " The calling package only needs to specify a value between 1-9. For the" ..
                " purposes of making these packages playable in a default-like world, they have" ..
                " been assigned a band semi-randomly. Users can easily change the bands to their" ..
                " own liking",
    }

end
