---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    binoculars
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_binoculars_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.binoculars.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_binoculars_ordinary.init()

    return {
        description = "Ordinary binoculars",
        depends = {"glass_obsidian", "metal_bronze"},
    }

end

function unilib.pkg.item_binoculars_ordinary.exec()

    -- Update player property
    -- N.B. This was a global function in minetest_game/binoculars. In unilib it is a local
    --      function, because only one instance of binoculars has been implemented
    local function update_player_property(player)

        local new_zoom_fov = 0

        if player:get_inventory():contains_item("main", "unilib:item_binoculars_ordinary") then
            new_zoom_fov = 10
        elseif unilib.utils.is_creative(player:get_player_name()) then
            new_zoom_fov = 15
        end

        -- Only set property if necessary to avoid player mesh reload
        if player:get_properties().zoom_fov ~= new_zoom_fov then
            player:set_properties({zoom_fov = new_zoom_fov})
        end

    end

    -- Set player property 'on joinplayer'
    core.register_on_joinplayer(function(player)
        update_player_property(player)
    end)

    -- Cyclic update of player property
    local function cyclic_update()

        for _, player in ipairs(core.get_connected_players()) do
            update_player_property(player)
        end

        core.after(4.7, cyclic_update)

    end

    core.after(4.7, cyclic_update)

    -- Binoculars item
    unilib.register_craftitem("unilib:item_binoculars_ordinary", "binoculars:binoculars", mode, {
        -- From binoculars:binoculars
        description = unilib.utils.hint(S("Ordinary Binoculars"), S("use with 'Zoom' key")),
        inventory_image = "unilib_item_binoculars_ordinary.png",
        groups = {tool = 1},

        stack_max = 1,

        on_use = function(itemstack, user, pointed_thing)
            update_player_property(user)
        end,
    })
    unilib.register_craft({
        -- From binoculars:binoculars
        output = "unilib:item_binoculars_ordinary",
        recipe = {
            {"unilib:glass_obsidian", "", "unilib:glass_obsidian"},
            {"unilib:metal_bronze_ingot", "unilib:metal_bronze_ingot", "unilib:metal_bronze_ingot"},
            {"unilib:glass_obsidian", "", "unilib:glass_obsidian"},
        },
    })

end
