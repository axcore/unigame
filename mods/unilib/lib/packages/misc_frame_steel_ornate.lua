---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nbea
-- Code:    WTFPL
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_frame_steel_ornate = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.nbea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_frame_steel_ornate.init()

    return {
        description = "Ornate steel-framed glass",
        depends = {"glass_ordinary", "metal_steel"},
    }

end

function unilib.pkg.misc_frame_steel_ornate.exec()

    local c_steel = "unilib:metal_steel_ingot"

    unilib.register_node("unilib:misc_frame_steel_ornate", "nbea:nbox_002", mode, {
        -- From nbea:nbox_002
        description = S("Ornate Steel-Framed Glass"),
        -- N.B. Added glass texture, so that the node matches its inventory image
--      tiles = {"unilib_misc_frame_steel_ornate_overlay.png"},
        tiles = {"unilib_glass_ordinary.png^unilib_misc_frame_steel_ornate_overlay.png"},
        groups = {cracky = 3},
        sounds = unilib.sound.generate_metal({
            footstep = {name = "unilib_glass_footstep", gain = 0.5},
            dug = {name = "unilib_break_glass", gain = 1.0},
        }),

        climbable = true,
        drawtype = "nodebox",
        -- N.B. inventory_image removed from original code
--      inventory_image = "unilib_glass_ordinary.png^unilib_misc_frame_steel_ornate_overlay.png",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {0.375, -0.5, -0.5, 0.4375, 0.5, 0.5},
                {-0.4375, -0.5, -0.5, -0.375, 0.5, 0.5},
                {0.25, -0.5, -0.5, 0.3125, 0.5, 0.5},
                {-0.3125, -0.5, -0.5, -0.25, 0.5, 0.5},
                {-0.5, -0.4375, -0.5, 0.5, -0.375, 0.5},
                {-0.5, -0.3125, -0.5, 0.5, -0.25, 0.5},
                {-0.5, 0.375, -0.5, 0.5, 0.4375, 0.5},
                {-0.5, 0.25, -0.5, 0.5, 0.3125, 0.5},
                {-0.5, -0.5, 0.375, 0.5, 0.5, 0.4375},
                {-0.5, -0.5, 0.25, 0.5, 0.5, 0.3125},
                {-0.5, -0.5, -0.4375, 0.5, 0.5, -0.375},
                {-0.5, -0.5, -0.3125, 0.5, 0.5, -0.25},
                -- Corner frame
                {-0.4375, 0.4375, 0.4375, 0.4375, 0.5, 0.5},
                {-0.4375, -0.5, 0.4375, 0.4375, -0.4375, 0.5},
                {-0.5, -0.5, 0.4375, -0.4375, 0.5, 0.5},
                {0.4375, -0.5, 0.4375, 0.5, 0.5, 0.5},
                {-0.5, 0.4375, -0.4375, -0.4375, 0.5, 0.4375},
                {-0.5, -0.5, -0.4375, -0.4375, -0.4375, 0.4375},
                {0.4375, 0.4375, -0.4375, 0.5, 0.5, 0.4375},
                {0.4375, -0.5, -0.4375, 0.5, -0.4375, 0.4375},
                {-0.5, 0.4375, -0.5, 0.5, 0.5, -0.4375},
                {-0.5, -0.5, -0.5, 0.5, -0.4375, -0.4375},
                {0.4375, -0.4375, -0.5, 0.5, 0.4375, -0.4375},
                {-0.5, -0.4375, -0.5, -0.4375, 0.4375, -0.4375},
                -- Centre mass
                {-0.4375, -0.4375, -0.4375, 0.4375, 0.4375, 0.4375},
            },
        },
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            },
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        wield_image = "unilib_glass_ordinary.png^unilib_misc_frame_steel_ornate_overlay.png",
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:misc_frame_steel_ornate 2",
        recipe = {
            {c_steel, c_steel, c_steel},
            {c_steel, "unilib:glass_ordinary", c_steel},
            {c_steel, c_steel, c_steel},
        },
    })

end
