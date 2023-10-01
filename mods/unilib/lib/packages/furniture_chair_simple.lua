---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.furniture_chair_simple = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.furniture_chair_simple.init()

    return {
        description = "Simple chair",
        depends = "shared_xdecor",
        optional = "shared_screwdriver",
    }

end

function unilib.pkg.furniture_chair_simple.exec()

    unilib.register_node("unilib:furniture_chair_simple", "xdecor:chair", mode, {
        -- From xdecor:chair
        description = S("Simple Chair"),
        tiles = {"unilib_misc_wood_simple.png"},
        groups = {choppy = 3, flammable = 2, oddly_breakable_by_hand = 2},
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.3125, -0.5, 0.1875, -0.1875, 0.5, 0.3125},
                {0.1875, -0.5, 0.1875, 0.3125, 0.5, 0.3125},
                {-0.1875, 0.0625, 0.21875, 0.1875, 0.4375, 0.28125},
                {-0.3125, -0.5, -0.3125, -0.1875, -0.125, -0.1875},
                {0.1875, -0.5, -0.3125, 0.3125, -0.125, -0.1875},
                {-0.3125, -0.125, -0.3125, 0.3125, 0, 0.1875},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",

        can_dig = unilib.pkg.shared_xdecor.can_dig_chair,

        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)

            -- Sitting position
            pos.y = pos.y + 0
            unilib.pkg.shared_xdecor.do_sit(pos, node, clicker, pointed_thing)
            return itemstack

        end,
    })
    unilib.register_craft({
        -- From xdecor:chair
        output = "unilib:furniture_chair_simple",
        recipe = {
            {"group:stick", "", ""},
            {"group:stick", "group:stick", "group:stick"},
            {"group:stick", "", "group:stick"}
        }
    })
    if unilib.pkg_executed_table["shared_screwdriver"] ~= nil then

        unilib.override_item("unilib:furniture_chair_simple", {
            on_rotate = unilib.pkg.shared_screwdriver.rotate_simple,
        })

    end

end
