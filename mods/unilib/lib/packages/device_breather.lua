---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    hook
-- Code:    LGPL-2.1
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.device_breather = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.hook.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.device_breather.init()

    return {
        description = "Mouth breather assembly",
        notes = "Use up to ten times in a vacuum or under water to refill your lungs with air." ..
                " Use in air to refill the breather",
        depends = {"metal_steel", "shared_hook"},
    }

end

function unilib.pkg.device_breather.exec()

    local c_ingot = "unilib:metal_steel_ingot"

    unilib.register_tool("unilib:device_breather", "hook:mba", mode, {
        -- From hook:mba
        description = S("Mouth Breather Assembly"),
        inventory_image = "unilib_device_breather.png",

        range = 1,

        on_use = function(itemstack, user, pointed_thing)

            local pos = user:get_pos()
            pos.y = pos.y + 1.5

            if unilib.pkg.shared_hook.has_property(pos, "drowning") == 0 then

                itemstack:set_wear(1)

            else

                local use = itemstack:get_wear() + (unilib.constant.max_tool_wear / 10)
                if use <= unilib.constant.max_tool_wear then

                    itemstack:set_wear(use)
                    user:set_breath(11)

                end

            end

            return itemstack

        end,
    })
    unilib.register_craft({
        -- From hook:mba
        output = "unilib:device_breather",
        recipe = {
            {"", c_ingot, ""},
            {c_ingot, c_ingot, c_ingot},
            {c_ingot, "", c_ingot},
        },
    })
    unilib.tools.register_no_repair(
        "unilib:device_breather", S("This assembly cannot be repaired")
    )

end
