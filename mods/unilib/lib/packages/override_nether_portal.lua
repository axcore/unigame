---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nether
-- Code:    ISC
-- Media:   CC-BY-SA-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.override_nether_portal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.nether.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.override_nether_portal.init()

    return {
        description = "Defines a nether portal constructed from unilib obsidian/mese (because" ..
                " materials from \"default\" may not be available to construct the portal" ..
                " provided by the original mod itself",
        notes = "Does nothing if the \"nether\" mod's nether realm is not enabled",
        mod_depends = "nether",
        depends = {"mineral_mese", "stone_obsidian"},
    }

end

function unilib.pkg.override_nether_portal.exec()

    if not nether.NETHER_REALM_ENABLED then
        return
    end

    -- Portals are ignited by right-clicking with a mese crystal fragment
    nether.register_portal_ignition_item(
        "unilib:mineral_mese_crystal_fragment",
        {name = "nether_portal_ignition_failure", gain = 0.3}
    )

    -- Use the Portal API to add a portal type which goes to the Nether
    nether.register_portal("nether_portal_unilib", {
        shape = nether.PortalShape_Traditional,
        frame_node_name = "unilib:stone_obsidian",
        wormhole_node_color = 0, -- 0 is magenta
        title = S("Nether Portal"),
        book_of_portals_pagetext = S(
            "Construction requires 14 blocks of obsidian, which we found deep underground where" ..
            " water had solidified molten rock. The finished frame is four blocks wide, five" ..
            " blocks high, and stands vertically, like a doorway.\n\n" ..
            "This opens to a truly hellish place, though for small mercies the air there is" ..
            " still breathable. There is an intriguing dimensional mismatch happening between" ..
            " this realm and ours, as after opening the second portal into it we observed that" ..
            " 10 strides taken in the Nether appear to be an equivalent of @1 in the natural" ..
            " world.\n\n" ..
            "The expedition parties have found no diamonds or gold, and after an experienced" ..
            " search party failed to return from the trail of a missing expedition party, I must" ..
            " conclude this is a dangerous place.",
            10 * nether.FASTTRAVEL_FACTOR
        ),

        find_realm_anchorPos = function(surface_anchorPos, player_name)

            -- Divide x and z by a factor of 8 to implement Nether fast-travel
            local destination_pos = vector.divide(surface_anchorPos, nether.FASTTRAVEL_FACTOR)
            destination_pos.x = math.floor(0.5 + destination_pos.x)
            destination_pos.z = math.floor(0.5 + destination_pos.z)
            -- (Temp value so find_nearest_working_portal() returns nether portals)
            destination_pos.y = nether.DEPTH_CEILING - 1

            -- A y_factor of 0 makes the search ignore the altitude of the portals (as long as they
            --      are in the Nether)
            local existing_portal_location, existing_portal_orientation =
                    nether.find_nearest_working_portal(
                        "nether_portal_unilib", destination_pos, 8, 0
                    )

            if existing_portal_location ~= nil then

                return existing_portal_location, existing_portal_orientation

            else

                -- Search starting altitude
                local start_y = nether.DEPTH_CEILING - math.random(500, 1500)
                destination_pos.y = nether.find_nether_ground_y(
                    destination_pos.x, destination_pos.z, start_y, player_name
                )

                return destination_pos

            end

        end,

        find_surface_anchorPos = function(realm_anchorPos, player_name)

            -- A portal definition doesn't normally need to provide a find_surface_anchorPos()
            --      function, since find_surface_target_y() will be used by default, but Nether
            --      portals also scale position to create fast-travel
            -- Defining a custom function also means we can look for existing nearby portals

            -- Multiply x and z by a factor of 8 to implement Nether fast-travel
            local destination_pos = vector.multiply(realm_anchorPos, nether.FASTTRAVEL_FACTOR)
            -- (Clip to world boundaries)
            destination_pos.x = math.min(30900, math.max(-30900, destination_pos.x))
            destination_pos.z = math.min(30900, math.max(-30900, destination_pos.z))
            -- (Temp value so find_nearest_working_portal() doesn't return nether portals)
            destination_pos.y = nether.DEPTH_CEILING + 1

            -- A y_factor of 0 makes the search ignore the altitude of the portals (as long as they
            --      are outside the Nether)
            local existing_portal_location, existing_portal_orientation =
                nether.find_nearest_working_portal(
                    "nether_portal_unilib", destination_pos, 8 * nether.FASTTRAVEL_FACTOR, 0
                )

            if existing_portal_location ~= nil then

                return existing_portal_location, existing_portal_orientation

            else

                destination_pos.y = nether.find_surface_target_y(
                    destination_pos.x, destination_pos.z, "nether_portal_unilib", player_name
                )

                return destination_pos

            end

        end,

        is_within_realm = function(pos)

            -- Return true if pos is inside the Nether
            return pos.y < nether.DEPTH_CEILING and pos.y > nether.DEPTH_FLOOR

        end,

        on_ignite = function(portalDef, anchorPos, orientation)

            -- make some sparks fly
            local p1, p2 = portalDef.shape:get_p1_and_p2_from_anchorPos(anchorPos, orientation)
            local pos = vector.divide(vector.add(p1, p2), 2)

            local textureName = portalDef.particle_texture
            if type(textureName) == "table" then
                textureName = textureName.name
            end

            core.add_particlespawner({
                amount = 110,
                time   = 0.1,
                texture = textureName .. "^[colorize:#F4F:alpha",

                maxacc = {x =  0, y =  0, z =  0},
                minacc = {x =  0, y =  0, z =  0},
                maxexptime = 0.5,
                minexptime = 0.1,
                maxpos = {x = pos.x + 0.5, y = pos.y + 1.2, z = pos.z + 0.5},
                minpos = {x = pos.x - 0.5, y = pos.y - 1.2, z = pos.z - 0.5},
                maxsize = 0.8 * portalDef.particle_texture_scale,
                minsize = 0.2 * portalDef.particle_texture_scale,
                maxvel = {x =  5, y =  1, z =  5},
                minvel = {x = -5, y = -1, z = -5},

                animation = portalDef.particle_texture_animation,
                collisiondetection = false,
                glow = 8,
            })

        end

    })

end
