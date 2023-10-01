---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xocean
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_kelp_ordinary_dried = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xocean.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_kelp_ordinary_dried.init()

    return {
        description = "Dried ordinary kelp",
        depends = "plant_kelp_ordinary",
    }

end

function unilib.pkg.plant_kelp_ordinary_dried.exec()

    -- (New texture to match the dried kelp texture below)
    unilib.override_item("unilib:plant_kelp_ordinary", {
        inventory_image = "unilib_plant_kelp_ordinary_xocean.png",
        wield_image = "unilib_plant_kelp_ordinary_xocean.png",
    })

    unilib.register_craftitem("unilib:plant_kelp_ordinary_dried", "xocean:kelp", mode, {
        -- From xocean:kelp
        description = S("Dried Ordinary Kelp"),
        inventory_image = "unilib_plant_kelp_ordinary_dried.png",
        -- N.B. No groups in original code
        groups = {food_kelp = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:plant_kelp_ordinary", 1),
    })
    unilib.register_craft({
        -- From xocean:kelp
        type = "cooking",
        output = "unilib:plant_kelp_ordinary_dried",
        recipe = "unilib:plant_kelp_ordinary",
    })

    unilib.register_node("unilib:plant_kelp_ordinary_dried_block", "xocean:kelp_block", mode, {
        -- From xocean:kelp_block
        description = S("Dried Ordinary Kelp Block"),
        tiles = {"unilib_plant_kelp_ordinary_dried_block.png"},
        groups = {snappy = 3},
        -- (no sounds)

        drop= "unilib:plant_kelp_ordinary_dried 9",
    })
    unilib.register_craft_3x3({
        -- From xocean:kelp_block
        output = "unilib:plant_kelp_ordinary_dried_block",
        ingredient = "unilib:plant_kelp_ordinary_dried",
    })

end
