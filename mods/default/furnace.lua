-- default/furnace.lua

-- support for MT game translation.
local S = default.get_translator

--
-- Formspecs
--

function default.get_furnace_active_formspec(fuel_percent, item_percent)
    return "size[8,8.5]"..
        "list[context;src;2.75,0.5;1,1;]"..
        "list[context;fuel;2.75,2.5;1,1;]"..
        "image[2.75,1.5;1,1;default_furnace_fire_bg.png^[lowpart:"..
        (fuel_percent)..":default_furnace_fire_fg.png]"..
        "image[3.75,1.5;1,1;gui_furnace_arrow_bg.png^[lowpart:"..
        (item_percent)..":gui_furnace_arrow_fg.png^[transformR270]"..
        "list[context;dst;4.75,0.96;2,2;]"..
        "list[current_player;main;0,4.25;8,1;]"..
        "list[current_player;main;0,5.5;8,3;8]"..
        "listring[context;dst]"..
        "listring[current_player;main]"..
        "listring[context;src]"..
        "listring[current_player;main]"..
        "listring[context;fuel]"..
        "listring[current_player;main]"..
        default.get_hotbar_bg(0, 4.25)
end

function default.get_furnace_inactive_formspec()
    return "size[8,8.5]"..
        "list[context;src;2.75,0.5;1,1;]"..
        "list[context;fuel;2.75,2.5;1,1;]"..
        "image[2.75,1.5;1,1;default_furnace_fire_bg.png]"..
        "image[3.75,1.5;1,1;gui_furnace_arrow_bg.png^[transformR270]"..
        "list[context;dst;4.75,0.96;2,2;]"..
        "list[current_player;main;0,4.25;8,1;]"..
        "list[current_player;main;0,5.5;8,3;8]"..
        "listring[context;dst]"..
        "listring[current_player;main]"..
        "listring[context;src]"..
        "listring[current_player;main]"..
        "listring[context;fuel]"..
        "listring[current_player;main]"..
        default.get_hotbar_bg(0, 4.25)
end
