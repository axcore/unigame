---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- gui_intro.lua
--      API functions for the introductory system formspec
---------------------------------------------------------------------------------------------------

local S = unilib.intllib
local F = core.formspec_escape
local FS = function(...) return F(S(...)) end

local intro_formname = "unilib:form_system_gui_intro"

local current_tab = 1

local dark_colour = "#000000"

local unidrinks_url = "https://github.com/axcore/unidrinks"
local unigame_url = "https://github.com/axcore/unigame"
local unilib_url = "https://github.com/axcore/unilib"
local unimobs_url = "https://github.com/axcore/unimobs"
local unitest_url = "https://github.com/axcore/unitest"

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_intro_formspec()

    local formspec =
        "size[8,8;]" ..
        "tabheader[0,0;tabs;" .. FS("Welcome") .. "," .. FS("Games") .. "," ..
            FS("Expansion packs") .. "," .. FS("Help") .. ";" .. current_tab .. ";false;false]" ..
        "image[0,0;1,1;unilib_logo_unilib.png]"

    if current_tab == 1 then

        formspec = formspec ..
            "label[1.2,0.2;" .. FS("Welcome to unilib!") .. "]" ..
            "box[0.3,1.25;7.2,4.3;" .. dark_colour .. "]" ..
            "textarea[0.8,1.25;7.2,4.8;;;" ..
                "\n" ..
                FS(
                    "unilib contains material from over 200 Minetest mods and modpacks, all" ..
                    " re-organised as a single mod."
                ) .. "\n\n" ..
                FS(
                    "Everything has been divided into the smallest possible components, called" ..
                    " packages."
                ) .. "\n\n" ..
                FS(
                    "For example, there is one package for sand, and another providing both" ..
                        " stone and cobblestone.") .. "\n\n" ..
                FS(
                    "A remix is a list of packages. If you like, you can create your own" ..
                    " remixes. However, unilib already provides a large selection of remixes," ..
                    " ready for you to use."
                ) ..
                "]" ..
            "button[0.3,5.8;7.4,1;browse_btn;" .. FS("Browse all remixes") .. "]" ..
            "button[0.3,6.6;7.4,1;create_btn;" .. FS("Create your own remix") .. "]" ..
            "checkbox[0.3,7.4;startup_btn;" .. FS("Show this window on startup") .. ";true]"

    elseif current_tab == 2 then

        formspec = formspec ..
            "label[1.2,0.2;" .. FS("Games that use unilib") .. "]" ..
            -- 384x202, approx 1.9/1
            "image[0.3,1.25;5.6,3;unilib_logo_unigame.png]" ..
            "hypertext[5.3,2.6;3,1;;<b>unigame</b>]" ..
            "button_url[5,3.05;2,1;;" .. FS("Download") .. ";" .. unigame_url .. "]" ..
            "textarea[0.5,4;8,2;;;" ..
                FS(
                    "A traditional voxel game with many beautiful biomes and lots of stuff to" ..
                    " collect. It includes both unilib itself and the unimobs expansion pack."
                ) .. "]"

    elseif current_tab == 3 then

        formspec = formspec ..
            "label[1.2,0.2;" .. FS("Expansion packs for unilib") .. "]" ..
            -- 250x200
            "image[0,1.25;2,1.6;unilib_logo_unimobs.png]" ..
            "hypertext[2,1.2;3,1;;<b>unimobs</b>]" ..
            "textarea[2,1.5;4.9,1.75;;;" ..
                FS(
                    "Provides lots of animals, birds and insects (as well as a few monsters)." ..
                    " The API is based on mobkit."
                ) .. "]" ..
            "button_url[6.5,1.15;1.5,1;;" .. FS("Download") .. ";" .. unimobs_url .. "]" ..
            -- 250x200
            "image[0,3;2,1.6;unilib_logo_unidrinks.png]" ..
            "hypertext[2,2.95;3,1;;<b>unidrinks</b>]" ..
            "textarea[2,3.25;4.9,1.75;;;" ..
                FS("Provides beers, wines and other alcholic drinks. 18+.") .. "]" ..
            "button_url[6.5,2.9;1.5,1;;" .. FS("Download") .. ";" .. unidrinks_url .. "]" ..
            -- 250x200
            "image[0,4.75;2,1.6;unilib_logo_unitest.png]" ..
            "hypertext[2,4.7;3,1;;<b>unitest</b>]" ..
            "textarea[2,5;4.9,1.75;;;" ..
                FS("An empty template for creating your own expansion packs.") .. "]" ..
            "button_url[6.5,4.64;1.5,1;;" .. FS("Download") .. ";" .. unitest_url .. "]"

    elseif current_tab == 4 then

        local version_str = unilib.core.name .. " v" .. unilib.core.ver_max .. "." ..
                unilib.core.ver_min .. "." .. string.format("%03d", unilib.core.ver_rev)

        formspec = formspec ..
            "label[1.2,0.2;" .. FS("Help for unilib") .. "]" ..
            "hypertext[3.4,1.5;7,1;;<b>" .. version_str .. "</b>]" ..
            "hypertext[2.4,2;7,1;;<i>" .. F("Copyright (C) 2021-2026 A S Lewis") .. "</i>]" ..
            "box[0.5,2.9;6.75,3.5;" .. dark_colour .. "]" ..
            "textarea[1,2.9;7,4;;;" ..
                "\n" ..
                F(
                    "Licence (original code): GNU Lesser General Public License," ..
                    " version 2.1 (LGPLv2.1)"
                ) .. "\n\n" ..
                F(
                    "Licence (original media): Attribution-ShareAlike 3.0 Unported" ..
                    " (CC BY-SA 3.0)"
                ) .. "\n\n" ..
                F(
                    "Licence (imported code and media): see ../licences and" ..
                    " ../csv/mods/source.csv"
                ) ..
                "]" ..
            "button_url[0.5,6.9;7,1;;" .. FS("Go to website") .. ";" .. unilib_url .. "]"

    end

    return formspec

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.gui._open_intro_formspec(pname)
    core.show_formspec(pname, intro_formname, get_intro_formspec())
end

---------------------------------------------------------------------------------------------------
-- Setup
---------------------------------------------------------------------------------------------------

core.register_on_player_receive_fields(function(player, formname, fields)

    if formname ~= intro_formname then
        return false
    end

    local pname = player:get_player_name()

    if formname == intro_formname then

        -- Handle tab switching
        if fields.tabs then

            current_tab = tonumber(fields.tabs) or 1
            core.show_formspec(pname, intro_formname, get_intro_formspec())

        -- Handle buttons
        elseif fields.browse_btn then

            current_tab = 1
            unilib.gui.open_config_formspec(pname)

        elseif fields.create_btn then

            current_tab = 1
            unilib.gui.open_create_formspec(pname)

        elseif fields.startup_btn then

            if fields.startup_btn == "false" then

                core.settings:set_bool("unilib_show_intro_win_flag", false)
                core.settings:write()

            elseif fields.startup_btn == "true" then

                core.settings:set_bool("unilib_show_intro_win_flag", true)
                core.settings:write()

            end

        end

    end

end)
