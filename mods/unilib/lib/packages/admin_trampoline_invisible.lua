---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    maptools
-- Code:    zlib
-- Media:   zlib
---------------------------------------------------------------------------------------------------

unilib.pkg.admin_trampoline_invisible = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.maptools.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.admin_trampoline_invisible.init()

    return {
        description = "Invisible trampolines of various strengths",
        depends = "shared_maptools",
    }

end

function unilib.pkg.admin_trampoline_invisible.exec()

    for i = 1, 10 do

        -- Invisible trampolines of varying strengths
        unilib.pkg.shared_maptools.register_node(
            -- From maptools:pusher_1, etc
            "unilib:admin_trampoline_invisible_" .. string.format("%02d", i),
            "maptools:pusher_" .. i,
            mode,
            {
                description = unilib.utils.brackets(
                    S("Invisible Trampoline"), S("Strength %s"):format(i)
                ),
                tiles = {"unilib_admin_invisible.png"},
                -- N.B. not_in_creative_inventory not in original code
                groups = {
                    bouncy = i * 100, fall_damage_add_percent = -100,
                    not_in_creative_inventory = unilib.globalshow_admin_item_group,
                },
                -- (no sounds)

                drawtype = "nodebox",
                -- N.B. Original code used apple texture and no numeric overlays
                inventory_image = "unilib_metal_steel_block.png" ..
                        "^unilib_admin_trampoline_invisible.png" ..
                        "^unilib_numeric_overlay_" .. i .. ".png",
                -- N.B. is_ground_content = false not in original code
                is_ground_content = false,
                node_box = {
                    type = "fixed",
                    fixed = {-0.5, -0.5, -0.5, 0.5, -0.4999, 0.5},
                },
                paramtype = "light",
                paramtype2 = "facedir",
                sunlight_propagates = true,
                use_texture_alpha = "clip",
            }
        )

    end

end
