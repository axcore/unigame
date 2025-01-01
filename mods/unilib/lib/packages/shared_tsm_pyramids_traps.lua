---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    tsm_pyramids
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_tsm_pyramids_traps = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.tsm_pyramids.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function create_real_trap(
    cracked_name, crumbling_name, cracked_description, crumbling_description
)
    -- Called to convert decorative traps into actual traps (when
    --      unilib.setting.tsm_pyramids_real_trap_flag is true)
    unilib.override_item(cracked_name, {
        description = cracked_description,

        on_construct = function(pos)
            core.get_node_timer(pos):start(0.1)
        end,

        on_timer = function(pos, elapsed)

            local n = core.get_node(pos)
            if not (n and n.name) then
                return true
            end

            -- Drop trap stone when player is nearby
            local objs = core.get_objects_inside_radius(pos, 2)
            for i, obj in pairs(objs) do

                if obj:is_player() then

                    if n.name == cracked_name then

                        -- 70% chance to ignore player to make the time of falling less predictable
                        if math.random(1, 10) >= 3 then
                            return true
                        end

                        core.set_node(pos, {name = crumbling_name})
                        core.check_for_falling(pos)
                        return true

                    end

                end

            end

            return true

        end,
    })

    unilib.override_item(crumbling_name, {
        description = crumbling_description,
        groups = {cracky = 3, crumbly = 3, falling_node = 1, not_in_creative_inventory = 1},
    })

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_tsm_pyramids_traps.do_traps(
    base, ingredient, cracked_orig_name, crumbling_orig_name
)
    -- Create a pair of trap stones, based on the node whose name is "base" (e.g.
    --      "unilib:stone_sandstone_ordinary"), with craft recipes using "ingredient" (e.g.
    --      "unilib:sand_ordinary)
    -- "base" and "ingredient" should be different nodes, as the craft recipes use several
    --      "ingredients" to create one engraved "base"

    local base_def_table = core.registered_nodes[base]
    if base_def_table == nil then
        return
    end

    local base_img = base_def_table.tiles[1]

    local cracked_description = unilib.utils.brackets(base_def_table.description, S("Cracked"))
    local crumbling_description = unilib.utils.brackets(base_def_table.description, S("Crumbling"))

    unilib.register_node(base .. "_trap_cracked", cracked_orig_name, mode, {
        -- From tsm_pyramids:trap
        description = cracked_description,
        tiles = {base_img .. "^unilib_stone_cracked_overlay.png"},
        groups = {cracky = 3, crumbly = 3},
        sounds = unilib.global.sound_table.stone,

        drop = {
            items = {
                {items = {ingredient}, rarity = 1},
                {items = {ingredient}, rarity = 2},
            },
        },
        is_ground_content = false,
    })
    unilib.register_craft({
        -- Original to unilib
        output = base .. "_trap_cracked",
        recipe = {
            {ingredient, ingredient, ingredient},
            {ingredient, "group:pickaxe", ingredient},
            {ingredient, ingredient, ingredient},
        },
    })

    unilib.register_node(base .. "_trap_crumbling", crumbling_orig_name, mode, {
        -- From tsm_pyramids:trap_2
        description = crumbling_description,
        tiles = {base_img .. "^unilib_stone_crumbling_overlay.png"},
        groups = {cracky = 3, crumbly = 3},
        sounds = unilib.global.sound_table.stone,

        drop = {
            items = {
                {items = {ingredient}, rarity = 1},
                {items = {ingredient}, rarity = 2},
            },
        },
        is_ground_content = false,
    })

    -- N.B. Unless the Minetest setting permits, these "trap" stones are purely decorative...
    if unilib.setting.tsm_pyramids_real_trap_flag then

        create_real_trap(
            base .. "_trap_cracked",
            base .. "_trap_crumbling",
            cracked_description,
            crumbling_description
        )

    else

        -- ...in which case, the decorative "crumbling" variant needs a craft recipe
        unilib.register_craft({
            -- Original to unilib
            output = base .. "_trap_crumbling",
            recipe = {
                {ingredient, ingredient, "group:pickaxe"},
                {ingredient, ingredient, ingredient},
                {"group:pickaxe", ingredient, ingredient},
            },
        })

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_tsm_pyramids_traps.init()

    return {
        description = "Shared functions for sandstone traps (from tsm_pyramids mod)",
        suggested = {
            "tool_pick_wood",                   -- group:pickaxe
        },
    }

end
