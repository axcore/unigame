---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    minimap_radar
-- Code:    MIT
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_kit_radar = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.minimap_radar.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_kit_radar.init()

    return {
        description = "Radar kit",
        notes = "Enables the minimap/radar. Use with the Minetest minimap key",
        mod_optional = "technic",
        depends = {"dye_basic", "mineral_diamond", "shared_map"},
        optional = {"metal_mithril", "metal_silver", "metal_steel", "mineral_mese"},
    }

end

function unilib.pkg.item_kit_radar.exec()

    local c_diamond = "unilib:mineral_diamond_gem"

    unilib.register_craftitem("unilib:item_kit_radar", "minimap_radar:radar", mode, {
        -- From minimap_radar:radar
        description = unilib.utils.hint(S("Radar Kit"), S("Use with 'Minimap' key")),
        inventory_image = "unilib_item_kit_radar.png",
        -- N.B. No groups in original code, added .tool to match unilib:item_kit_mapping
        groups = {tool = 1},

        stack_max = 1,

        on_use = function(itemstack, user, pointed_thing)
            unilib.pkg.shared_map.update_hud_flags(user)
        end,
    })
    if core.get_modpath("technic") then

        local c_ingot = "technic:stainless_steel_ingot"

        unilib.register_craft({
            -- From minimap_radar:radar
            output = "unilib:item_kit_radar",
            recipe = {
                {c_ingot, c_diamond, c_ingot},
                {"unilib:dye_green", "technic:prospector", "unilib:dye_black"},
                {c_ingot, c_diamond, c_ingot},
            },
        })

    elseif unilib.global.pkg_executed_table["metal_mithril"] ~= nil and
            unilib.global.pkg_executed_table["metal_silver"] ~= nil then

        local c_ingot = "unilib:metal_silver_ingot"

        unilib.register_craft({
            -- From minimap_radar:radar
            output = "unilib:item_kit_radar",
            recipe = {
                {c_ingot, c_diamond, c_ingot},
                {"unilib:dye_green", "unilib:metal_mithril_block", "unilib:dye_black"},
                {c_ingot, c_diamond, c_ingot},
            },
        })

    elseif unilib.global.pkg_executed_table["metal_steel"] ~= nil and
            unilib.global.pkg_executed_table["mineral_mese"] ~= nil then

        local c_ingot = "unilib:metal_steel_ingot"

        unilib.register_craft({
            -- From minimap_radar:radar
            output = "unilib:item_kit_radar",
            recipe = {
                {c_ingot, c_diamond, c_ingot},
                {"unilib:dye_green", "unilib:mineral_mese_block", "unilib:dye_black"},
                {c_ingot, c_diamond, c_ingot},
            },
        })

    end

end
