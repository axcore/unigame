---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_cotton_wild = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_cotton_wild.init()

    return {
        description = "Wild cotton plant",
        notes = "Wild cotton is an additional source of cotton seed",
        depends = "crop_cotton",
    }

end

function unilib.pkg.plant_cotton_wild.exec()

    unilib.register_node("unilib:plant_cotton_wild", "farming:cotton_wild", mode, {
        -- From farming:cotton_wild
        description = unilib.annotate(S("Wild Cotton"), "Gossypium"),
        tiles = {"unilib_plant_cotton_wild.png"},
        -- N.B. flora = 1, not_in_creative_inventory = 1 not in original code
        groups = {
            attached_node = 1, flammable = 4, flora = 1, not_in_creative_inventory = 1, snappy = 3,
        },
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        drop = "unilib:crop_cotton_seed",
        inventory_image = "unilib_plant_cotton_wild.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-6 / 16, -8 / 16, -6 / 16, 6 / 16, 5 / 16, 6 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_cotton_wild.png",
    })
    if unilib.mtgame_tweak_flag then

        -- Adapted from farming_redo/crops/cotton.lua
        unilib.override_item("unilib:plant_cotton_wild", {
            drop = {
                items = {
                    {items = {"unilib:crop_cotton_harvest"}, rarity = 2},
                    {items = {"unilib:crop_cotton_seed"}, rarity = 1},
                },
            },
        })

    end
    -- (not compatible with flowerpots)

    unilib.register_decoration("farming_plant_cotton_wild", {
        -- From farming/init.lua
        deco_type = "simple",
        decoration = "unilib:plant_cotton_wild",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            scale = 0.1,
            seed = 4242,
            spread = {x = 50, y = 50, z = 50},
        },
        sidelen = 16,
    })

end
