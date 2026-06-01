---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_cholla_tree = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_cholla_tree.init()

    return {
        description = "Tree cholla",
    }

end

function unilib.pkg.plant_cholla_tree.exec()

    local full_name = "unilib:plant_cholla_tree"
    local orig_name = "elysflowers:tree_cholla"
    local img = "unilib_plant_cholla_tree.png"

    unilib.register_node(full_name, orig_name, mode, {
        -- From elysflowers:tree_cholla
        description = unilib.utils.annotate(S("Tree Cholla"), "Cylindropuntia imbricata"),
        tiles = {img},
        -- N.B. Used groups based on the "plant_shrub_dry" package, rather than the extended set in
        --      original code
        groups = {attached_node = 1, flammable = 3, flora = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        floodable = true,
        inventory_image = img,
        paramtype = "light",
        selection_box = {-0.25, -0.4, -0.25, 0.25, 0.90, 0.25},
        sunlight_propagates = true,
        visual_scale = 1.5,
        walkable = false,
        waving = 1,
        wield_image = img,
    })
    unilib.register_plant_in_pot(full_name, orig_name, "unilib_plant_cholla_tree_potted.png")

    unilib.register_decoration_generic("elysflowers_plant_cholla_tree", {
        -- From elysflowers/init.lua
        deco_type = "simple",
        decoration = full_name,

        noise_params = {
            lacunarity = 0.756,
            octaves = 6,
            offset = 0.00064200,
            persist = 0.871,
            scale = 0.000214606,
            seed = math.random(),
            spread = {x = 16, y = 4, z = 16},
        },
        rotation = "random",
        sidelen = 16,
    })

end
