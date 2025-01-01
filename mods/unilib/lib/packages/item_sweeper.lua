---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.item_sweeper = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_sweeper.init()

    return {
        description = "Sweeper",
        depends = {"item_stick_ordinary", "grass_jungle"},
    }

end

function unilib.pkg.item_sweeper.exec()

    unilib.register_craftitem("unilib:item_sweeper", "moreblocks:sweeper", mode, {
        -- From moreblocks:sweeper
        description = S("Sweeper"),
        inventory_image = "unilib_item_sweeper.png",
    })
    -- N.B. This is an important item (many players want clean glass), and the biomes which spawn
    --      jungle grass might not be available; therefore here, jungle grass is replaced by all
    --      grasses
    --[[
    unilib.register_craft({
        -- From moreblocks:sweeper
        output = "unilib:item_sweeper 4",
        recipe = {
            {"unilib:grass_jungle"},
            {"unilib:item_stick_ordinary"},
        },
    })
    ]]--
    unilib.register_craft({
        -- From moreblocks:sweeper
        output = "unilib:item_sweeper 4",
        recipe = {
            {"group:grass"},
            {"unilib:item_stick_ordinary"},
        },
    })

end
