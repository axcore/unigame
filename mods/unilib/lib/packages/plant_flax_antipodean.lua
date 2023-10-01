---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_flax_antipodean = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_flax_antipodean.init()

    return {
        description = "Antipodean flax plant",
        optional = "item_paper_ordinary",
    }

end

function unilib.pkg.plant_flax_antipodean.exec()

    local c_flax = "unilib:plant_flax_antipodean"

    unilib.register_node(c_flax, "aotearoa:flax", mode, {
        -- From aotearoa:flax
        description = unilib.annotate(S("Antipodean Flax Plant"), "Phormium tenax"),
        tiles = {"unilib_plant_flax_antipodean.png"},
        groups = {attached_node = 1, flammable = 1, flora = 1, flower = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_flax_antipodean.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.4, -0.5, -0.4, 0.4, -0.2, 0.4},
        },
        sunlight_propagates = true,
        visual_scale = 1.5,
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_flax_antipodean.png",
    })
    unilib.register_craft({
        -- From aotearoa:flax
        type = "fuel",
        recipe = c_flax,
        burntime = 1,
    })
    if unilib.pkg_executed_table["item_paper_ordinary"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:flax
            output = "unilib:item_paper_ordinary",
            recipe = {
                {c_flax, c_flax, c_flax},
            }
        })

    end
    unilib.register_plant_in_pot(c_flax, "aotearoa:flax")

    unilib.register_decoration("aotearoa_plant_flax_antipodean_normal", {
        -- From aotearoa/spawn_plants.lua
        deco_type = "simple",
        decoration = c_flax,

        fill_ratio = 0.01,
        sidelen = 16,
    })
    unilib.register_decoration("aotearoa_plant_flax_antipodean_dense", {
        -- From aotearoa/spawn_plants.lua
        deco_type = "simple",
        decoration = c_flax,

        fill_ratio = 0.1,
        sidelen = 16,
    })

end
