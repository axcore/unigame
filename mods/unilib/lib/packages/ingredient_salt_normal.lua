---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_salt_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_salt_normal.init()

    return {
        description = "Normal salt",
        depends = "utensil_mortar_pestle",
        at_least_one = {"liquid_water_ordinary", "liquid_water_river"},
    }

end

function unilib.pkg.ingredient_salt_normal.exec()

    unilib.register_node("unilib:ingredient_salt_normal", "farming:salt", mode, {
        -- From farming:salt
        description = S("Normal Salt"),
        tiles = {"unilib_ingredient_salt_normal.png"},
        groups = {attached_node = 1, dig_immediate = 3, food_salt = 1, vessel = 1},
        sounds = unilib.global.sound_table.node,

        drawtype = "plantlike",
        inventory_image = "unilib_ingredient_salt_normal.png",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
        },
        visual_scale = 0.80,
        wield_image = "unilib_ingredient_salt_normal.png",

        dropped_step = function(self, pos, dtime)

            -- Special function to make salt crystals form inside water
            self.ctimer = (self.ctimer or 0) + dtime
            if self.ctimer < 15.0 then
                return
            end

            self.ctimer = 0

            local needed

            if self.node_inside and
                    self.node_inside.name == "unilib:liquid_water_ordinary_source" then

                needed = 8

            elseif self.node_inside and
                    self.node_inside.name == "unilib:liquid_water_river_source" then

                needed = 9

            end

            if not needed then
                return
            end

            local objs = core.get_objects_inside_radius(pos, 0.5)

            if not objs or #objs ~= 1 then
                return
            end

            local salt, ent = nil, nil

            for k, obj in pairs(objs) do

                ent = obj:get_luaentity()

                if ent and
                        ent.name == "__builtin:item" and
                        ent.itemstring == "unilib:ingredient_salt_normal " .. needed then

                    obj:remove()
                    core.add_item(pos, "unilib:ingredient_salt_crystal")
                    -- Return with no further action
                    return false

                end

            end

        end
    })
    unilib.register_craft({
        -- From farming:salt
        output = "unilib:ingredient_salt_normal 9",
        recipe = {
            {"unilib:ingredient_salt_crystal", "unilib:utensil_mortar_pestle"},
        },
        replacements = {
            {"unilib:utensil_mortar_pestle", "unilib:utensil_mortar_pestle"},
        },
    })

    unilib.register_node("unilib:ingredient_salt_crystal", "farming:salt_crystal", mode, {
        -- From farming:salt_crystal
        description = S("Salt Crystal"),
        tiles = {"unilib_ingredient_salt_crystal.png"},
        groups = {attached_node = 1, dig_immediate = 3},
        sounds = unilib.global.sound_table.node,

        drawtype = "plantlike",
        inventory_image = "unilib_ingredient_salt_crystal.png",
        light_source = 1,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
        },
        visual_scale = 0.80,
        wield_image = "unilib_ingredient_salt_crystal.png",
    })
    unilib.register_craft_3x3({
        -- From farming:salt_crystal
        output = "unilib:ingredient_salt_crystal",
        ingredient = "unilib:ingredient_salt_normal",
    })

end

function unilib.pkg.ingredient_salt_normal.post()

    -- N.B. As this is salt, only use ordinary water as an ingredient

    for bucket_type, _ in pairs(unilib.global.generic_bucket_table) do

        local c_water_bucket = "unilib:" .. bucket_type .. "_with_water_ordinary"
        local c_empty_bucket = "unilib:" .. bucket_type .. "_empty"

        unilib.register_craft({
            -- From farming:salt
            type = "cooking",
            output = "unilib:ingredient_salt_normal",
            recipe = c_water_bucket,
            cooktime = 15,
            replacements = {
                {c_water_bucket, c_empty_bucket},
            }
        })

    end

end
