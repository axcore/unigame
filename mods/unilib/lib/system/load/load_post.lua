---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- load_post.lua
--      Execute package .post() functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Call each package's .post() function (if one is specified), in the same order in which .init()
--      functions were called
-- The .post() function contains any code that must only be executed once all package .exec()
--      functions have been called

for _, pkg_name in ipairs(unilib.load.exec_list) do

    local ns_table = unilib.pkg[pkg_name]

    -- If this package has no .post() function, or if the package was not executed earlier, then
    --      don't try to post-execute it
    if ns_table.post ~= nil and unilib.global.pkg_executed_table[pkg_name] ~= nil then

        unilib.global.current_pkg = pkg_name
        ns_table.post()
        unilib.global.current_pkg = nil

        if unilib.setting.show_pkg_post_flag and unilib.setting.show_msg_flag then
            unilib.utils.show_msg("Post-executed package", pkg_name)
        end

    elseif unilib.setting.show_pkg_post_flag and unilib.setting.show_msg_flag then

        unilib.utils.show_msg("Post-executed package (no .post() to call)", pkg_name)

    end

end
