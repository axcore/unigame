---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unimobs
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_book_bestiary = {}

local S = unimobs.intllib
local F = core.formspec_escape
local FS = function(...) return F(S(...)) end
local mode = unilib.global.imported_mod_table.unimobs.add_mode

local bg_colour = "#F5F5DC"
local box_colour = "#3A220F"
local text_colour = "#000000"

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_gender_str(self, x, y)

    local img, msg

    if self.is_male_flag then

        img = "unilib_gui_petz_male.png"
        msg = FS("Male")

    else

        img = "unilib_gui_petz_female.png"
        msg = FS("Female")

    end

    return "image[" .. x .. "," .. y .. ";1,1;" .. img .. "]" ..
        "tooltip[" .. x .. "," .. y .. ";1,1;" .. msg .. "]"

end

local function get_growth_str(self, x, y)

    local img, msg

    if not self.is_baby_flag then

        img = "unilib_gui_petz_adult.png"
        msg = FS("Adult")

    else

        img = "unilib_gui_petz_baby.png"
        msg = FS("Baby")

    end

    return "image[" .. x .. "," .. y .. ";1,1;" .. img .. "]" ..
        "tooltip[" .. x .. "," .. y .. ";1,1;" .. msg .. "]"

end

local function get_formspec(self)

    local spawnegg_img = "unilib_spawnegg_" .. self.mob_type .. ".png"
    local health_msg = self.hp .. " / " .. self.max_hp

    local formspec = "size[6,4.5]" ..
        "no_prepend[]" ..
        "bgcolor[" .. bg_colour .. ";false]" ..
        "box[0,0;0.85,1;" .. box_colour .. "]" ..
        "image[0.025,0.075;1,1;" .. spawnegg_img .. "]" ..
        get_gender_str(self, 4, 0) ..
        get_growth_str(self, 5, 0) ..
        "box[0.25,1.25;5.35,3.35;" .. box_colour .. "]" ..
        "style_type[textarea;textcolor=" .. text_colour .. "]" ..
        "textarea[1.5,0.25;4,1;;" .. FS("Bestiary") .. ";]" ..
        "image[0.5,1.5;1,1;unilib_gui_petz_mob_type.png]" ..
        "tooltip[0.5,1.5;1,1;" .. FS("Description") .. "]" ..
        "textarea[1.75,1.65;4,1;;" .. (self.description or self.mob_type) .. ";]" ..
        "image[0.5,2.5;1,1;unilib_gui_petz_skin.png]" ..
        "tooltip[0.5,2.5;1,1;" .. FS("Colour") .. "]" ..
        "textarea[1.75,2.65;4,1;;" .. unimobs.petz_api.get_skin_description(self) .. ";]" ..
        "image[0.5,3.5;1,1;unilib_gui_petz_health.png]" ..
        "tooltip[0.5,3.5;1,1;" .. FS("Health") .. "]" ..
        "textarea[1.75,3.65;4,1;;" .. health_msg .. ";]"

    return formspec

end

local function on_rightclick_mob_callback(self, clicker, wielded_item, wielded_name, is_owner_flag)

    -- Original to unimobs

    if not self.petz_compat_flag then

        -- This override was not applied; apply the standard behaviour instead
        return false

    end

    core.show_formspec(
        clicker:get_player_name(),
        "unilib:formspec_item_book_bestiary",
        get_formspec(self)
    )

    -- Do not apply the standard behaviour
    return true

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_book_bestiary.init()

    return {
        description = "Bestiary",
        notes = "Right-click a mob while wielding this book, in order to see basic information" ..
                " about the mob. More detailed information about tamed mobs can be seen by" ..
                " right-clicking them without a book",
        depends = {"item_paper_ordinary", "organ_leather_normal"},
    }

end

function unilib.pkg.item_book_bestiary.exec()

    local c_leather = "unilib:organ_leather_normal"
    local c_paper = "unilib:item_paper_ordinary"

    unilib.register_craftitem("unilib:item_book_bestiary", nil, mode, {
        -- Original to unimobs
        description = unilib.utils.hint(S("Bestiary"), S("right-click mobs")),
        inventory_image = "unilib_item_book_bestiary.png",
        groups = {book = 1, flammable = 3},
    })
    unilib.register_craft({
        -- Original to unimobs
        type = "shaped",
        output = "unilib:item_book_bestiary",
        recipe = {
            {c_leather, c_paper, c_paper},
            {c_leather, c_paper, c_paper},
            {c_leather, c_paper, c_paper},
        },
    })

    -- Override the standard behaviour when a mob is right-clicked while wielding this item
    unimobs.petz_api.register_rightclick_override(
        "unilib:item_book_bestiary", on_rightclick_mob_callback
    )

end
