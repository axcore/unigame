---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xocean
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_kelp_dried = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xocean.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_kelp_dried.init()

    return {
        description = "Dried kelp",
        at_least_one = {
            "plant_kelp_green",
            "plant_kelp_ordinary",
            "plant_kelp_ordinary_gaia",
            "plant_kelp_yellow",
        },
    }

end

function unilib.pkg.plant_kelp_dried.exec()

    -- Override code for the three kelps used as ingredients for making dried kelp: set up new
    --      inventory textures to match the dried kelp texture below, remove the "flammable" group
    --      so the ingredients can be cooked in a furnace, and modify the thick variants to drop
    --      the normal variants (since the normal variant's texture looks like a leaf), adding
    --      the "not_in_creative_inventory" group to compensate
    local eat_name

    if unilib.global.pkg_executed_table["plant_kelp_ordinary"] ~= nil then

        eat_name = "unilib:plant_kelp_ordinary"
        unilib.override_item("unilib:plant_kelp_ordinary", {
            inventory_image = "unilib_plant_kelp_ordinary_inv.png",
            wield_image = "unilib_plant_kelp_ordinary_inv.png",
        })

    elseif unilib.global.pkg_executed_table["plant_kelp_ordinary_gaia"] ~= nil then

        eat_name = "unilib:plant_kelp_ordinary"
        unilib.override_item("unilib:plant_kelp_ordinary", {
            groups = {attached_node = 1, not_in_creative_inventory = 1, sea = 1, snappy = 3},
            inventory_image = "unilib_plant_kelp_ordinary_inv.png",
            wield_image = "unilib_plant_kelp_ordinary_inv.png",
        })

        unilib.override_item("unilib:plant_kelp_ordinary_thick", {
            groups = {attached_node = 1, not_in_creative_inventory = 1, sea = 1, snappy = 3},
            drop = "unilib:plant_kelp_ordinary",
        })

    end

    if unilib.global.pkg_executed_table["plant_kelp_green"] ~= nil then

        if eat_name == nil then
            eat_name = "unilib:plant_kelp_green"
        end

        unilib.override_item("unilib:plant_kelp_green", {
            groups = {attached_node = 1, not_in_creative_inventory = 1, sea = 1, snappy = 3},
            inventory_image = "unilib_plant_kelp_green_inv.png",
            wield_image = "unilib_plant_kelp_green_inv.png",
        })

        unilib.override_item("unilib:plant_kelp_green", {
            groups = {attached_node = 1, not_in_creative_inventory = 1, sea = 1, snappy = 3},
            drop = "unilib:plant_kelp_green",
        })

    end

    if unilib.global.pkg_executed_table["plant_kelp_yellow"] ~= nil then

        if eat_name == nil then
            eat_name = "unilib:plant_kelp_yellow"
        end

        unilib.override_item("unilib:plant_kelp_yellow", {
            groups = {attached_node = 1, not_in_creative_inventory = 1, sea = 1, snappy = 3},
            inventory_image = "unilib_plant_kelp_yellow_inv.png",
            wield_image = "unilib_plant_kelp_yellow_inv.png",
        })

        unilib.override_item("unilib:plant_kelp_yellow", {
            groups = {attached_node = 1, not_in_creative_inventory = 1, sea = 1, snappy = 3},
            drop = "unilib:plant_kelp_yellow",
        })

    end

    unilib.register_craftitem("unilib:plant_kelp_dried", "xocean:kelp", mode, {
        -- From xocean:kelp
        description = S("Dried Kelp"),
        inventory_image = "unilib_plant_kelp_dried.png",
        -- N.B. No groups in original code
        groups = {food_kelp = 1},

        on_use = unilib.cuisine.eat_on_use(eat_name, 1),
    })
    if unilib.global.pkg_executed_table["plant_kelp_ordinary"] ~= nil or
            unilib.global.pkg_executed_table["plant_kelp_ordinary_gaia"] ~= nil then

        unilib.register_craft({
            -- From xocean:kelp
            type = "cooking",
            output = "unilib:plant_kelp_dried",
            recipe = "unilib:plant_kelp_ordinary",
        })

    end
    if unilib.global.pkg_executed_table["plant_kelp_green"] ~= nil then

        unilib.register_craft({
            -- From xocean:kelp
            type = "cooking",
            output = "unilib:plant_kelp_dried",
            recipe = "unilib:plant_kelp_green",
        })

    end
    if unilib.global.pkg_executed_table["plant_kelp_yellow"] ~= nil then

        unilib.register_craft({
            -- From xocean:kelp
            type = "cooking",
            output = "unilib:plant_kelp_dried",
            recipe = "unilib:plant_kelp_yellow",
        })

    end

    unilib.register_node("unilib:plant_kelp_dried_block", "xocean:kelp_block", mode, {
        -- From xocean:kelp_block
        description = S("Dried Kelp Block"),
        tiles = {"unilib_plant_kelp_dried_block.png"},
        groups = {snappy = 3},
        -- (no sounds)

        drop= "unilib:plant_kelp_dried 9",
    })
    unilib.register_craft_3x3({
        -- From xocean:kelp_block
        output = "unilib:plant_kelp_dried_block",
        ingredient = "unilib:plant_kelp_dried",
    })

end
