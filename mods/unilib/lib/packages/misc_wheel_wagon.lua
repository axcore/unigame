---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_wheel_wagon = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cottages.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_wheel_wagon.init()

    return {
        description = "Wagon wheel",
        notes = "Decorative item. Could be used to build a non-moving wagon (as in the" ..
                " screenshot for the original cottages mod)",
        depends = {"metal_iron", "metal_steel"},
    }

end

function unilib.pkg.misc_wheel_wagon.exec()

    local c_lump = "unilib:metal_iron_lump"
    local c_ingot = "unilib:metal_steel_ingot"

    unilib.register_node("unilib:misc_wheel_wagon", "cottages:wagon_wheel", mode, {
        -- From cottages:wagon_wheel
        description = S("Wagon Wheel"),
        tiles = {"unilib_misc_wheel_wagon.png"},
        groups = {attached_node = 1, choppy = 2, dig_immediate = 2},
        -- (no sounds)

        drawtype = "signlike",
        inventory_image = "unilib_misc_wheel_wagon.png",
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = {
            type = "wallmounted",
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_misc_wheel_wagon.png",
    })

    unilib.register_craft({
        -- From cottages:wagon_wheel
        output = "unilib:misc_wheel_wagon 3",
        recipe = {
            {c_lump, "group:stick", c_lump},
            {"group:stick", c_ingot, "group:stick"},
            {c_lump, "group:stick", c_lump}
        },
    })

end
