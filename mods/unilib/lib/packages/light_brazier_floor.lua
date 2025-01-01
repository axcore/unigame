---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_lighting
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_brazier_floor = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.castle_lighting.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_brazier_floor.init()

    return {
        description = "Floor brazier",
        notes = "Unlike pillar braziers, floor braziers are only crafted from one material",
        depends = {"metal_steel", "torch_ordinary"},
    }

end

function unilib.pkg.light_brazier_floor.exec()

    unilib.register_node("unilib:light_brazier_floor", "castle_lighting:brasier_floor", mode, {
        -- From castle_lighting:brasier_floor
        description = S("Floor Brazier"),
        tiles = {
            "unilib_door_steel_castle.png^(unilib_light_brazier_bed.png" ..
                    "^[mask:unilib_mask_light_brazier_bed.png)",
            "unilib_door_steel_castle.png",
            "unilib_door_steel_castle.png",
            "unilib_door_steel_castle.png",
            "unilib_door_steel_castle.png",
            "unilib_door_steel_castle.png",
        },
        groups = {cracky = 2},
        -- (no sounds)

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.25, 0, -0.25, 0.25, 0.125, 0.25},
                {-0.375, 0.125, -0.375, 0.375, 0.25, 0.375},
                {-0.5, 0.25, -0.5, 0.5, 0.375, 0.5},
                {-0.5, 0.375, 0.375, 0.5, 0.5, 0.5},
                {-0.5, 0.375, -0.5, 0.5, 0.5, -0.375},
                {0.375, 0.375, -0.375, 0.5, 0.5, 0.375},
                {-0.5, 0.375, -0.375, -0.375, 0.5, 0.375},
                {0.25, -0.5, -0.375, 0.375, 0.125, -0.25},
                {-0.375, -0.5, 0.25, -0.25, 0.125, 0.375},
                {0.25, -0.5, 0.25, 0.375, 0.125, 0.375},
                {-0.375, -0.5, -0.375, -0.25, 0.125, -0.25},
                {-0.125, -0.0625, -0.125, 0.125, 0, 0.125},
            },
        },
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.375, -0.5, -0.375, 0.375, 0.25, 0.375},
                {-0.5, 0.25, -0.5, 0.5, 0.5, 0.5},
            },
        },

        allow_metadata_inventory_put =
                unilib.pkg.shared_castle_lighting.brazier_allow_metadata_inventory_put,
        can_dig = unilib.pkg.shared_castle_lighting.brazier_can_dig,
        on_construct = unilib.pkg.shared_castle_lighting.brazier_on_construct,
        on_destruct = unilib.pkg.shared_castle_lighting.brazier_on_destruct,
        on_metadata_inventory_put = unilib.pkg.shared_castle_lighting.brazier_burn,
        on_timer = unilib.pkg.shared_castle_lighting.brazier_burn,
    })
    unilib.register_craft({
        -- From castle_lighting:brasier_floor
        output = "unilib:light_brazier_floor",
        recipe = {
            {"unilib:metal_steel_ingot", "unilib:torch_ordinary", "unilib:metal_steel_ingot"},
            {"unilib:metal_steel_ingot", "unilib:metal_steel_ingot", "unilib:metal_steel_ingot"},
        },
    })

end
