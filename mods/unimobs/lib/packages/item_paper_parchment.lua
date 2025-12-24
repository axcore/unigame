---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_paper_parchment = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_paper_parchment.init()

    return {
        description = "Parchment",
        notes = "An alternative crafting ingredient, made from leather, for crafting books",
        depends = "organ_leather_normal",
        optional = "item_book_ordinary",
    }

end

function unilib.pkg.item_paper_parchment.exec()

    local c_leather = "unilib:organ_leather_normal"

    unilib.register_craftitem("unilib:item_paper_parchment", "petz:parchment", mode, {
        -- From petz:parchment
        description = S("Parchment"),
        inventory_image = "unilib_item_paper_parchment.png",
    })
    unilib.register_craft({
        -- From petz:parchment
        type = "shaped",
        output = "unilib:item_paper_parchment",
        recipe = {
            {"", "", ""},
            {"", "", ""},
            {c_leather, c_leather, c_leather},
        },
    })
    if unilib.global.pkg_executed_table["item_book_ordinary"] ~= nil then

        unilib.register_craft({
            -- From petz:parchment
            type = "shaped",
            output = "unilib:item_book_ordinary",
            recipe = {
                {"unilib:item_paper_parchment", "", ""},
                {"unilib:item_paper_parchment", "", ""},
                {"unilib:item_paper_parchment", "", ""},
            },
        })

    end

end
