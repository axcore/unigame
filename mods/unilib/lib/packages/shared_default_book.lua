---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_default_book = {}

local S = unilib.intllib
local F = core.formspec_escape
local FS = function(...) return F(S(...)) end
local mode = unilib.global.imported_mod_table.default.add_mode

local formspec_size = "size[8,8]"
local tab_number
-- Table of players currently engaged in writing a book
local writer_table = {}
-- Lines per page in the book
local lpp = 14
-- Other limits
local max_text_size = 10000
local max_title_size = 80
local short_title_size = 35

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function formspec_core(tab)

    -- From default/craftitems.lua

    if tab == nil then tab = 1 else tab = tostring(tab) end
    return "tabheader[0,0;book_header;" ..
        FS("Write") .. "," ..
        FS("Read") .. ";" ..
        tab .. ";false;false]"

end

local function formspec_write(title, text)

    -- From default/craftitems.lua

    return "field[0.5,1;7.5,0;title;" .. FS("Title:") .. ";" .. F(title) .. "]" ..
        "textarea[0.5,1.5;7.5,7;text;" .. FS("Contents:") .. ";" .. F(text) .. "]" ..
        "button_exit[2.5,7.5;3,1;save;" .. FS("Save") .. "]"

end

local function formspec_read(owner, title, string, text, page, page_max)

    -- From default/craftitems.lua

    return "label[0.5,0.5;" .. FS("by @1", owner) .. "]" ..
        "tablecolumns[color;text]" ..
        "tableoptions[background=#00000000;highlight=#00000000;border=false]" ..
        "table[0.4,0;7,0.5;title;#FFFF00," .. F(title) .. "]" ..
        "textarea[0.5,1.5;7.5,7;;" .. F(string ~= "" and string or text) .. ";]" ..
        "button[2.4,7.6;0.8,0.8;book_prev;<]" ..
        "label[3.2,7.7;" .. FS("Page @1 of @2", page, page_max) .. "]" ..
        "button[4.9,7.6;0.8,0.8;book_next;>]"

end

local function formspec_string(lpp, page, lines, string)

    -- From default/craftitems.lua

    for i = ((lpp * page) - lpp) + 1, lpp * page do
        if not lines[i] then break end
        string = string .. lines[i] .. "\n"
    end

    return string

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_default_book.on_use(itemstack, user)

    -- From default/craftitems.lua

    local player_name = user:get_player_name()
    local meta = itemstack:get_meta()
    local title, text, owner = "", "", player_name
    local page, page_max, lines, string = 1, 1, {}, ""
    local data = meta:to_table().fields

    if data.owner then

        title = data.title or ""
        text = data.text or ""
        owner = data.owner

        for str in (text .. "\n"):gmatch("([^\n]*)[\n]") do
            lines[#lines+1] = str
        end

        if data.page then

            page = data.page
            page_max = data.page_max
            string = formspec_string(lpp, page, lines, string)

        end

    end

    local formspec
    if title == "" and text == "" then

        formspec = formspec_write(title, text)

    elseif owner == player_name then

        local tab = tab_number or 1
        if tab == 2 then

            formspec = formspec_core(tab) ..
                    formspec_read(owner, title, string, text, page, page_max)

        else

            formspec = formspec_core(tab) .. formspec_write(title, text)

        end

    else

        formspec = formspec_read(owner, title, string, text, page, page_max)

    end

    core.show_formspec(player_name, "unilib:form_shared_default_book", formspec_size .. formspec)
    -- Store the wield index in case the user accidentally switches before the formspec is shown
    writer_table[player_name] = {wield_index = user:get_wield_index()}

    return itemstack

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_default_book.init()

    return {
        description = "Shared functions for books (from minetest_game/default)",
        notes = "The calling code should define two variants for each book, empty and written," ..
                " with names in the form unilib:BOOK and unilib:BOOK_written. See the" ..
                " \"item_book_ordinary\" package for a working example",
    }

end

function unilib.pkg.shared_default_book.exec()

    core.register_on_leaveplayer(function(player)
        writer_table[player:get_player_name()] = nil
    end)

    core.register_on_player_receive_fields(function(player, formname, fields)

        -- From default/craftitems.lua

        if formname ~= "unilib:form_shared_default_book" then
            return
        end

        local player_name = player:get_player_name()
        local inv = player:get_inventory()
        if not writer_table[player_name] then
            return
        end

        local wield_index = writer_table[player_name].wield_index
        local wield_list = player:get_wield_list()
        local stack = inv:get_stack(wield_list, wield_index)

        local stack_name, empty_name, written_name
        stack_name = stack:get_name()
        empty_name = stack_name:gsub("_written$", "")
        written_name = empty_name .. "_written"

        local written_flag = stack_name == written_name
        if stack_name ~= empty_name and not written_flag then

            -- No book in the wield slot, abort & inform the player
            core.chat_send_player(
                player_name, S("The book in which you were writing has mysteriously disappeared.")
            )

            return

        end

        local data = stack:get_meta():to_table().fields
        local title = data.title or ""
        local text = data.text or ""

        if fields.book_header ~= nil and data.owner == player_name then

            local contents
            local tab = tonumber(fields.book_header)

            if tab == 1 then

                contents = formspec_core(tab) .. formspec_write(title, text)

            elseif tab == 2 then

                local lines, string = {}, ""
                for str in (text .. "\n"):gmatch("([^\n]*)[\n]") do
                    lines[#lines+1] = str
                end

                string = formspec_string(lpp, data.page, lines, string)
                contents = formspec_read(player_name, title, string,
                        text, data.page, data.page_max)

            else

                -- Malicious data
                return

            end

            tab_number = tab
            local formspec = formspec_size .. formspec_core(tab) .. contents
            core.show_formspec(player_name, "unilib:form_shared_default_book", formspec)
            return

        end

        if fields.quit then
            writer_table[player_name] = nil
        end

        if fields.save and fields.title and fields.text then

            local new_stack

            if not written_flag then

                local count = stack:get_count()
                if count == 1 then

                    stack:set_name(written_name)

                else

                    stack:set_count(count - 1)
                    new_stack = ItemStack(written_name)

                end

            end

            if data.owner ~= player_name and title ~= "" and text ~= "" then
                return
            end

            if not data then data = {} end

            data.title = fields.title:sub(1, max_title_size)
            data.owner = player:get_player_name()
            local short_title = data.title
            -- Don't bother trimming the title if the trailing dots would make it longer
            if #short_title > short_title_size + 3 then
                short_title = short_title:sub(1, short_title_size) .. "..."
            end

            data.description = S("\"@1\" by @2", short_title, data.owner)
            data.text = fields.text:sub(1, max_text_size)
            data.text = data.text:gsub("\r\n", "\n"):gsub("\r", "\n")
            -- Strip naughty control characters (keeps \t and \n)
            data.text = data.text:gsub("[%z\1-\8\11-\31\127]", "")

            data.page = 1
            data.page_max = math.ceil((#data.text:gsub("[^\n]", "") + 1) / lpp)

            if new_stack then

                new_stack:get_meta():from_table({ fields = data })
                if inv:room_for_item("main", new_stack) then
                    inv:add_item("main", new_stack)
                else
                    core.add_item(player:get_pos(), new_stack)
                end

            else

                stack:get_meta():from_table({ fields = data })

            end

        elseif fields.book_next or fields.book_prev then

            if not data.page then
                return
            end

            data.page = tonumber(data.page)
            data.page_max = tonumber(data.page_max)

            if fields.book_next then

                data.page = data.page + 1
                if data.page > data.page_max then
                    data.page = 1
                end

            else

                data.page = data.page - 1
                if data.page == 0 then
                    data.page = data.page_max
                end

            end

            stack:get_meta():from_table({fields = data})
            stack = book_on_use(stack, player)

        end

        -- Update stack
        inv:set_stack(wield_list, wield_index, stack)

    end)

end
