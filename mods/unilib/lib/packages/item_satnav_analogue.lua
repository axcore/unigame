---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    orienteering
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.item_satnav_analogue = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.orienteering.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_satnav_analogue.init()

    return {
        description = "Analogue sat-nav device",
        notes = "Enables the minimap. Use with the Minetest minimap key. See also the" ..
                " \"item_kit_mapping\" package",
        depends = {"dye_basic", "item_paper_ordinary"},
    }

end

function unilib.pkg.item_satnav_analogue.exec()

    local c_paper = "unilib:item_paper_ordinary"

    unilib.register_tool("unilib:item_satnav_analogue", "orienteering:map", mode, {
        -- From orienteering:map
        description = unilib.utils.hint(S("Analogue Sat-Nav Device"), S("enables minimap")),
        inventory_image = "unilib_item_satnav_analogue.png",
        groups = {disable_repair = 1},

        wield_image = "unilib_item_satnav_analogue.png",
        wield_scale = {x = 1.5, y = 1.5, z = 0.15},
    })
    unilib.register_craft({
        -- From orienteering:map
        output = "unilib:item_satnav_analogue",
        recipe = {
            {c_paper, c_paper, c_paper},
            {c_paper, "unilib:dye_black", c_paper},
            {c_paper, c_paper, c_paper},
        },
    })

end
