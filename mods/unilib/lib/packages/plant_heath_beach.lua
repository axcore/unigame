---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_heath_beach = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_heath_beach.init()

    return {
        description = "Beach heath",
    }

end

function unilib.pkg.plant_heath_beach.exec()

    local full_name = "unilib:plant_heath_beach"
    local orig_name = "elysflowers:beach_heath"
    local img = "unilib_plant_heath_beach.png"

    unilib.register_node(full_name, orig_name, mode, {
        -- From elysflowers:beach_heath
        description = unilib.utils.annotate(S("Beach Heath"), "Hudsonia tomentosa"),
        tiles = {img},
        -- N.B. Used groups based on the "plant_shrub_dry" package, rather than the extended set in
        --      original code
        groups = {attached_node = 1, flammable = 3, flora = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        floodable = true,
        inventory_image = img,
        paramtype = "light",
        selection_box = {-0.35, -0.4, -0.35, 0.35, 0.40, 0.35},
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = img,
    })
    -- N.B. Not compatible with flowerpots, even in original code

    unilib.register_decoration_generic("elysflowers_plant_heath_beach", {
        -- From elysflowers/init.lua
        deco_type = "simple",
        decoration = full_name,

        noise_params = {
            flags = {"absvalue", "eased"},
            octaves = 2,
            offset = 0.0004794,
            persist = 0.2,
            scale = 0.029197,
            seed = math.random(),
            spread = {x = 16, y = 32, z = 16},
        },
        rotation = "random",
        sidelen = 16,
    })

end
