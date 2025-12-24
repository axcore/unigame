---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_net_animal = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_net_animal.init()

    return {
        description = "Animal net",
        notes = "The default net for unimobs; however, it can only be used as a net if the" ..
                " item appears in the list of nets in settings (which it does, by default)",
        depends = "item_string_ordinary",
    }

end

function unilib.pkg.item_net_animal.exec()

    -- N.B. The code to handle the use of this tool is in unimobs.petz_api.can_capture_mob(), called
    --      from unimobs.petz_api.on_rightclick_callback()
    -- N.B. Animal nets were craftitems in the original code; converted them to tools, so they can
    --      take wear (when the setting is enabled)

    unilib.register_tool("unilib:item_net_animal", "petz:net", mode, {
        -- From petz:net
        description =
                unilib.utils.hint(S("Animal Net"), S("right-click to capture smaller creatures")),
        inventory_image = "unilib_item_net_animal.png",
        groups = {flammable = 2, net = 1}
    })
    unilib.register_craft({
        -- From petz:net
        type = "shaped",
        output = "unilib:item_net_animal",
        recipe = {
            {"unilib:item_string_ordinary", "unilib:item_string_ordinary", ""},
            {"", "group:stick", ""},
            {"", "", "group:stick"},
        },
    })

end
