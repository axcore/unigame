---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_lasso_normal = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_lasso_normal.init()

    return {
        description = "Normal lasso",
        notes = "The default lasso for unimobs; however, it can only be used as a lasso if the" ..
                " item appears in the list of lassos in settings (which it does, by default)",
    }

end

function unilib.pkg.tool_lasso_normal.exec()

    -- N.B. The code to handle the use of this tool is in unimobs.petz_api.can_capture_mob(), called
    --      from unimobs.petz_api.on_rightclick_callback()

    local c_string = "unilib:item_string_ordinary"

    unilib.register_tool("unilib:tool_lasso_normal", "petz:lasso", mode, {
        -- From petz:lasso
        description =
                unilib.utils.hint(S("Normal Lasso"), S("right-click to capture larger creatures")),
        inventory_image = "unilib_tool_lasso_normal.png",
        groups = {flammable = 2, lasso = 1},
    })
    unilib.register_craft({
        -- From petz:lasso
        output = "unilib:tool_lasso_normal",
        recipe = {
            {c_string, c_string, c_string},
            {c_string, "", c_string},
            {"", c_string, ""},
        },
    })

end
