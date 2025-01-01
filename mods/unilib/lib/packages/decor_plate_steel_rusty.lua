---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    steel
-- Code:    GPL-2.0
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_plate_steel_rusty = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.steel.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_plate_steel_rusty.init()

    return {
        description = "Rusty steel plate",
        depends = "decor_plate_steel_soft",
    }

end

function unilib.pkg.decor_plate_steel_rusty.exec()

    unilib.register_node("unilib:decor_plate_steel_rusty", "steel:plate_rusted", mode, {
        -- From steel:plate_rusted
        description = S("Rusty Steel Plate"),
        tiles = {"unilib_decor_plate_steel_rusty.png"},
        -- N.B. dig_stone = 1 in original code
        groups = {choppy = 1, cracky = 1},
        -- N.B. "stone" in original code
        sounds = unilib.global.sound_table.metal,

        -- N.B. is_ground_content = false not in original code; added to match other decor items
        is_ground_content = false,
    })
    --[[
    unilib.register_abm({
        label = "Generate rusty steel [decor_plate_steel_rusty]",
        nodenames = {"unilib:decor_plate_steel_soft"},
        neighbors = {"group:water"},

        chance = 20,
        interval = 50,

        action = function(pos)

            if core.find_node_near(pos, 2, "air") then
                core.set_node(pos, {name = "unilib:decor_plate_steel_rusty"})
            end

        end,
    })
    ]]--

end

function unilib.pkg.decor_plate_steel_rusty.post()

    -- N.B. Other "rusty" items in unilib are generally crafted using water; for consistency with
    --      those items, we use this new crafting recipe rather than the original code's ABM
    unilib.register_craft({
        -- Original to unilib
        type = "shapeless",
        output = "unilib:decor_plate_steel_rusty",
        recipe = {
            "unilib:decor_plate_steel_soft",
            "group:craftable_bucket",
        },
        replacements = unilib.global.craftable_bucket_list,
    })

end
