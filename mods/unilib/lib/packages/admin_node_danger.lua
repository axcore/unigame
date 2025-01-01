---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    maptools
-- Code:    zlib
-- Media:   zlib
---------------------------------------------------------------------------------------------------

unilib.pkg.admin_node_danger = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.maptools.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.admin_node_danger.init()

    return {
        description = "Invisible dangerous blocks",
        depends = "shared_maptools",
    }

end

function unilib.pkg.admin_node_danger.exec()

    for i = 1, 5 do

        -- Invisible, non-pointable block that decreases player's HP by 1-5 per second
        unilib.pkg.shared_maptools.register_node(
            -- From maptools:damage_1, etc
            "unilib:admin_node_danger_damage_" .. i,
            "maptools:damage_" .. i,
            mode,
            {
                description = unilib.utils.brackets(
                    S("Invisible Damaging Block"), S("Strength %s"):format(i)
                ),
                -- (no tiles)
                -- N.B. not_in_creative_inventory not in original code
                groups = {not_in_creative_inventory = unilib.globalshow_admin_item_group},
                -- (no sounds)

                damage_per_second = i,
                drawtype = "airlike",
                inventory_image = "unilib_metal_steel_block.png" ..
                        "^unilib_crop_cotton_grow_" .. i .. ".png",
                -- N.B. is_ground_content = false not in original code
                is_ground_content = false,
                paramtype = "light",
                pointable = false,
                sunlight_propagates = true,
                walkable = false,
            }
        )

    end

    -- Invisible, non-pointable block that kills the player
    unilib.pkg.shared_maptools.register_node(
        -- From maptools:kill
        "unilib:admin_node_danger_kill",
        "maptools:kill",
        mode,
        {
            description = S("Invisible Killing Block"),
            -- (no tiles)
            -- N.B. not_in_creative_inventory not in original code
            groups = {not_in_creative_inventory = unilib.globalshow_admin_item_group},
            -- (no sounds)

            damage_per_second = 20,
            drawtype = "airlike",
            inventory_image = "unilib_metal_steel_block.png^unilib_dye_black.png",
            -- N.B. is_ground_content = false not in original code
            is_ground_content = false,
            paramtype = "light",
            pointable = false,
            sunlight_propagates = true,
            walkable = false,
        }
    )

    -- Invisible, non-pointable block that drowns the player
    unilib.pkg.shared_maptools.register_node(
        -- From maptools:drowning
        "unilib:admin_node_danger_drown",
        "maptools:drowning",
        mode,
        {
            description = unilib.utils.hint(
                S("Invisible Drowning Block"), S("place at head height")
            ),
            -- (no tiles)
            -- N.B. not_in_creative_inventory not in original code
            groups = {not_in_creative_inventory = unilib.globalshow_admin_item_group},
            -- (no sounds)

            drawtype = "airlike",
            drowning = 1,
            -- N.B. switched duplicate dye texture in original code
            inventory_image = "unilib_metal_steel_block.png^unilib_dye_grey_dark.png",
            -- N.B. is_ground_content = false not in original code
            is_ground_content = false,
            paramtype = "light",
            pointable = false,
            sunlight_propagates = true,
            walkable = false,
        }
    )

end
