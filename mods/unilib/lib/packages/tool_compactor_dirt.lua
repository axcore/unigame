---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_compactor_dirt = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.earthbuild.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_compact(itemstack, user, pointed_thing)

    -- Was ram()

    local player_name = user:get_player_name()

    if pointed_thing.type ~= "node" then
        return
    end

    local pos = pointed_thing.under
    local node = core.get_node(pos)

    if core.get_item_group(node.name, "soil") == 1 then

        core.sound_play(
            "unilib_tool_dirt",
            {pos = pos, max_hear_distance = 5, loop = false, gain = 0.5}
        )

        core.set_node(pos, {name = "unilib:dirt_compacted"})

        if unilib.utils.is_creative(player_name) then

            -- Wear the tool
            local def_table = itemstack:get_definition()
            itemstack:add_wear(700)
            if itemstack:get_count() == 0 then
                core.sound_play("unilib_tool_breaks", {pos = sound_pos, gain = 0.5})
            end

            return itemstack

        end

    end

end
---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_compactor_dirt.init()

    return {
        description = "Dirt compactor",
        notes = "When used on dirt, produces compacted dirt for building floors",
        depends = {"dirt_compacted", "tool_shovel_wood"},
    }

end

function unilib.pkg.tool_compactor_dirt.exec()

    unilib.register_tool("unilib:tool_compactor_dirt", "earthbuild:dirt_compactor", mode, {
        -- From earthbuild:dirt_compactor
        description = S("Dirt Compactor"),
        inventory_image = "unilib_tool_compactor_dirt.png",
        groups = {flammable = 2},
        sound = {breaks = "unilib_tool_breaks"},

        on_use = do_compact,
    })
    unilib.register_craft({
        -- From earthbuild:dirt_compactor
        output = "unilib:tool_compactor_dirt",
        recipe = {
            {"group:stick", "unilib:tool_shovel_wood", "group:stick"},
        },
    })

end
