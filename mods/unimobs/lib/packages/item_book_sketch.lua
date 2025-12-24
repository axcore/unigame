---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unimobs
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_book_sketch = {}

local S = unimobs.intllib
local F = core.formspec_escape
local FS = function(...) return F(S(...)) end
local mode = unilib.global.imported_mod_table.unimobs.add_mode

-- Table of players who currently have the formspec open, and the itemstack they're viewing
local player_table = {}

-- Formspec layout
local closed_bg_colour = "#3A220F"
local closed_box_colour = "#F5F5DC"
local closed_text_colour = "#FFFFFF"
local closed_text_size = 25

local open_bg_colour = closed_box_colour
local open_box_colour = closed_bg_colour
local open_text_colour = "#000000"
local open_text_size = 15

-- Use the same description in the formspecs and the items themselves
local beginner_description = S("Beginner's Creature Sketchbook")
local advanced_description = S("Advanced Creature Sketchbook")

-- Optional flags
-- Flag set to true if every new sketchbook is already full of sketches. Note that a new sketchbook
--      is also full in creative mode, when unimobs.setting.enable_creative_bonus_flag is set
local auto_fill_flag = false
-- Flag set to true if the player should be allowed to sketch mobs that belong to another player;
--      false if not. The player's own mobs, and all untamed mobs, can be sketched as normal
-- (This flag might be false on a server, to prevent players from completing the sketchbook
--      "challenge" by using a set of mobs that have been assembled for that purpose by another
--      player)
local sketch_owned_mobs_flag = true

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function count_unsketched_skins(sketch_table, mob_type, advanced_flag)

    -- Count the number of skins to be displayed for the specified "mob_type"
    -- In the beginner's sketchbook, take into account only those mutations which have been
    --      sketched. In the advanced sketchbook, take all mutations into account

    local skin_init_list = unimobs.petz_global.mob_table[mob_type]["skin_init_list"]
    if advanced_flag then
        return #skin_init_list
    end

    local count = 0
    -- Mini-list in the form
    --      { skin_type, displayable_skin_name, relative_probability }
    -- ...in which "relative_probability" is 0 for mutations
    for _, mini_list in pairs(skin_init_list) do

        if mini_list[3] > 0 or sketch_table[mob_type][mini_list[1]] then
            count = count + 1
        end

    end

    return count

end

local function get_formspec(itemstack)

    local formspec

    local meta = itemstack:get_meta()
    local advanced_flag = false
    if itemstack:get_name() == "unilib:item_book_sketch_advanced" then
        advanced_flag = true
    end

    local status = meta:get_string("status")
    if status == "book_closed" then

        local sketch_table = core.deserialize(meta:get_string("sketch_table"))

        local img = "unilib_item_book_sketch_beginner.png"
        local description = beginner_description
        if advanced_flag then

            img = "unilib_item_book_sketch_advanced.png"
            description = advanced_description

        end

        formspec = "size[8,6.25]" ..
            "no_prepend[]" ..
            "bgcolor[" .. closed_bg_colour .. ";false]" ..
            "box[0,0;1.25,1.25;" .. closed_box_colour .. "]" ..
            "image[0.1,0.1;1.25,1.25;" .. img .. "]" ..
            "style_type[textarea;font_size=" .. closed_text_size .. ";bgcolor = " ..
                closed_bg_colour .. ";textcolor=" .. closed_text_colour .. "]" ..
            "textarea[2,0.375;8,1;;" .. F(description) .. ";]" ..
            "box[1.25,2;1.25,1.25;" .. closed_box_colour .. "]" ..
            "textarea[1.9,2.4;1,1;;" .. meta:get_int("mob_count") .. ";]" ..
            "textarea[3,2.4;5,1;;" .. FS("Creatures sketched") .. ";]" ..
            "box[1.25,3.5;1.25,1.25;" .. closed_box_colour .. "]" ..
            "textarea[1.9,3.9;1,1;;" ..
                (meta:get_int("skin_count") + meta:get_int("mutation_count")) .. ";]" ..
            "textarea[3,3.9;5,1;;" .. FS("Skins sketched") .. ";]"

        if unilib.utils.get_table_size(sketch_table) > 0 then
            formspec = formspec .. "button[2,5.5;4,1;open_btn;" .. FS("Open book") .. "]"
        end

        -- Show a ribbon when the challenge is completed
        -- For the beginner's book, show a silver ribbon if all normal skins have been sketched (but
        --      a gold ribbon if all mutations have been sketched too)
        -- For an advanced book, show only a gold ribbon if all normal skins and mutations have been
        --      sketched
        if meta:get_string("mob_full_flag") == "true" and
                meta:get_string("skin_full_flag") == "true" then

            local ribbon_img, ribbon_tooltip

            if meta:get_string("mutation_full_flag") == "true" then

                ribbon_img = "unilib_gui_petz_award_gold.png"
                ribbon_tooltip = unilib.utils.brackets(
                    S("Challenge complete"), S("including all mutations")
                )

            elseif not advanced_flag then

                ribbon_img = "unilib_gui_petz_award_silver.png"
                ribbon_tooltip = S("Challenge complete")

            end

            if ribbon_img then

                formspec = formspec ..
                    "image[6.5,0;1.5,1.5;" .. ribbon_img .. "]" ..
                    "tooltip[6.5,0;1.5,1.5;" .. F(ribbon_tooltip) .. "]"

            end

        end

    elseif status == "book_open" then

        local mob_str = ""
        local skin_str = ""

        local sketch_table = core.deserialize(meta:get_string("sketch_table"))
        local sorted_mob_list = core.deserialize(meta:get_string("sorted_mob_list"))
        local current_mob = meta:get_string("current_mob")
        local current_skin = meta:get_string("current_skin")
        local current_mob_index = ""
        local current_skin_index = ""

        for i, mob_type in ipairs(sorted_mob_list) do

            local mob_description = unimobs.petz_global.mob_table[mob_type]["description"]
            if mob_description ~= nil then

                if mob_str == "" then
                    mob_str = mob_description
                else
                    mob_str = mob_str .. "," .. mob_description
                end

            end

            if mob_type == current_mob then

                current_mob_index = i

                local sorted_skin_list = core.deserialize(meta:get_string("sorted_skin_list"))
                local mini_table = sketch_table[mob_type]

                for j, skin_type in ipairs(sorted_skin_list) do

                    if skin_type == current_skin then
                        current_skin_index = j
                    end

                    local skin_description = mini_table[skin_type]
                    if skin_description ~= nil then

                        if skin_str == "" then
                            skin_str = skin_description
                        else
                            skin_str = skin_str .. "," .. skin_description
                        end

                    end

                end

                -- Show un-sketched skins as "?". In the beginner's sketchbook, take into account
                --      only those mutations which have been sketched. In the advanced sketchbook,
                --      take all mutations into account
                local sketched_count = #sorted_skin_list
                local total_count = count_unsketched_skins(sketch_table, mob_type, advanced_flag)
                if sketched_count < total_count then

                    for i = (sketched_count + 1), total_count do

                        if skin_str == "" then
                            skin_str = "?"
                        else
                            skin_str = skin_str .. ",?"
                        end

                    end

                end

            end

        end

        -- Show un-sketched mobs as "?"
        local sketched_count = #sorted_mob_list
        local total_count = #unimobs.petz_global.mob_list
        if sketched_count < total_count then

            for i = (sketched_count + 1), total_count do

                if mob_str == "" then
                    mob_str = "?"
                else
                    mob_str = mob_str .. ",?"
                end

            end

        end

        -- N.B. Due to engine limitations, the "font_size" in style_type[] works, but "bgcolor"
        --      and "textcolor" do not (perhaps this will be fixed in the future)
        formspec = "size[8,6.25]" ..
            "no_prepend[]" ..
            "bgcolor[" .. open_bg_colour .. ";false]" ..
            "style_type[textlist;font_size=" .. open_text_size .. ";bgcolor=" ..
                open_box_colour .. ";textcolor=" .. open_text_colour .. "]" ..
            "textlist[0,0;2.5,2.5;mob_list;" .. mob_str .. ";" .. current_mob_index .. "]" ..
            "textlist[0,2.75;2.5,2.5;skin_list;" .. skin_str .. ";" .. current_skin_index .. "]" ..
            "box[2.9,0;4.8,5.25;" .. open_box_colour .. "]" ..
            "button[2,5.5;4,1;close_btn;" .. FS("Close book") .. "]"

        if current_mob ~= "" and current_skin ~= "" then

            local mesh_name = unimobs.petz_global.mob_table[current_mob]["mesh"]
            local img = "unilib_mob_" .. current_mob .. "_" .. current_skin .. ".png"
            formspec = formspec .. "model[3,0;6,6;fs_model;" .. mesh_name .. ";" .. img ..
                ";-15,135;false;true;]"

        end

    end

    return formspec

end

local function sort_mob_list(itemstack)

    local meta = itemstack:get_meta()

    local sketch_table = core.deserialize(meta:get_string("sketch_table"))
    local sorted_mob_list = unilib.utils.sort_table(sketch_table)
    -- "sorted_mob_list" contains a list of "mob_type" values
    -- Sort in the order of the text that's actually visible in the formspec (i.e. the mob's
    --      description, not its "mob_type")
    table.sort(sorted_mob_list, function(a, b)
        return unimobs.petz_global.mob_table[a]["description"] <
            unimobs.petz_global.mob_table[b]["description"]
    end)

    meta:set_string("sorted_mob_list", core.serialize(sorted_mob_list))

    return sorted_mob_list

end

local function sort_skin_list(itemstack, mob_type)

    local meta = itemstack:get_meta()

    local sketch_table = core.deserialize(meta:get_string("sketch_table"))
    local sorted_skin_list = unilib.utils.sort_table(sketch_table[mob_type])
    -- "sorted_skin_list" contains a list of "skin_type" values
    -- Sort in the order of the text that's actually visible in the formspec (i.e. the skin's
    --      description, not its "skin_type"
    table.sort(sorted_skin_list, function(a, b)
        return sketch_table[mob_type][a] < sketch_table[mob_type][b]
    end)

    meta:set_string("sorted_skin_list", core.serialize(sorted_skin_list))

    return sorted_skin_list

end

local function init_metadata(pname, itemstack)

    local meta = itemstack:get_meta()

    -- In creative mode, when the setting is enabled, then all sketches already exist in each
    --      new sketchbook
    local sketch_table = {}

    local mob_count = 0
    local mob_full_flag = "false"
    local skin_count = 0
    local skin_full_flag = "false"
    local mutation_count = 0
    local mutation_full_flag = "false"

    if auto_fill_flag or (
        unilib.utils.is_creative(pname) and unimobs.setting.enable_creative_bonus_flag
    ) then

        for mob_type, data_table in pairs(unimobs.petz_global.mob_table) do

            sketch_table[mob_type] = {}
            mob_count = mob_count + 1

            -- Mini-list in the form
            --      { skin_type, displayable_skin_name, relative_probability }
            -- ...in which "relative_probability" is 0 for mutations
            for _, mini_list in pairs(data_table.skin_init_list) do

                sketch_table[mob_type][mini_list[1]] = mini_list[2]
                if mini_list[3] == 0 then
                    mutation_count = mutation_count + 1
                else
                    skin_count = skin_count + 1
                end

            end

        end

        mob_full_flag = "true"
        skin_full_flag = "true"
        mutation_full_flag = "true"

    end

    -- What to show in the formspec: "book_closed" to show the front cover, "book_open" to show a
    --      list of mobs
    meta:set_string("status", "book_closed")

    -- A table of tables, containing all mobs/skins that have been "sketched". List in the form
    --      {
    --          mob = {skin_type = displayable_skin_name, skin_type = displayable_skin_name, ...}
    --          mob = {skin_type = displayable_skin_name, skin_type = displayable_skin_name, ...}
    --      }
    meta:set_string("sketch_table", core.serialize(sketch_table))

    -- A summary of the .sketch_table for quick retrieval
    meta:set_int("mob_count", mob_count)
    meta:set_string("mob_full_flag", mob_full_flag)
    -- .skin_count counts only non-mutation skins, so the actual number of skins visible in the
    --      sketchbook is .skin_count + .mutation_count
    meta:set_int("skin_count", skin_count)
    meta:set_string("skin_full_flag", skin_full_flag)
    meta:set_int("mutation_count", mutation_count)
    meta:set_string("mutation_full_flag", mutation_full_flag)

    -- A list of the keys in .sketch_table, in the order they're displayed. This list is updated
    --      every time sort_mob_list() is called
    meta:set_string("sorted_mob_list", core.serialize({}))
    -- A list of the keys in .sketch_table[current_mob_type], in the order they're displayed. This
    --      list is updated every time sort_skin_list() is called
    meta:set_string("sorted_skin_list", core.serialize({}))

    -- The mob_type of the currently-selected mob, if any
    meta:set_string("current_mob", "")
    -- The skin_type of the currently-selected skin, if any
    meta:set_string("current_skin", "")

end

local function update_sketch_counts(itemstack)

    local meta = itemstack:get_meta()

    local mob_count = meta:get_int("mob_count")
    local skin_count = meta:get_int("skin_count")
    local mutation_count = meta:get_int("mutation_count")

    local total_mob_count = 0
    local total_skin_count = 0
    local total_mutation_count = 0
    for _, data_table in pairs(unimobs.petz_global.mob_table) do

        total_mob_count = total_mob_count + 1
        -- Mini-list in the form
        --      { skin_type, displayable_skin_name, relative_probability }
        -- ...in which "relative_probability" is 0 for mutations
        for _, mini_list in pairs(data_table.skin_init_list) do

            if mini_list[3] == 0 then
                total_mutation_count = total_mutation_count + 1
            else
                total_skin_count = total_skin_count + 1
            end

        end

    end

    if mob_count < total_mob_count then
        meta:set_string("mob_full_flag", "false")
    else
        meta:set_string("mob_full_flag", "true")
    end

    if skin_count < total_skin_count then
        meta:set_string("skin_full_flag", "false")
    else
        meta:set_string("skin_full_flag", "true")
    end

    if mutation_count < total_mutation_count then
        meta:set_string("mutation_full_flag", "false")
    else
        meta:set_string("mutation_full_flag", "true")
    end

end

local function add_sketch(itemstack, luaent)

    local meta = itemstack:get_meta()

    -- Import metadata
    local sketch_table = core.deserialize(meta:get_string("sketch_table"))
    local mob_type = luaent.mob_type
    local skin_init_list =
            unimobs.petz_global.mob_table[luaent.mob_type]["skin_init_list"]
    if not skin_init_list then
        return
    end

    -- Mini-list in the form
    --      { skin_type, displayable_skin_name, relative_probability }
    -- ...in which "relative_probability" is 0 for mutations
    local mini_list = skin_init_list[luaent.mob_texture_num]
    if not mini_list then
        return
    end

    local skin_type = mini_list[1]
    local displayable_skin_name = mini_list[2]
    local relative_probability = mini_list[3]

    -- Since the sketchbook was opened by right-clicking a mob, skip the cover, and go straight to
    --      the page showing that mob
    meta:set_string("status", "book_open")
    meta:set_string("current_mob", mob_type)
    meta:set_string("current_skin", skin_type)

    -- Check that the mob/skin combination hasn't already been added to the sketchbook
    if sketch_table[mob_type] ~= nil and sketch_table[mob_type][skin_type] ~= nil then

        -- No sketch to add, but sort the existing list of skins so they're ready to be displayed in
        --      the formspec
        sort_skin_list(itemstack, mob_type)
        return

    end

    -- Add the sketch and update metadata
    if sketch_table[mob_type] == nil then

        sketch_table[mob_type] = {}
        meta:set_int("mob_count", meta:get_int("mob_count") + 1)

    end

    sketch_table[mob_type][skin_type] = displayable_skin_name

    meta:set_string("sketch_table", core.serialize(sketch_table))
    if relative_probability == 0 then
        meta:set_int("mutation_count", meta:get_int("mutation_count") + 1)
    else
        meta:set_int("skin_count", meta:get_int("skin_count") + 1)
    end

    sort_skin_list(itemstack, mob_type)

end

local function use_tool(user, itemstack, luaent)

    -- Called when the player right-clicks a mob while wielding this sketchbook
    -- "Sketches" from the mob by storing values in the sketchbook's metadata, and then opens the
    --      formspec so the user can see the results

    -- Basic checks. This sketchbook will work only on mobs compatible with the Petz API
    if not luaent or not unimobs.mobkit_api.is_object_alive(luaent.object) then
        return
    end

    -- Depending on the flags set above, the sketchbook can't be used with mobs owned by other
    --      players
    local pname = user:get_player_name()
    if not sketch_owned_mobs_flag and luaent.owner ~= nil and luaent.owner ~= pname then
        return
    end

    -- Initialise the sketchbook's metadata, if opening for the first time
    local meta = itemstack:get_meta()
    if meta:get_string("status") == "" then
        init_metadata(pname, itemstack)
    end

    -- Add the sketch to the sketchbook, if it's not already there
    add_sketch(itemstack, luaent)

    -- Check whether the book is full, or not (must be done every time, in case mobs/skins have been
    --      added/removed since the last restart)
    update_sketch_counts(itemstack)

    -- Must also re-sort the list of mobs, in case any packages have been added/removed since the
    --      last restart
    sort_mob_list(itemstack)

    -- Open the formspec
    player_table[pname] = itemstack

    core.show_formspec(
        pname,
        "unilib:formspec_item_book_sketch",
        get_formspec(player_table[pname])
    )

end

local function consult_tool(user, itemstack)

    -- Called when the player right-clicks something other than a mob while wielding this sketchbook
    -- Display sketches already made

    -- Initialise the sketchbook's metadata, if opening for the first time
    local meta = itemstack:get_meta()
    local pname = user:get_player_name()

    if meta:get_string("status") == "" then
        init_metadata(pname, itemstack)
    end

    -- Check whether the book is full, or not (must be done every time, in case mobs/skins have been
    --      added/removed since the last restart)
    update_sketch_counts(itemstack)

    -- Must also re-sort the list of mobs, in case any packages have been added/removed since the
    --      last restart
    sort_mob_list(itemstack)

    -- Open the formspec
    player_table[pname] = itemstack

    core.show_formspec(
        pname,
        "unilib:formspec_item_book_sketch",
        get_formspec(player_table[pname])
    )

end

local function register_sketchbook(part_name, description, recipe_table)

    unilib.register_craftitem("unilib:item_book_sketch_" .. part_name, nil, mode, {
        description = unilib.utils.hint(description, S("right-click creatures")),
        inventory_image = "unilib_item_book_sketch_".. part_name .. ".png",
        groups = {book = 1, flammable = 3},

        -- The craftitem has metadata, so a stack limit is required
        stack_max = 1,

        on_place = function(itemstack, user, pointed_thing)

            -- This callback handles right-clicking nodes, etc. Right-clicking a mob is handled by
            --      the override callback specified in the .exec() function
            if user ~= nil then

                -- Re-display data from the previous sample
                consult_tool(user, itemstack)

            end

            return itemstack

        end,
    })
    unilib.register_craft({
        type = "shaped",
        output = "unilib:item_book_sketch_name",
        recipe = recipe_table,
    })

end

local function on_rightclick_mob_callback(self, clicker, wielded_item, wielded_name, is_owner_flag)

    -- Original to unimobs

    if not self.petz_compat_flag then

        -- This override was not applied; apply the standard behaviour instead
        return false

    end

    use_tool(clicker, wielded_item, self)
    -- Preserve the itemstack's metadata
    clicker:set_wielded_item(wielded_item)

    -- Do not apply the standard behaviour
    return true

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_book_sketch.init()

    return {
        description = "Creature sketchbook",
        notes = "Right-click a mob while wielding one of these books, in order to make a" ..
                " \"sketch\" of it, which is then visible in the book. The aim of the challenge" ..
                " is to collect sketches of all available mobs and skin colours. There are two" ..
                " sketchbooks available, for beginner and advanced artists. In both books," ..
                " missing creatures and skins are shown as ?, but in the beginner's sketchbook," ..
                " ? is not shown for mutations. Note that any player can contribute to sketches" ..
                " in a sketchbook. Note also that the mob need not be owned by the player. The" ..
                " default behaviour of the sketchbooks can be changed by tweaking the flags" ..
                " in the package code",
        depends = {"dye_basic", "item_paper_ordinary", "organ_leather_normal"},
    }

end

function unilib.pkg.item_book_sketch.exec()

    local c_leather = "unilib:organ_leather_normal"
    local c_paper = "unilib:item_paper_ordinary"

    register_sketchbook(
        -- Original to unimobs, creates unilib:item_book_sketch_beginner
        "beginner",
        beginner_description,
        {
            {c_leather, c_paper, c_paper},
            {c_leather, "group:dye", c_paper},
            {c_leather, c_paper, c_paper},
        }
    )

    register_sketchbook(
        -- Original to unimobs, creates unilib:item_book_sketch_advanced
        "advanced",
        advanced_description,
        {
            {c_leather, c_paper, c_paper},
            {c_leather, "group:dye", c_paper},
            {c_leather, c_paper, c_paper},
        }
    )

    core.register_on_player_receive_fields(function(player, formname, fields)

        -- The player has interacted with our formspec
        if not formname or
                formname ~= "unilib:formspec_item_book_sketch" or
                not fields then
            return false
        end

        local pname = player:get_player_name()
        local itemstack = player_table[pname]
        local meta = itemstack:get_meta()

        if fields.mob_list then

            local event = core.explode_textlist_event(fields.mob_list)
            local index = event.index

            local sorted_mob_list = core.deserialize(meta:get_string("sorted_mob_list"))
            local mob_type = sorted_mob_list[index]
            if mob_type ~= nil then

                local sorted_skin_list = sort_skin_list(itemstack, mob_type)

                meta:set_string("current_mob", mob_type)
                meta:set_string("current_skin", sorted_skin_list[1])

                core.show_formspec(
                    pname,
                    "unilib:formspec_item_book_sketch",
                    get_formspec(itemstack)
                )

            end

        elseif fields.skin_list then

            local event = core.explode_textlist_event(fields.skin_list)
            local index = event.index

            local sorted_skin_list = core.deserialize(meta:get_string("sorted_skin_list"))
            local skin_type = sorted_skin_list[index]
            if skin_type ~= nil then

                meta:set_string("current_skin", skin_type)

                core.show_formspec(
                    pname,
                    "unilib:formspec_item_book_sketch",
                    get_formspec(itemstack)
                )

            end

        elseif fields.open_btn or fields.close_btn then

            if player_table[pname] then

                if fields.open_btn then
                    meta:set_string("status", "book_open")
                else
                    meta:set_string("status", "book_closed")
                end

                meta:set_string("current_mob", "")
                meta:set_string("current_skin", "")

                core.show_formspec(
                    pname,
                    "unilib:formspec_item_book_sketch",
                    get_formspec(itemstack)
                )

            end

        elseif fields.quit then

            player_table[pname] = nil

            -- Reset metadata so that, the next time the book is used, the cover is visible
            meta:set_string("status", "book_closed")
            meta:set_string("current_mob", "")
            meta:set_string("current_skin", "")
            player:set_wielded_item(itemstack)

        end

        return true

    end)

    core.register_on_leaveplayer(function(player)
        player_table[player:get_player_name()] = nil
    end)

    -- Override the standard behaviour when a mob is right-clicked while wielding this item
    unimobs.petz_api.register_rightclick_override(
        "unilib:item_book_sketch_beginner", on_rightclick_mob_callback
    )
    unimobs.petz_api.register_rightclick_override(
        "unilib:item_book_sketch_advanced", on_rightclick_mob_callback
    )

end
