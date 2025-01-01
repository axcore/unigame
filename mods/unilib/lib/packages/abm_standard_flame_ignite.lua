---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    fire
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_standard_flame_ignite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.fire.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_standard_flame_ignite.init()

    return {
        description = "ABM to handle igniting of basic flames (from minetest_game/fire)",
        depends = "fire_ordinary",
    }

end

function unilib.pkg.abm_standard_flame_ignite.post()

    -- Adapted from fire/init.lua
    -- Ignite neighboring nodes, add basic flames

    if not unilib.global.enable_fire_flag then
        return
    end

    unilib.register_abm({
        label = "Ignite flame [abm_standard_flame_ignite]",
        nodenames = {"group:flammable"},
        neighbors = {"group:igniter"},

        catch_up = false,
        chance = 12,
        interval = 7,

        action = function(pos)

            local p = core.find_node_near(pos, 1, {"air"})
            if p then
                core.set_node(p, {name = "unilib:fire_ordinary"})
            end

        end,
    })
    unilib.register_obsolete_abm({
        mod_origin = "fire",
        label = "Ignite flame",
    })

end
