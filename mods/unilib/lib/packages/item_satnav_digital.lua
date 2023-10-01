---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    orienteering
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.item_satnav_digital = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.orienteering.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_satnav_digital.init()

    return {
        description = "Digital sat-nav device",
        notes = "Enables the minimap/radar. Use with the Minetest minimap key. See also the" ..
                " \"item_kit_radar\" package",
        depends = {"metal_gold", "mineral_mese", "stone_obsidian"},
    }

end

function unilib.pkg.item_satnav_digital.exec()

    local c_gold = "unilib:metal_gold_ingot"
    local c_mese = "unilib:mineral_mese_crystal"

    unilib.register_tool("unilib:item_satnav_digital", "orienteering:automapper", mode, {
        -- From orienteering:automapper
        description = S("Digital Sat-Nav Device"),
        inventory_image = "unilib_item_satnav_digital_inv.png",
        groups = {disable_repair = 1},

        wield_image = "unilib_item_satnav_digital_wield.png",
        wield_scale = {x = 1, y = 1, z = 2},
    })
    unilib.register_craft({
        -- From orienteering:automapper
        output = "unilib:item_satnav_digital",
        recipe = {
            {c_gold, c_gold, c_gold},
            {c_mese, "unilib:stone_obsidian_shard", c_mese},
            {c_gold, c_gold, c_gold},
        }
    })

end
