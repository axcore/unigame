---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_gaia_sponge = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_gaia_sponge.init()

    return {
        description = "Sponges for \"gaia\"-compatible remixes",
        at_least_one = {"misc_sponge_fiery", "misc_sponge_normal"},
    }

end

function unilib.pkg.deco_gaia_sponge.post()

    if unilib.global.pkg_executed_table["misc_sponge_normal"] ~= nil then

        -- Reasonably rare
        unilib.register_decoration_simple({
            deco_type = "simple",
            decoration = {"unilib:misc_sponge_normal_wet"},

            fill_ratio = 0.0001,
            flags = "force_placement",
            place_on = "group:sand",
            spawn_by = "group:water",
            y_max = -15,
            y_min = -45,
        })

    end

    if unilib.global.pkg_executed_table["misc_sponge_fiery"] ~= nil then

        -- Ostensibly less rare than normal sponges, but spawns in lava caves (which are themselves
        --      not common)
        unilib.register_decoration_simple({
            deco_type = "simple",
            decoration = {"unilib:misc_sponge_fiery_wet"},

            fill_ratio = 0.001,
            flags = "force_placement",
            place_on = "group:lava",
            spawn_by = "air",
            y_max = -100,
            y_min = unilib.constant.y_min,
        })

    end

end
