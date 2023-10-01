---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    agriculture
-- Code:    WTFPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_scarecrow_straw = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.agriculture.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_scarecrow_straw.init()

    return {
        description = "Straw scarecrow",
        depends = {"item_stick_ordinary", "metal_steel", "misc_straw_ordinary", "wool_basic"},
    }

end

function unilib.pkg.misc_scarecrow_straw.exec()

    local c_stick = "unilib:item_stick_ordinary"

    unilib.register_node("unilib:misc_scarecrow_straw", "agriculture:scarecrow", mode, {
        -- From agriculture:scarecrow
        description = S("Straw Scarecrow"),
        tiles = {"unilib_misc_scarecrow_straw.png"},
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, stick = 1, tree = 1},
        sounds = unilib.sound_table.wood,

        collision_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
        },
        drawtype = "mesh",
        mesh = "unilib_misc_scarecrow_straw.obj",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        walkable = true,
    })
    unilib.register_craft({
        -- From agriculture:scarecrow
        output = "unilib:misc_scarecrow_straw",
        recipe = {
            {"", "unilib:wool_blue", "unilib:metal_steel_ingot"},
            {c_stick, "unilib:misc_straw_ordinary", c_stick},
            {"", "unilib:misc_straw_ordinary", "unilib:metal_steel_ingot"},
        },
    })

end
