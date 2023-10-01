---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- lbms.lua
--      Set up shared LBMs
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- unilib standard LBMs can be enabled, or not, depending on Minetest settings and any packages that
--      have been loaded
local enable_lbm_flag = unilib.activate_standard_abm_lbm_flag
-- (The "disable" setting overrides everything else)
if unilib.disable_standard_abm_lbm_flag then
    enable_lbm_flag = false
elseif unilib.enable_standard_abm_lbm_flag then
    enable_lbm_flag = true
end

---------------------------------------------------------------------------------------------------
-- pane_rotate LBM
---------------------------------------------------------------------------------------------------

-- Adapated from xpanes/init.lua

if unilib.lbm_replace_table.pane_rotate ~= nil then

    -- Override the standard LBM with one specified by a package
    unilib.lbm_replace_table.pane_rotate()

elseif enable_lbm_flag then

    -- When running on top of minetest_game, unilib panes use the group "unipane" instead of "pane".
    --      This prevents a clash between unilib's LBM and the equivalent LBM in minetest_game
    if not unilib.use_unipanes_flag then

        unilib.register_lbm({
            label = "Handle connected panes [unilib]",
            name = "unilib:lbm_system_pane",
            nodenames = {"group:pane"},

            action = function(pos, node)

                unilib.update_pane(pos)
                for i = 0, 3 do

                    local dir = minetest.facedir_to_dir(i)
                    unilib.update_pane(vector.add(pos, dir))

                end

            end,
        })

    else

        unilib.register_lbm({
            label = "Handle connected panes [unilib]",
            name = "unilib:lbm_system_unipane",
            nodenames = {"group:unipane"},

            action = function(pos, node)

                unilib.update_pane(pos)
                for i = 0, 3 do

                    local dir = minetest.facedir_to_dir(i)
                    unilib.update_pane(vector.add(pos, dir))

                end

            end,
        })

    end

end
