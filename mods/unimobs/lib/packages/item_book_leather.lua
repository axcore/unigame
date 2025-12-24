---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unimobs
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_book_leather = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unimobs.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_book_leather.init()

    return {
        description = "Leather book",
        notes = "Unlike ordinary books, leather books are not flammable",
        depends = {"item_paper_parchment", "organ_leather_normal", "shared_default_book"},
    }

end

function unilib.pkg.item_book_leather.exec()

    unilib.register_craftitem("unilib:item_book_leather", nil, mode, {
        -- Original to unimobs
        description = S("Leather Book"),
        inventory_image = "unilib_item_book_leather.png",
        groups = {book = 1},

        on_use = unilib.pkg.shared_default_book.on_use,
    })
    unilib.register_craft({
        -- From default:book
        output = "unilib:item_book_leather",
        recipe = {
            {"unilib:organ_leather_normal"},
            {"unilib:item_paper_parchment"},
            {"unilib:item_paper_parchment"},
        },
    })

    unilib.register_craftitem("unilib:item_book_leather_written", nil, mode, {
        -- Original to unimobs
        description = S("Leather Book with Writing"),
        inventory_image = "unilib_item_book_leather_written.png",
        groups = {book = 1, not_in_creative_inventory = 1},

        stack_max = 1,

        on_use = unilib.pkg.shared_default_book.on_use,
    })
    unilib.register_craft_metadata_copy(
        "unilib:item_book_leather",
        "unilib:item_book_leather_written"
    )

end
