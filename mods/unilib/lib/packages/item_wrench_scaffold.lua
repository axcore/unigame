---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    scaffolding
-- Code:    CC-BY-SA-4.0
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_wrench_scaffold = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.scaffolding.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_wrench_scaffold.init()

    return {
        description = "Scaffolding wrench",
        notes = "Used to reinforce wooden and iron scaffolding, so that removing the bottom" ..
                " node doesn't remove the whole structure. Also works in reverse",
        depends = "metal_steel",
    }

end

function unilib.pkg.item_wrench_scaffold.exec()

    unilib.register_craftitem(
        -- From scaffolding:scaffolding_wrench
        "unilib:item_wrench_scaffold",
        "scaffolding:scaffolding_wrench",
        mode,
        {
            description = S("Scaffolding Wrench"),
            inventory_image = "unilib_item_wrench_scaffold.png",
        }
    )
    -- N.B. Original craft recipe conflicts with recipe in "misc_walkway" package
    --[[
    unilib.register_craft({
        -- From scaffolding:scaffolding_wrench
        output = "unilib:item_wrench_scaffold",
        recipe = {
            {"", "unilib:metal_steel_ingot", ""},
            {"", "unilib:metal_steel_ingot", "unilib:metal_steel_ingot"},
            {"unilib:metal_steel_ingot", "", ""},
        },
    })
    ]]--
    unilib.register_craft({
        -- From scaffolding:scaffolding_wrench
        output = "unilib:item_wrench_scaffold",
        recipe = {
            {"", "unilib:metal_steel_ingot", ""},
            {"unilib:metal_steel_ingot", "unilib:metal_steel_ingot", ""},
            {"", "", "unilib:metal_steel_ingot"},
        },
    })

end
