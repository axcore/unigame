---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_shovel_pounamu = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_shovel_pounamu.init()

    return {
        description = "Pounamu shovel",
        notes = "For any node in the \"crumbly\" group, digs the original node; for example," ..
                " digs the original dirt with grass node, rather than a pure dirt node",
        depends = {
            "dye_basic",
            "food_pith_mamaku",
            "food_shoots_cabbage",
            "rope_flax",
            "sand_volcanic",
            "stone_pounamu",
            "tree_kawakawa",
            "tree_maire_black",
        },
        optional = "override_ethereal_coral",
    }

end

function unilib.pkg.tool_shovel_pounamu.exec()

    unilib.register_tool("unilib:tool_shovel_pounamu", "aotearoa:shovel_green", mode, {
        -- From aotearoa:shovel_green
        description = S("Pounamu Shovel"),
        inventory_image = "unilib_tool_shovel_pounamu.png",
        -- N.B. no groups in original code, but the crystal shovel from ethereal does have
        --      shovel = 1, which is replicated here
        groups = {shovel = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 4},
            full_punch_interval = 1.0,
            max_drop_level = 1,
            groupcaps = {
                crumbly = {times = {[1] = 1.10, [2] = 0.50, [3] = 0.30}, uses = 30, maxlevel = 3},
            },
        },
        wield_image = "unilib_tool_shovel_pounamu.png^[transformR90",

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft({
        -- From aotearoa:shovel_green
        output = "unilib:tool_shovel_pounamu",
        recipe = {
            {
                "unilib:tree_kawakawa_leaves",
                "unilib:sand_volcanic",
                "unilib:tree_kawakawa_leaves",
            },
            {
                "unilib:dye_red",
                "unilib:stone_pounamu",
                "unilib:rope_flax",
            },
            {
                "unilib:food_pith_mamaku_cooked",
                "unilib:tree_maire_black_wood",
                "unilib:food_shoots_cabbage_cooked",
            },
        },
    })
    unilib.apply_toolranks("unilib:tool_shovel_pounamu", "shovel")

    -- (Dig the original node, e.g. dirt with grass instead of dirt)
    unilib.register_special_shovel("unilib:tool_shovel_pounamu")

end
