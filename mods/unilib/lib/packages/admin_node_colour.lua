---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    maptools
-- Code:    zlib
-- Media:   zlib
---------------------------------------------------------------------------------------------------

unilib.pkg.admin_node_colour = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.maptools.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.admin_node_colour.init()

    return {
        description = "Coloured admin nodes",
        depends = "shared_maptools",
    }

end

function unilib.pkg.admin_node_colour.exec()

    -- Pure black node
    unilib.pkg.shared_maptools.register_node(
        -- From maptools:black
        "unilib:admin_node_colour_black",
        "maptools:black",
        mode,
        {
            description = S("Pure Black Node"),
            tiles = {"unilib_admin_node_colour_black.png"},
            -- N.B. not_in_creative_inventory not in original code
            groups = {not_in_creative_inventory = unilib.globalshow_admin_item_group},
            sounds = unilib.global.sound_table.stone,

            -- N.B. is_ground_content = false not in original code
            is_ground_content = false,
            post_effect_color = {r = 0, g = 0, b = 0, a = 255},
        }
    )

    -- Pure white node
    unilib.pkg.shared_maptools.register_node(
        -- From maptools:white
        "unilib:admin_node_colour_white",
        "maptools:white",
        mode,
        {
            description = S("Pure White Node"),
            tiles = {"unilib_admin_node_colour_white.png"},
            -- N.B. not_in_creative_inventory not in original code
            groups = {not_in_creative_inventory = unilib.globalshow_admin_item_group},
            sounds = unilib.global.sound_table.stone,

            -- N.B. is_ground_content = false not in original code
            is_ground_content = false,
            post_effect_color = {r = 128, g = 128, b = 128, a = 255},
        }
    )

end
