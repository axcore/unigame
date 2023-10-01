---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    maptools
-- Code:    zlib
-- Media:   zlib
---------------------------------------------------------------------------------------------------

unilib.pkg.admin_light_invisible = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.maptools.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.admin_light_invisible.init()

    return {
        description = "Invisible light source",
        depends = "shared_maptools",
    }

end

function unilib.pkg.admin_light_invisible.exec()

    -- Invisible light sources in varying strengths
    for i = 1, 14 do

        local orig_name = nil
        -- N.B. Original code provides only one item, maptools:lightbulb, with light 14
        if i == 14 then
            orig_name = "maptools:lightbulb"
        end

        unilib.pkg.shared_maptools.register_node(
            -- From maptools:lightbulb
            "unilib:admin_light_invisible_" .. string.format("%02d", i),
            orig_name,
            mode,
            {
                description = unilib.brackets(
                    S("Invisible Light Bulb"), S("Strength %s"):format(i)
                ),
                -- (no tiles)
                -- N.B. not_in_creative_inventory not in original code
                groups = {not_in_creative_inventory = unilib.show_admin_item_group},
                -- (no sounds)

                drawtype = "airlike",
                -- N.B. Original code used no numeric overlays
                inventory_image = "unilib_metal_steel_block.png" ..
                        "^unilib_mineral_mese_crystal_fragment.png" ..
                        "^unilib_numeric_overlay_" .. i .. ".png",
                light_source = 14,
                paramtype = "light",
                pointable = false,
                sunlight_propagates = true,
                walkable = false,
            }
        )

    end

end
