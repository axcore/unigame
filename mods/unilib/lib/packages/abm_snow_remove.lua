---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_snow_remove = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.snow.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_snow_remove.init()

    return {
        description = "Converts dirt with snow to ordinary dirt when without sunlight, etc",
        depends = "dirt_ordinary",
    }

end

function unilib.pkg.abm_snow_remove.exec()

    -- If dirt with snow is covered by blocks that don't let light through, or have a light
    --      paramtype/liquidtype combination, convert it to ordinary dirt
    unilib.register_abm({
        label = "Remove snow on dirt [abm_snow_remove]",
        nodenames = {"unilib:dirt_ordinary_with_cover_snow"},

        chance = 20,
        interval = 2,

        action = function(pos)

            local name = minetest.get_node({x = pos.x, y = pos.y + 1, z = pos.z}).name
            local nodedef = minetest.registered_nodes[name]
            if name ~= "ignore" and
                    nodedef and not (
                        (nodedef.sunlight_propagates or nodedef.paramtype == "light")
                        and nodedef.liquidtype == "none"
                    ) then
                minetest.set_node(pos, {name = "unilib:dirt_ordinary"})
            end

        end,
    })

end
