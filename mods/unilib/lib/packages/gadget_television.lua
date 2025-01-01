---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.gadget_television = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gadget_television.init()

    return {
        description = "Television",
        depends = {"glass_ordinary", "metal_copper", "metal_steel"},
        optional = "shared_screwdriver",
    }

end

function unilib.pkg.gadget_television.exec()

    local c_copper = "unilib:metal_copper_ingot"
    local c_steel = "unilib:metal_steel_ingot"

    unilib.register_node("unilib:gadget_television", "xdecor:tv", mode, {
        -- From xdecor:tv
        description = S("Television"),
        groups = {cracky = 3, oddly_breakable_by_hand = 2},
        tiles = {
            "unilib_gadget_television_left.png^[transformR270",
            "unilib_gadget_television_left.png^[transformR90",
            "unilib_gadget_television_left.png^[transformFX",
            "unilib_gadget_television_left.png",
            "unilib_gadget_television_back.png",
            {
                name = "unilib_gadget_television_animated.png",
                animation = {type = "vertical_frames", length = 80.0}
            },
        },
        sounds = unilib.global.sound_table.node,

        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        light_source = 11,
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From xdecor:tv
        output = "unilib:gadget_television",
        recipe = {
            {c_steel, c_copper, c_steel},
            {c_steel, "unilib:glass_ordinary", c_steel},
            {c_steel, c_copper, c_steel},
        },
    })
    if unilib.global.pkg_executed_table["shared_screwdriver"] ~= nil then

        unilib.override_item("unilib:gadget_television", {
            on_rotate = unilib.pkg.shared_screwdriver.rotate_simple,
        })

    end

end
