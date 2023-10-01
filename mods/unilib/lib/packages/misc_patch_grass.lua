---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/dryplants
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_patch_grass = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.dryplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_patch_grass.init()

    return {
        description = "Patch of grass",
        notes = "Grass can be cut with a grass-cutting sickle",
        optional = {"grass_jungle", "grass_ordinary"},
    }

end

function unilib.pkg.misc_patch_grass.exec()

    unilib.register_node("unilib:misc_patch_grass", "dryplants:grass", mode, {
        -- From dryplants:grass
        description = S("Patch of Grass"),
        tiles = {"unilib_misc_patch_grass.png"},
        groups = {flammable = 2, snappy = 3},
        sounds = unilib.sound_table.leaves,

        drawtype = "nodebox",
        inventory_image = "unilib_misc_patch_grass.png",
        node_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
        },
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        wield_image = "unilib_misc_patch_grass.png",
    })
    if unilib.pkg_executed_table["grass_ordinary"] ~= nil then

        unilib.register_craft({
            -- From dryplants:grass
            output = "unilib:misc_patch_grass",
            recipe = {
                {"unilib:grass_ordinary_1"},
            }
        })

    end
    if unilib.pkg_executed_table["grass_jungle"] ~= nil then

        unilib.register_craft({
            -- From dryplants:grass
            output = "unilib:misc_patch_grass",
            recipe = {
                {"unilib:grass_jungle"},
            }
        })

    end
    -- (not compatible with flowerpots)

    unilib.register_node("unilib:misc_patch_grass_dead", "dryplants:hay", mode, {
        -- From dryplants:hay
        description = S("Patch of Dead Grass"),
        tiles = {"unilib_misc_patch_grass_dead.png"},
        groups = {flammable = 2, snappy = 3},
        sounds = unilib.sound_table.leaves,

        drawtype = "nodebox",
        inventory_image = "unilib_misc_patch_grass_dead.png",
        node_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
        },
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        wield_image = "unilib_misc_patch_grass_dead.png",
    })
    unilib.register_craft({
        -- From unilib:misc_patch_grass_dead
        type = "cooking",
        output = "unilib:misc_patch_grass_dead",
        recipe = "unilib:misc_patch_grass",
        cooktime = 2,
    })
    unilib.register_craft({
        -- From unilib:misc_patch_grass_dead
        type = "fuel",
        recipe = "unilib:misc_patch_grass_dead",
        burntime = 1,
    })
    -- (not compatible with flowerpots)

    -- Patches of grass die over time
    unilib.register_abm({
        label = "Patch of grass death [misc_patch_grass]",
        nodenames = {"unilib:misc_patch_grass"},

        chance = 1,
        -- N.B. in original code, 1200 in comments, but 3600 in settings
        interval = 3600,

        action = function(pos)
            minetest.swap_node(pos, {name = "unilib:misc_patch_grass_dead"})
        end,
    })

end
