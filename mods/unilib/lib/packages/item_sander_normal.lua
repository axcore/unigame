---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cement
-- Code:    GPLv3.0
-- Media:   GPLv3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_sander_normal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cement.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_sander_normal.init()

    return {
        description = "Concrete sanding tool",
        notes = "Sands rough (normal) concrete to create smooth concrete",
        depends = {"dye_basic", "item_paper_ordinary", "material_concrete_normal", "metal_steel"},
    }

end

function unilib.pkg.item_sander_normal.exec()

    unilib.register_tool("unilib:item_sander_normal", "cement:sanding_tool", mode, {
        -- From cement:sanding_tool
        description = S("Concrete Sanding Tool"),
        inventory_image = "unilib_item_sander_normal.png",
        -- (no groups)
        sound = {breaks = "unilib_tool_breaks"},

        wield_image = "unilib_item_sander_normal.png^[transformR270",

        -- Notes from original mod:
        -- Currently most of this gets ignored because Minetest struggles hard with custom .on_use()
        --      and .after_use() functions
        tool_capabilities = {
            full_punch_interval = 0.2,
            groupcaps = {
                cracky = {times = {[1] = 0.2, [2] = 0.2, [3] = 0.2}, uses = 100},
            },
        },

        -- Notes from original mod:
        -- It seems not to be possible to have a custom .on_use() function and trigger the default
        --      .after_use() function (to properly add wear, etc.)
        -- And the other way round it seems not to be possible to use the default .on_use() function
        --      (node digging animation, correct timings according to groupcaps, etc.) in order to
        --      get the just digged node position in a custom .after_use() function
        on_use = function(itemstack, user, pointed_thing)

            local node = minetest.get_node(pointed_thing.under).name
            local player_name = user:get_player_name()
            local node_pos = pointed_thing.under

            if node ~= "unilib:material_concrete_normal_rough" then
                return
            end

            if minetest.is_protected(node_pos, player_name) then

                minetest.record_protection_violation(node_pos, player_name)
                return

            end

            minetest.set_node(
                pointed_thing.under, {name = "unilib:material_concrete_normal_smooth"}
            )

            -- Notes from original mod:
            -- Manually determined by testing with custom .after_use() function printing the value.
            --      (218 is valid for 0.2 for all times and 100 for the "uses" value)
            itemstack:add_wear(218)

            return itemstack

        end,
    })
    unilib.register_craft({
        -- From cement:sanding_tool
        output = "unilib:item_sander_normal",
        recipe = {
            {"unilib:metal_steel_ingot", "group:stick", "unilib:dye_blue"},
            {"unilib:item_paper_ordinary", "unilib:item_paper_ordinary", "group:wood"},
            {"group:sand", "group:sand", ""},
        },
    })

end
