---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_standard_lava_cool = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_cool(pos, node)

    if unilib.global.lava_cooling_table[node.name] ~= nil then
        core.set_node(pos, {name = unilib.global.lava_cooling_table[node.name]})
    else
        core.set_node(pos, {name = "unilib:stone_ordinary"})
    end

    core.sound_play(
        "unilib_cool_lava",
        {pos = pos, max_hear_distance = 16, gain = 0.2},
        true
    )

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_standard_lava_cool.init()

    return {
        description = "ABM to handle lava cooling (from minetest_game/default)",
    }

end

function unilib.pkg.abm_standard_lava_cool.post()

    -- Adapted from default/functions.lua
    -- Any lava source/flowing nodes have already been registered in a call to
    --      unilib.register_lava()

    if core.settings:get_bool("enable_lavacooling") == false then
        return
    end

    local node_list = {}
    for lava_name, cooled_name in pairs(unilib.global.lava_cooling_table) do

        -- Check that both the package that creates both the lava node and cooled node has actually
        --      been loaded; if not, the abm will cause a crash
        if core.registered_nodes[lava_name] ~= nil and
                core.registered_nodes[cooled_name] ~= nil then
            table.insert(node_list, lava_name)
        end

    end

    unilib.register_abm({
        label = "Lava cooling [abm_standard_lava_cool]",
        nodenames = node_list,
        neighbors = {"group:cools_lava", "group:water"},

        catch_up = false,
        chance = 2,
        interval = 2,

        action = function(...)
            do_cool(...)
        end,
    })
    unilib.register_obsolete_abm({
        mod_origin = "default",
        label = "Lava cooling",
    })

end
