---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_book_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_book_ordinary.init()

    return {
        description = "Ordinary book",
        depends = {"item_paper_ordinary", "shared_default_book"},
    }

end

function unilib.pkg.item_book_ordinary.exec()

    unilib.register_craftitem("unilib:item_book_ordinary", "default:book", mode, {
        -- From default:book
        description = S("Ordinary Book"),
        inventory_image = "unilib_item_book_ordinary.png",
        groups = {book = 1, flammable = 3},

        on_use = unilib.pkg.shared_default_book.on_use,
    })
    unilib.register_craft({
        -- From default:book
        output = "unilib:item_book_ordinary",
        recipe = {
            {"unilib:item_paper_ordinary"},
            {"unilib:item_paper_ordinary"},
            {"unilib:item_paper_ordinary"},
        },
    })
    unilib.register_craft({
        -- From default:book
        type = "fuel",
        recipe = "unilib:item_book_ordinary",
        burntime = 3,
    })

    unilib.register_craftitem("unilib:item_book_ordinary_written", "default:book_written", mode, {
        -- From default:book_written
        description = S("Ordinary Book with Writing"),
        inventory_image = "unilib_item_book_ordinary_written.png",
        groups = {book = 1, flammable = 3, not_in_creative_inventory = 1},

        stack_max = 1,

        on_use = unilib.pkg.shared_default_book.on_use,
    })
    unilib.register_craft_metadata_copy(
        "unilib:item_book_ordinary",
        "unilib:item_book_ordinary_written"
    )
    unilib.register_craft({
        -- From default:book_written
        type = "fuel",
        recipe = "unilib:item_book_ordinary_written",
        burntime = 3,
    })

end
