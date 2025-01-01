---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    fire
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_standard_flame_remove = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.fire.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_standard_flame_remove.init()

    return {
        description = "ABM to handle removal of basic flames (from minetest_game/fire)",
        depends = "fire_ordinary",
    }

end

function unilib.pkg.abm_standard_flame_remove.post()

    -- Adapted from fire/init.lua
    -- Remove flammable nodes around basic flame

    if not unilib.global.enable_fire_flag then
        return
    end

    unilib.register_abm({
        label = "Remove flammable nodes [abm_standard_flame_remove]",
        nodenames = {"unilib:fire_ordinary"},
        neighbors = "group:flammable",

        catch_up = false,
        chance = 18,
        interval = 5,

        action = function(pos)

            local p = core.find_node_near(pos, 1, {"group:flammable"})
            if not p then
                return
            end

            local flammable_node = core.get_node(p)
            local def = core.registered_nodes[flammable_node.name]

            if def.on_burn then

                def.on_burn(p)

            else

                core.remove_node(p)
                core.check_for_falling(p)

            end

        end,
    })
    unilib.register_obsolete_abm({
        mod_origin = "fire",
        label = "Remove flammable nodes",
    })

end
