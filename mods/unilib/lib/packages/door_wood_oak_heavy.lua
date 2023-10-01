---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_gates
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.door_wood_oak_heavy = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.castle_gates.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_wood_oak_heavy.init()

    return {
        description = "Heavy oak door",
        at_least_one = {"tree_apple", "tree_oak", "tree_oak_mature"},
    }

end

function unilib.pkg.door_wood_oak_heavy.exec()

    -- N.B. In original code, the craft recipe used "default:tree" as an ingredient. However, the
    --      door itself looks nothing like this wood
    -- Use an oak tree trunk in the recipe, if it's available; otherwise continue using the apple
    --      tree
    local ingredient = "unilib:tree_apple_trunk"
    if unilib.pkg_executed_table["tree_oak"] ~= nil then
        ingredient = "unilib:tree_oak_trunk"
    elseif unilib.pkg_executed_table["tree_oak_mature"] ~= nil then
        ingredient = "unilib:tree_oak_mature_trunk"
    end

    unilib.register_door({
        -- From castle_gates:oak_door. Creates unilib:door_wood_oak_heavy
        part_name = "wood_oak_heavy",
        orig_name = {
            "castle_gates:oak_door_a",
            "castle_gates:oak_door_b",
            "castle_gates:oak_door_c",
            "castle_gates:oak_door_d",
        },
        def_table = {
            description = S("Heavy Oak Door"),
            tiles = {{name = "unilib_door_wood_oak_heavy.png", backface_culling = true}},
            groups = {choppy = 2, door = 1},
            sounds = unilib.sound_table.wood,

            inventory_image = "unilib_door_wood_oak_heavy_inv.png",
            protected_flag = true,
            recipe = {
                {ingredient, ingredient},
                {ingredient, ingredient},
                {ingredient, ingredient},
            },
        },

        replace_mode = mode,
        orig_craftitem_name = "castle_gates:oak_door",
    })

end
