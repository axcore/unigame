---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_spikes = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_spikes.init()

    return {
        description = "Spikes",
        depends = "metal_steel",
    }

end

function unilib.pkg.misc_spikes.exec()

    unilib.register_node("unilib:misc_spikes", "decoblocks:spikes", mode, {
        -- From farlands, decoblocks:spikes
        description = S("Spikes"),
        tiles = {"unilib_misc_spikes.png"},
        groups = {cracky = 3},
        -- (no sounds)

        collision_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.2, 0.5}
        },
        damage_per_second = 3,
        drawtype = "firelike",
        inventory_image = "unilib_misc_spikes.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.3, 0.5}
        },
        walkable = false,
        wield_image = "unilib_misc_spikes.png",
    })
    unilib.register_craft({
        -- From farlands, decoblocks:spikes
        output = "unilib:misc_spikes 3",
        recipe = {
            {"", "unilib:metal_steel_ingot", ""},
            {"unilib:metal_steel_ingot", "", "unilib:metal_steel_ingot"},
        }
    })

end
