---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ropes
-- Code:    MIT
-- Media:   unknown (textures), CC0 (sounds)
---------------------------------------------------------------------------------------------------

unilib.pkg.ladder_steel_extendable = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ropes.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ladder_steel_extendable.init()

    return {
        description = "Extendable steel ladder",
        notes = "Place an extendable ladder at the desired lowest position, then right-click to" ..
                " extend it, up to a maximum height",
        depends = {"metal_steel", "shared_ropes"},
    }

end

function unilib.pkg.ladder_steel_extendable.exec()

    unilib.register_node("unilib:ladder_steel_extendable", "ropes:ladder_steel", mode, {
        -- From ropes:ladder_steel
        description = S("Extendable Steel Ladder"),
        tiles = {
            "unilib_metal_steel_block.png",
            "unilib_metal_steel_block.png",
            "unilib_metal_steel_block.png",
            "unilib_metal_steel_block.png",
            "unilib_ladder_steel.png",
        },
        groups = {cracky = 2, flow_through = 1},
        sounds = unilib.global.sound_table.metal,

        climbable = true,
        drawtype = "nodebox",
        inventory_image = "unilib_ladder_steel.png",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.4375, -0.5, 0.3125, -0.25, 0.5, 0.5},
                {0.25, -0.5, 0.3125, 0.4375, 0.5, 0.5},
                {-0.25, 0.3125, 0.375, 0.25, 0.4375, 0.5},
                {-0.25, -0.1875, 0.375, 0.25, -0.0625, 0.5},
                {-0.25, -0.4375, 0.375, 0.25, -0.3125, 0.5},
                {-0.25, 0.0625, 0.375, 0.25, 0.1875, 0.5},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        walkable = false,
        wield_image = "unilib_ladder_steel.png",

        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)

            return unilib.pkg.shared_ropes.ladder_extender(
                pos,
                node,
                clicker,
                itemstack,
                pointed_thing,
                "unilib:ladder_steel_extendable",
                -- Maximum height of the (whole) extended section of the ladder
                15
            )

        end,
    })
    unilib.register_craft({
        -- From ropes:ladder_steel
        output = "unilib:ladder_steel_extendable 15",
        recipe = {
            {"unilib:metal_steel_ingot", "", "unilib:metal_steel_ingot"},
            {"unilib:metal_steel_ingot", "", "unilib:metal_steel_ingot"},
            {"unilib:metal_steel_ingot", "unilib:metal_steel_ingot", "unilib:metal_steel_ingot"},
        },
    })

end
