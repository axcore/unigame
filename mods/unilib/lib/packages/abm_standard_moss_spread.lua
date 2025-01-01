---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_standard_moss_spread = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.snow.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_standard_moss_spread.init()

    return {
        description = "ABM to handle spread of moss (from snow)",
        depends = "shared_standard",
    }

end

function unilib.pkg.abm_standard_moss_spread.post()

    -- Adapted from snow/src/abms.lua
    -- Moss grows on cobble (and some of its stair variants) when they are near moss

    if unilib.pkg.shared_standard.moss_flag then

        unilib.register_abm({
            label = "Moss spread to cobble [abm_standard_moss_spread]",
            nodenames = {"group:cobble", "group:wall"},
            neighbors = {"group:moss"},

            catch_up = false,
            chance = 6,
            interval = 20,

            action = function(pos, node)

                node.name = moss_table[node.name]
                if node.name then
                    core.set_node(pos, node)
                end

            end,
        })

    end

end
