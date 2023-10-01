---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cement
-- Code:    GPLv3.0
-- Media:   GPLv3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_tool('cement:sanding_tool', {
    description = S('Sanding Tool'),
    inventory_image = 'cement_sanding_tool.png',
    wield_image = 'cement_sanding_tool.png^[transformR270',
    sound = { breaks = 'default_tool_breaks' },
    -- Currently most of this gets ignored because Minetest struggles hard on
    -- cusom on_use and after_use functions.
    tool_capabilities = {
        full_punch_interval = 0.2,
        groupcaps = {
            cracky = { times = { [1]=0.2, [2]=0.2, [3]=0.2 }, uses = 100 }
        }
    },
    -- It seems not to be possible to have a custom on_use function and trigger
    -- the default after_use function (properly add wear, etc.). And the other
    -- way round it seems not to be possible to use the default on_use function
    -- (node digging animation, correct timings according to groupcaps, etc.)
    -- and get the just digged node position in a custom after_use function.
    on_use = function (itemstack, user, pointed_thing)
        local node = minetest.get_node(pointed_thing.under).name
        local player_name = user:get_player_name()
        local node_pos = pointed_thing.under

        if node ~= 'cement:hard' then return end

        if minetest.is_protected(node_pos, player_name) then
            minetest.record_protection_violation(node_pos, player_name)
            return
        end

        minetest.set_node(pointed_thing.under, { name = 'cement:sanded' })

        -- Manually determined by testing with custom after_use function
        -- printing the value. (218 is valid for 0.2 for all times and 100 for
        -- the `uses` value).
        itemstack:add_wear(218)

        return itemstack
    end
})
minetest.register_craft({
    output = 'cement:sanding_tool 1',
    recipe = {
        { 'default:steel_ingot', 'group:stick',   'dye:blue'   },
        { 'default:paper',       'default:paper', 'group:wood' },
        { 'group:sand',          'group:sand',    ''           }
    }
})
]]--
