---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_axe_stone = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_axe_stone.init()

    return {
        description = "Stone axe",
        optional = "gravel_ordinary",
    }

end

function unilib.pkg.tool_axe_stone.exec()

    unilib.register_tool("unilib:tool_axe_stone", "default:axe_stone", mode, {
        -- From default:axe_stone
        description = S("Stone Axe"),
        inventory_image = "unilib_tool_axe_stone.png",
        groups = {axe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 3},
            full_punch_interval = 1.2,
            groupcaps = {
                choppy = {times = {[1] = 3.00, [2] = 2.00, [3] = 1.30}, uses = 20, maxlevel = 1},
            },
            max_drop_level = 0,
        },

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_axe({
        -- From default:axe_stone
        part_name = "stone",
        ingredient = "group:stone",
    })
    if unilib.mtgame_tweak_flag and unilib.pkg_executed_table["gravel_ordinary"] ~= nil then

        unilib.register_craft_axe({
            -- From default:axe_stone
            part_name = "stone",
            ingredient = "unilib:gravel_ordinary",
        })

    end
    unilib.apply_toolranks("unilib:tool_axe_stone", "axe")

end
