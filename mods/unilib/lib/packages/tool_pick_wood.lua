---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_pick_wood = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_pick_wood.init()

    return {
        description = "Wooden pickaxe",
    }

end

function unilib.pkg.tool_pick_wood.exec()

    -- N.B. unilib stones have variable hardness, so in some games (e.g. those using the "gaia"
    --      remix) it's very hard for a new player to dig their first stone. As a compromise, allow
    --      more types of stone to be dug with this tool, but make it slower
    local groupcap_table
    if not unilib.setting.mtgame_tweak_flag then
        groupcap_table = {cracky = {times = {[3] = 1.60}, uses = 10, maxlevel = 1}}
    else
        groupcap_table = {cracky = {times = {[2] = 16, [3] = 8}, uses = 10, maxlevel = 1}}
    end

    unilib.register_tool("unilib:tool_pick_wood", "default:pick_wood", mode, {
        -- From default:pick_wood
        description = S("Wooden Pickaxe"),
        inventory_image = "unilib_tool_pick_wood.png",
        groups = {flammable = 2, pickaxe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 2},
            full_punch_interval = 1.2,
            groupcaps = groupcap_table,
            max_drop_level = 0,
        },

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_pick({
        -- From default:pick_wood
        part_name = "wood",
        ingredient = "group:wood",
    })
    unilib.register_craft({
        -- From default:pick_wood
        type = "fuel",
        recipe = "unilib:tool_pick_wood",
        burntime = 6,
    })
    unilib.tools.apply_toolranks("unilib:tool_pick_wood", "pickaxe")

end
