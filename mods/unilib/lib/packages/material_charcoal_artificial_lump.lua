---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.material_charcoal_artificial_lump = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.material_charcoal_artificial_lump.init()

    return {
        description = "Artificial charcoal lump",
        notes = "Produced by burning tree trunks in a furnace, or directly from scorched tree" ..
                " trunks",
        optional = {"item_stick_ordinary", "torch_ordinary", "tree_scorched"},
    }

end

function unilib.pkg.material_charcoal_artificial_lump.exec()

    unilib.register_craftitem(
        -- From ethereal:charcoal_lump
        "unilib:material_charcoal_artificial_lump",
        "ethereal:charcoal_lump",
        mode,
        {
            description = S("Lump of Artificial Charcoal"),
            inventory_image = "unilib_material_charcoal_artificial_lump.png"
        }
    )
    unilib.register_craft({
        -- From ethereal:charcoal_lump
        type = "cooking",
        output = "unilib:material_charcoal_artificial_lump 2",
        recipe = "group:tree",
        cooktime = 4,
    })
    unilib.register_craft({
        -- From ethereal:charcoal_lump
        type = "fuel",
        recipe = "unilib:material_charcoal_artificial_lump",
        burntime = 10,
    })
    if unilib.pkg_executed_table["tree_scorched"] ~= nil then

        -- N.B. Original craft recipe conflicts with recipe in "tree_scorched" package
        --[[
        unilib.register_craft({
            -- From ethereal:charcoal_lump
            output = "unilib:material_charcoal_artificial_lump 2",
            recipe = {
                {"unilib:tree_scorched_trunk"},
            },
        })
        ]]--
        unilib.register_craft({
            -- From ethereal:charcoal_lump
            output = "unilib:material_charcoal_artificial_lump 8",
            recipe = {
                {"unilib:tree_scorched_wood"},
            },
        })

    end
    if unilib.pkg_executed_table["item_stick_ordinary"] ~= nil and
            unilib.pkg_executed_table["torch_ordinary"] ~= nil then

        unilib.register_craft({
            output = "unilib:torch_ordinary 4",
            recipe = {
                {"unilib:material_charcoal_artificial_lump"},
                {"unilib:item_stick_ordinary"},
            },
        })

    end

end
