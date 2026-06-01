# unimobs API

This document describes how to write new mobs, new behaviours and new logic functions (brains). For general play, see the README.

We assume that your are familiar with the following topics:

- The basics of writing code in [Lua](https://www.lua.org/)
- The basics of writing [Minetest](https://www.luanti.org/) mods
- How [unilib](https://github.com/axcore/unilib) remixes and packages work

# 1. Introduction

## 1.1 unilib basics

**unimobs** is an expansion pack for the [unilib](https://github.com/axcore/unilib) mod. This means that most **unimobs** code is executed when **unilib** is loaded, not when **unimobs** is loaded.

In practical terms, when we register mobs, nodes, craftitems and tools, we use the **unilib** namespace, not the **unimobs** namespace:

        unilib:food_cheese_normal
        unilib:misc_bowl_pet
        unilib:mob_bear_polar

In almost all cases, we use **unilib** functions like **unilib.register_node()**, although it's acceptable to use the equivalent engine functions, **minetest.register_node()** and **core.register_node()**, if you need to.

## 1.2 Naming conventions

In both **unilib** and **unimobs**, variables (including mob properties) have names that identify their type, for example:

        is_monster_flag (a boolean variable)
        drop_list (a table whose keys are a sequential list of numeric values)
        data_table (a table whose keys are not necessarily numeric nor sequential)

A small number of variables and mob properties do not follow this convention (usually for compatibility with the **Minetest** engine or **minetest_game**).

## 1.3 mob basics

All mobs created by **unimobs** have a consistent naming style:

        unilib:mob_bear_polar
        unilib:mob_cat_normal
        unilib:mob_chicken_rooster

Internally, the strings **bear_polar**, **cat_normal** and **chicken_rooster** are used to keep track of different kinds of mobs. The internal name is called the **mob type**. The name of the mob entity can *always* be found by adding the mob type to the end of the string "unilib:mob_".

Note that most mobs have multiple skins; for example, cats have around 20 of them. All of these cat variants are represented by a single entity, **unilib:mob_cat_normal**.

A few creatures are represented by multiple entities. These are the code examples to follow, if you want to create something similar:

- Elephants have a separate male and female form
- Chickens have a separate male (rooster), female (hen) and baby (chicklet) form

Ants and bees also have several different forms. Note that ants, bees and elephants are each defined by a single package, but that different forms of chicken have their own packages. This is mostly for convenience; there is no practical reason why the chicken packages could not be combined into a single package, if that were desirable.

An API function, **unimobs.petz_api.register_standard_mob()**, exists for registering new mobs in a standard way. As in the original code, most mobs don't use this function, instead registering the entity directly with a **unilib.register_entity()** call. You are free to use either paradigm.

## 1.4 Original mods

**unimobs** includes material from several mods, many of which are no longer being maintained by their original authors. A list of them can be found in the README; here, we discuss the most important ones.

At its core, **unimobs** is a rewrite of the [mobkit mod](https://github.com/mt-mods/mobkit) and the [petz modpack](https://github.com/yl-whosit/petz/).

### 1.4.1 mobkit mod

**mobkit** did not itself provide any mobs; instead, it provided a set of tools for anyone who wants to write their own mobs. Those tools were used to specify each mob's behaviour - roaming around the world, fleeing from predators, and so on.

Most of the **mobkit** API, as well as all of its logic and behaviour functions, has been imported into **unimobs**.

There have been a number of name changes, and a few functions now have different argument lists. Anyone who has experience in working with the **mobkit** API should find the equivalent **unimobs** API very familiar.

### 1.4.2 kitz mod (from the petz modpack)

**kitz** should be considered an extension to **mobkit**, itself incorporating all of the original **mobkit** code (with a few tweaks made here and there), but adding a number of new API, logic and behaviour functions.

Most of the new material has been imported into **unimobs**. Some of the new features have been re-written to a greater or lesser extent.

### 1.4.3 petz mod (from the petz modpack)

(The mod and its parent modpack have the same name.)

**petz** defines almost 50 mobs, numerous new craftitems and tools, as well as a number of new logic and behaviour functions. It uses the **kitz** API exclusively, never calling anything in **mobkit**.

Most of the material from **petz** has been imported into **unimobs**, although it has been extensively re-written, embellished and, in some cases, entirely replaced.

## 1.5 Design considerations

The mobs in **petz** had a number of features that were entirely missing from **mobkit** - for example, they could be fed, tamed or encouraged to produce babies, all in a standard way.

When creating new mobs, your first choice will be this:

- Do you want to make use of the **petz** API for feeding, taming, breeding and so on?
- Do you want to implement those features yourself, in a non-standard way (or just omit them?)

When a mob uses the APIs from **kitz** and **petz**, we say that it is *petz-compatible*. In most cases, you should write mobs that are petz-compatible, because for each mob, feeding, taming and breeding are all optional features which can be enabled or disabled at your own convenience.

However, there might be good reasons for writing mobs that are *not* petz-compatible. We say that these mobs are *mobkit-exclusive*.

Consider a dinosaur that does not spawn naturally, but instead must be hatched from an egg, created in a lab from DNA recovered from fossils. In that case, you would *definitely* not want players to enable the breeding system, so it would be appropriate to write a mobkit-exclusive dinosaur.

## 1.6 API conventions

For the convenience of people writing mobkit-exclusive or petz-compatible mobs, the functions comprising the **unimobs** API are found in separate folders, and their sources are clearly labelled:

        unimobs.mobkit_api.get_node_height()
        unimobs.kitz_api.feed_mob()
        unimobs.petz_api.tame_mob_with_lash()

It *might* be appropriate for mobkit-exclusive mobs to call API functions imported from **kitz** or **petz**, but you should do so with caution, having examined the code.

## 1.7 Package conventions

The original **mobkit** code consisted of the following components:

- **mobkit** API functions
- A set of *behaviours* - roaming around the world, fleeing from predators, and so on
- A set of *brains*, deciding which behaviours each mob should perform, depending on current circumstances

In **unimobs**, behaviours and brains are contained within their own packages, with a consistent naming scheme.

Brain packages include **brain_herbivore**, **brain_predator**, **brain_aquatic** and so on. Each mob that you write has a single brain which controls all of its behaviour.

As discussed below, there are three types of behaviours: high-level, low-level and meta-behaviours. Behaviour packages are thus named **hqb**, **lqb** and **mtb**, for example **hqb_hunt**, **lqb_climb_tree** and **mtb_fall_asleep**.

Items such as food and separable body parts also have their own packages; but the **unimobs** API itself has *not* been implemented as packages. Instead, it can all be found in **../lib/system**.

## 1.8 Package format

As discussed in **unilib**'s documentation, each package is a separate .lua file. The package contains up to three standard functions.

**.init()** is compulsory. It returns a table of information about the package, including any dependencies on other packages.

**.exec()** is optional. It contains the main body of code for that package. No **.exec()** functions are called until the **.init()** functions in all packages have been called.

**.post()** is also optional, and most packages don't specify a **.post()** function at all. It is used for any code that must be executed after the **.exec()** functions in all packages have been called. Typically, it is needed when applying some change to multiple items, for example when creating buckets of water using all available empty buckets (which were created by other packages in their **.exec()** functions).

In **unimobs**, the code for a mob, brain or behaviour should always be declared in the package's **.exec()** function, unless there's a good reason to do otherwise. (Of course, **.exec()** can call as many local functions as it likes; we generally put those at the start of the package file.)

Note that, because every package knows about its own dependencies, *it is usually not necessary to add brain or behaviour packages to your remix*. Just add the mob packages you want; all the necessary brain and behaviour packages should be loaded automatically.

## 1.9 Modifying mob behaviour

Mob, brain and behaviour packages should be not be modified directly, because they're designed to be used by many different mobs. Instead, you should make copies of those packages, and then modify the copies as you see fit.

The [unilib documentation](https://github.com/axcore/unilib) describes in detail how to create modified packages safely.

# 2. Mob logic

This document replaces **mobkit**'s own API document. As mentioned before, there are only minor differences in the way **mobkit** and **unimobs** handle the behaviour of mobs.

## 2.1 Behaviour functions

Every action that mobs can perform is handled by a *behaviour function*.

Most behaviour functions have their own separate packages; very rarely, a single package might contain more than one behaviour function, with only one of them actually being used (see the **lqb_jump_attack** package for an example).

In **mobkit**, there were two types of behaviours, called **low-level behaviours** and **high-level behaviours**. **unimobs** adds a third type, **meta-behaviours**.

### 2.1.1 Low-level behaviours

**Low-level behaviours** govern simple physical actions and interactions with other mobs and players. Some examples are:

        lqb_climb_tree
        lqb_dumb_walk
        lqb_jump_attack

(Note that a behaviour, and the package that defines it, have the same name.)

### 2.1.2 High-level behaviours

**High-level behaviours** generate a sequence of low-level behaviours, in order to achieve more complex goals. Some examples are:

        hqb_find_land
        hqb_follow
        hqb_sleep_until_wake_up

High-level and low-level behaviours typically last for a considerable period of time. This means that the behaviour functions are called repeatedly on consecutive engine steps. There is therefore a need to preserve state between consecutive calls, which why behaviour functions are implemented as closures.

### 2.1.3 Meta-behaviours

**Meta-behaviours** perform some kind of action, and then terminate immediately.

Some meta-behaviours launch one of a number of high-level or low-level behaviours, depending on current conditions. Others merely update the mob's velocity, acceleration, position, orientation or dynamic properties.

The original **petz** code contained a number of meta-behaviours, but they were not labelled as such. In fact, some were falsely labelled as high-level or low-level behaviours. **unimobs** dispenses with this confusion.

## 2.2 Behaviour queues

Before a high-level or low-level behaviour can begin, it must be added to a queue. (Meta-behaviours are momentary, so they do not need to be added to any queue.)

Each mob has two separate queues, one for high-level behaviours and one for low-level behaviours. The queues are managed automatically according to a set of rules described below.

When one behaviour completes its task, the next behaviour in the queue starts. A behaviour continues until it terminates (having completed its task), is removed from the queue or is superseded by a higher-priority behaviour.

Low-level and high-level behaviour functions must return true when they have completed their task, or when they want to abandon it. (By convention, those functions return nil, not false, in order to continue for another iteration.)

Designers must be careful, while writing new behaviours, that true is returned at the right time.

## 2.3 Low-level behaviour functions

As mentioned above, low-level behaviours govern simple physical actions: steps, jumps, turns and so on. Any changes to a mob's velocity and yaw should be handled by a low-level behaviour, as should its animations and sounds.

This is how you might write a very simple low-level behaviour; we'll call it **lqb_jump_simple**.

We start with a *shared function* - one which is within the package's namespace, and which can therefore be called by any other package. The function should always be named **.add_to_queue()**.

The argument list should always begin with the mob's luaentity, **self**. Additional arguments are optional; if specified, they are persistent parameters, available until the behaviour terminates.

        function unilib.pkg.lqb_jump_simple.add_to_queue(self)
        end

Inside this function, there are up to three sections:

- Any persistent variables (this is optional)

        local count = 0

- A closure function (compulsory, and with a single mandatory argument, **self**)

        local func = function(self)
            ...
        end

- A call to unimob's API, asking it to add the behaviour to the mob's queue.

        unimobs.mobkit_api.add_to_low_level_queue(self, "lqb_jump_simple", func)

The bulk of the code is added to the closure function. *All closure functions should start by checking that the entity still exists*; if you don't, **unimobs** will crash unexpectedly.

Thus, we have a complete definition for a behaviour, wrapped up in a shared function:

        function unilib.pkg.lqb_jump_simple.add_to_queue(self)

            local count = 0

            local func = function(self)

                ...

                -- Count to 100, then jump; gravity will bring the mob back to the surface
                count = count + 1
                if count >= 100 then
                    self.object:set_acceleration({x = 0, y = 10, z = 0})
                    return true
                end

            end

            unimobs.mobkit_api.add_to_low_level_queue(self, "lqb_jump_simple", func)

        end

## 2.4 High-level behaviour functions

High-level behaviours are complex tasks like moving from one place to another, following other mobs, hiding, patrolling an area and so on. Their job is to track changes in the mob's vicinity and to manage the low-level behaviour queue accordingly.

The code for high-level and low-level behaviours has the same format, but with one important difference: the shared function has a second compulsory argument, which is the behaviour's priority (more on this below).

Thus, a high-level behaviour, wrapped up in **unilib** shared function, will look like this:

        function unilib.pkg.hqb_do_something.add_to_queue(self, priority)

            -- Any persistent variables could be declared here, but this behaviour doesn't need one
            local ignore_me = 0

            local func = function(self)

                ...

                -- Jump during the day, sleep at night
                if unimobs.petz_api.is_day() then
                    unilib.pkg.lqb_jump_simple.add_to_queue(self)
                else
                    unilib.pkg.lqb_sleep_simple.add_to_queue(self)
                end

                return true

            end

            unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_do_something", func, priority)

        end

## 2.5 High-level behaviour priority

Low-level behaviours are executed in first-in, first-out (FIFO) order.

High-level behaviours support prioritisation. The priority system makes it possible for **unimobs** to interrupt one task in order to perform a more important one. The interrupted task may be paused, waiting to resume at some later time; alternatively, it might be terminated altogether.

The priority is expressed as a number. A very important behaviour - such as responding to an attack - might have a priority of 20 (or higher), whereas a less important one - such as wandering around, eating fruit - might have a priority of 5 (or lower).

In the high-level behaviour queue, the currently-executing behaviour is always the first one in the queue. When a new high-level behaviour is added to the queue:

- If the queue is empty, the new behaviour is just added to the queue, starting immediately
- If the queue is not empty, the new behaviour is inserted before the first behaviour of lower priority
- If the new behaviour has a lower priority than everything else in the queue, then it's inserted at the end of the queue
- If the new behaviour has a higher priority than the one currently running (the first one in the queue), then the current behaviour terminates immediately, and the new behaviour starts instead

High-level behaviours can initiate other high-level behaviours. Here are two useful examples in which **hqb_task_one** initiates **hqb_task_two**.

In the first example, **hqb_task_one** terminates (after returning true); because **hqb_task_two** has the same priority, it takes the former's place in the queue, starting immediately.

        function unilib.pkg.hqb_task_one.add_to_queue(self, priority)

            local func = function(self)

                unilib.pkg.hqb_task_two.add_to_queue(self, priority)
                return true

            end

            ...

        end

In the second example, **hqb_task_one** does *not* return true, but initiates **hqb_task_two** with a higher priority. While **hqb_task_one** is paused, **hqb_task_two** is executed. When it terminates, **hqb_task_one** resumes execution.

        function unilib.pkg.hqb_task_one.add_to_queue(self, priority)

            local func = function(self)

                unilib.pkg.hqb_task_two.add_to_queue(self, priority + 1)

            end

            ...

        end

## 2.6 Meta-behaviour functions

As mentioned above, meta-behaviours are momentary, so they are not added to a queue.

Because they are not added to a queue, the behaviour function is named **.do_action()**, not **.add_to_queue()**.

The argument list should always begin with the mob's luaentity, **self**. Additional arguments are optional.

Here are two examples of a meta-behaviour function (which have been slightly simplified). The first launches one behaviour or another, depending on conditions:

        function unilib.pkg.mtb_flee_player.do_action(self, priority, player)

            if self.can_fly_flag and not self.is_plucked_flag then
                unilib.pkg.hqb_evade_in_liquid_or_air.add_to_queue(self, priority, player)
            elseif self.can_swim_flag and self.isinliquid then
                unilib.pkg.hqb_evade_in_liquid_or_air.add_to_queue(self, priority, player)
            else
                unilib.pkg.hqb_evade.add_to_queue(self, priority, player)
            end

        end

The second merely makes the mob stand still, setting its velocity to zero:

        function unilib.pkg.mtb_order_stand.do_action(self)

            ...

            self.object:set_velocity({x = 0, y = 0, z = 0})
            self.object:set_acceleration({x = 0, y = 0, z = 0})

        end

Note that only one of these examples includes **priority** as an argument, so that its value can be passed to the high-level behaviour.

## 2.7 Crash avoidance

Due to recent engine changes, there's a danger of a crash when behaviours call an ObjectRef function on a mob that's already been removed from the world. Specifically, the ObjectRef function now returns nil in situations in which a non-nil value was returned by earlier engine versions.

Rather than checking for a nil return value on every single call to an ObjectRef function, we instead do a simple check at the beginning of *almost every* behaviour function. If the mob has been removed from the world unexpectedly, we terminate the behaviour by returning true.

        if not unimobs.mobkit_api.is_behaviour_safe(self) then
            return true
        end

A few behaviour functions can omit this check because they don't call any ObjectRef functions (or any **unimobs** code that might itself call an ObjectRef function).

## 2.8 Brain packages

As mentioned above, every mob is assigned a "brain" to manage its overall behaviour. The brain manages the mob's high-level behaviour queue, responding to events that aren't handled by the **unimobs** system code (more on that below).

Each brain has a separate package. We start with its *shared function* - one which is within the package's namespace, and which can therefore be called by any other package. By convention, this function is named **.brain()**. It has a single mandatory argument, the mob's luaentity (**self**).

        function unilib.pkg.brain_goblin.brain(self)
        end

When we want to assign a brain to a mob, in some other package, we just use the name of the shared function.

        unilib.register_entity("unilib:mob_goblin_king", {
            ...
            brain_func = unilib.pkg.brain_goblin.brain,
        })

The shared function can be as simple or as complicated as you like; **unimobs** provides brain packages at both ends of the spectrum.

Many brains have a workflow that looks something like this:

1. Firstly, check for drowning and fall damage, updating the mob's health points if necessary

        unimobs.mobkit_api.check_vitals(self)

2. Then check that the mob's health points have not reached zero and, if so, convert it into a dead mob

        if self.hp <= 0 then

            unimobs.petz_api.handle_mob_death(self)
            return

        end

3. The engine calls the brain several times a second; in most cases, this is more than is necessary. We can conserve system resources by wrapping the rest of the logic in a code block, that runs only once a second.

        if unimobs.mobkit_api.check_main_timer(self, 1) then
            ...
        end

4. Inside that code block, we normally start by retrieving the priority of the high-level behaviour that is currently running.

        local priority = unimobs.mobkit_api.get_queue_priority(self)

5. Mobs are prone to getting stuck inside blocks; **unimobs** provides an emergency recovery system, which should normally be done next.

        local pos = self.object:get_pos()
        unilib.pkg.mtb_rescue_suffocating_mob.do_action(self, pos)

6. Finally, decide which behaviour to initiate, checking in order of descending priority.

        if priority < 20 then
            if ... then
                unilib.pkg.hqb_do_something.add_to_queue(self, 20)
                return
            end
        end

        if priority < 10 then
            if ... then
                unilib.pkg.hqb_do_something_else.add_to_queue(self, 10)
                return
            elseif ... then
                unilib.pkg.hqb_do_this_instead.add_to_queue(self, 10)
                return
            end
        end

        if unimobs.mobkit_api.is_high_level_queue_empty(self) then
               unilib.pkg.hqb_wander_around.add_to_queue(self, 0)
        end

The priority assigned to each behaviour is arbitrary; when writing your own brain packages, you can use whichever system you like. (The brain packages provided by **unimobs** tend to assign the same priorities to the same behaviours, but this is a convenience, not a rule.)

## 2.9 Order of execution

On each engine step, each mob is handled (one at a time) using the following steps:

1. The mob's physical status is checked - gravity, buoyancy, friction etc
2. The brain's shared function is called; sometimes it will add or remove behaviours from the queues
3. The first behaviour in the high-level queue, if any, is executed
4. The first behaviour in the low-level queue, if any, ie executed

As well as that regular cycle, petz-compatible mobs respond when certain events happen:

- The mob being punched by a player (or another mob)
- The mob being right-clicked by a player
- A general status update, once per second

Mobs sometimes register additional functions which are executed when one of those events takes place (see below).

# 3. Creating mobs

This section describes how a mob is created; you can read it if you want to modify an existing mob, or write a new one.

Most mobs have their own separate package. Some exceptions are described above; you should follow those code examples if you want to do something similar.

The name of the package usually follows the mob type, for example, the **dog_normal** mob is defined in a package called **mob_dog_normal**.

## 3.1 Mob definition formats

As mentioned before, **unimobs** provides two ways to register a new mob.

A few petz-compatible mobs use a single API function, **unimobs.petz_api.register_standard_mob()**. Most of them, however, use a direct call to **unilib.register_entity()**, followed by supplementary calls to other API functions.

*There seems to be no tangible advantage in using* **unimobs.petz_api.register_standard_mob()**, so this section will not describe it. You can find a full description in the API section below, if you need it.

## 3.2 Mob properties

Every mob has a number of properties. We can divide them into two groups, **dynamic** and **non-dynamic** properties.

**Non-dynamic** properties are defined during the call to **unilib.register_entity()**, and afterwards do not change. For example, wolves are wild animals and so have the property called **.is_wild_flag**; there is no (simple) mechanism by which this can change.

**Dynamic** properties, on the other hand, may change at any time. For example, dogs have a **.nametag** property; the player can set (or change) the names of their pet dogs whenever they please.

It is important to note that, at the moment, *only petz-compatible mobs have dynamic properties*. Dynamic properties are handled by code inherited from **petz**. Other types of mob *could* be given dynamic properties, but new code would have to be written to support them.

## 3.3 Dynamic properties

Dynamic properties, not being defined during the call to **unilib.register_entity()**, are lost every time the game restarts.

Therefore, any changes to dynamic properties are stored in a special "long-term" memory. There is a standard way to do this:

        self.PROPERTY = unimobs.mobkit_api.add_mob_memory(self, PROPERTY, NEW_VALUE)

There are a small number of dynamic properties which are *not* stored in the long-term memory, because we *want* the values to be lost when the game restarts. One example is the **.driver** property; when the game restarts, the player is automatically detached from the pony they're riding, so the old value is useless.

Besides these few exceptions, *every change to a dynamic property should be performed using the code template above*.

WARNING: Mob memory is serialised. Never try to remember ObjectRefs or the tables referencing them, or the engine will crash.

WARNING: Each mob's long-term memory is lost if the game crashes. There is currently no workaround for this **mobkit** problem.

## 3.4 Non-dynamic properties

Non-dynamic properties can be divided into several groups. In addition, some properties are compulsory, and others are optional. Let's discuss them now.

### 3.4.1 Base properties

petz-compatible mobs have the following (compulsory) base properties:

- **.petz_compat_flag** - must be true for all petz-compatible mobs
- **.class_type** - for most creatures, this is synonymous with its species. Monsters mostly have the class type "monster". Otherwise, it's usually the first word in the **.mob_type** property
- **.mob_type** - the mob's "internal name". Every petz-compatible mob must have a unique **.mob_type**. This internal name is guaranteed to match the name of the entity itself, e.g. the internal name **dog_normal** corresponds to the entity named **unilib:mob_dog_normal**
- **.generic_type** - usually this has the same value as the **.mob_type**; sometimes it can be tweaked to match the names of various media files (especially sound files). As an example, we have both queen bees and worker bees, both of which use the same sounds, and so therefore their **.generic_type** properties have the same value
- **.description** - a general description of the creature, e.g. "Dog (Normal)". Using a description in this format makes it easier to generate alphabetical lists of mobs

In addition, petz-compatible mobs have the following optional base property:

- **.sci_name** - a scientific name for this animal; omit it, if you like

mobkit-exclusive mobs have *no* compulsory base properties. By convention, we use the following optional one:

- **.petz_compat_flag** - if specified, must *not* be true for all mobkit-exclusive mobs

Here's an actual code example.

        unilib.register_entity("unilib:mob_dog_normal", {
            petz_compat_flag = true,
            class_type = "dog",
            mob_type = "dog_normal",
            generic_type = "dog_normal",
            description = "Dog (Normal)",
            sci_name = "Canis lupus familiaris",

            ...
        })

### 3.4.2 Common properties

All mobs must include **Minetest**'s standard **.initial_properties** field. This is the one used by normal dogs, which you can amend as required:

        unilib.register_entity("unilib:mob_dog_normal", {
            ...

            initial_properties = {
                backface_culling = false,
                collide_with_objects = true,
                collisionbox = cbox,
                makes_footstep_sound = false,
                mesh = mesh,
                physical = true,
                selectionbox = cbox,
                static_save = true,
                stepheight = 0.1,
                textures = unimobs.petz_api.compile_texture_list("dog_normal", skin_init_list),
                visual = unimobs.petz_const.visual,
                visual_size = visual_size,
            },

            ...
        })

The values **cbox**, **mesh**, **skin_init_list** and **visual_size** are local variables, defined earlier in the package. We'll discuss their format next.

- mesh, cbox, visual_size

**unimobs.petz_const.visual** is a global constant variable, which is the same for all mobs.

The mob's collision box (also used as its selection box) and its size are defined in a standard way; in the code example below, all you need to do is to replace the ? characters with appropriate values, according to the mesh you're using.

**p1** and **p2** represent oppposite corners of the collision box.

        local p1 = {x = ?, y = ?, z = ?}
        local p2 = {x = ?, y = ?, z = ?}
        local scale_factor = ?

        local cbox = unimobs.petz_api.get_standard_collisionbox(p1, p2, scale_factor, nil)
        local visual_size = unimobs.petz_api.get_standard_visual_size(scale_factor)

        local mesh = "unilib_mob_dog_normal.b3d"

Creatures that produce babies (see below for more information) should use this code instead:

        local p1 = {x = ?, y = ?, z = ?}
        local p2 = {x = ?, y = ?, z = ?}
        local scale_factor = ?
        local baby_scale_factor = ?

        local cbox, cbox_baby =
                unimobs.petz_api.get_standard_collisionbox(p1, p2, scale_factor, baby_scale_factor)
        local visual_size = unimobs.petz_api.get_standard_visual_size(scale_factor)

        local mesh = "unilib_mob_dog_normal.b3d"

**baby_scale_factor** is usually 0.5, or 0.66 for very small creatures (but you can use any appropriate value).

- skin_init_list

Most mobs have multiple different skins, assigned randomly at birth.

If you like, you could specify a simple list of textures. Each one has an equal chance of being assigned to a new mob:

        textures = {"unilib_mob_goblin_1.png", "unilib_mob_goblin_2.png"},

All mobkit-exclusive mobs use a list in that simple format. Most petz-compatible mobs, on the other hand, have a  non-uniform list of skins, some of which are rarer than others.

As an example, here are the skins for normal lions:

        local skin_init_list = {
            -- Normal skins
            {"yellow", S("Yellow"), 1},
            {"white", S("White"), 0.5},
            {"brown", S("Brown"), 0.1},
            -- Rare mutations
            {"black", S("black"), 0},
        }

Three "normal" skins can be assigned to lions that spawn naturally in the world. They are defined in groups of three values: an internal name (which matches the name of the texture file), a description, and a probability. The "yellow" skin occurs twice as often as a "white" skin, and ten times as often as a "brown" skin.

Mutations are always the result of breeding, and never occur in naturally-spawning mobs. They are marked as mutations by giving them a probability of 0.

### 3.4.3 Mobkit API properties

The next group of properties are those which apply to all mobs, being derived from **mobkit**.

The **.brain_func** property, which we've discussed at length above, is compulsory; all others are optional (but recommended, in most cases).

- **.animation_table** - a table describing the mob's animations. If not specified, the mob will appear to be as still as a statue. If specified, use a table in the following format:

        .animation_table = {
            -- Single animation
            [name]={range={x=[num],y=[num]},speed=[num],loop=[bool]},
            -- Variant animations; one is chosen at random
            [name]={
                {range={x=[num],y=[num]},speed=[num],loop=[bool]},
                {range={x=[num],y=[num]},speed=[num],loop=[bool]},
                ...
            }
            ...
        },

- **.armour_groups** - a table in the format used by **unilib**'s version of the [3d_armor mod](https://github.com/minetest-mods/3d_armor). If specified, use a table in the following format:

        .armour_groups = {fleshy=[num]}

- **.attack_table** - A table describing the damage this mob can inflict on other creatures (including players). If specified, use a table in the following format:

        .attack={range=[num],damage_groups={fleshy=[num]}},

**range** is the distance between the centre of the attacker's collisionbox and the tip of the weapon, in blocks.

- **.bounciness** - a number used in collisions to determine the rebound; use 0 if no rebound is required
- **.brain_func** - described above
- **.buoyancy** - the portion of the hitbox that is submerged in liquids; 0.5 is a common value. Use 1 for controlled buoyancy (fish, submarines etc), greater than 1 for drowning, or less than 0 for **Minecraft**-like water trampolining
- **.jump_height** - the mob's maximum jump height, under normal conditions; 1 is a common value
- **.lung_capacity** - the mob's lung capacity (how long it can survive without air, in seconds, before taking damage); 10 is a common value
- **.max_hp** - the mob's maximum health points, as tracked by **unimobs**. 10 is common value for mobs that aren't unusually strong. Note that **Minetest** uses a separate property, **.hp_max**, which should not be confused with this one
- **.max_speed** - the mob's maximum speed in m/s, under normal conditions; 1 is a common value for mobs that aren't unusually quick
- **.physics_func** - a custom function handling the mob's physics; if not specified, a default function is used instead
- **.sounds** - a table describing the sounds emitted by the mob

Note that the table format described in **mobkit**'s own documentation is *wrong*, both for **mobkit** itself and for modern **unimobs** code. This is the correct format for both.

        .sounds = {
            -- A single sound with a simple definition
            [name]=[string filename],
            -- Multiple sounds, each with a simple definition
            [name]=[list of string filename],
            -- A single sound with a more complex definition
            -- All fields except name are optional
            -- range, if specified, is a table in the form (left_bound, right_bound)
            [name]={
                name=[string filename],
                gain=[num or range],
                fade=[num or range],
                pitch=[num or range],
            },
            -- Multiple sound variants, with one chosen at random each time
            [name]={
                {
                    name=[string filename],
                    gain=[num or range],
                    fade=[num or range],
                    pitch=[num or range],
                },
                {
                    name=[string filename],
                    gain=[num or range],
                    fade=[num or range],
                    pitch=[num or range],
                },
                ...
            },
            ...
        },

- **.timeout** - the time, in seconds, after which the entity is automatically removed. Rarely used; use the value 0 (or nil) to prevent automatic removals
- **.view_range** - the distance, in blocks, within which the mob can detect other creatures (including players)

### 3.4.4 Kitz API properties

This group contains a single property, **._id**, that is **never** specified in the entity definition. Instead, the value is assigned automatically, when the game starts. The value is not retained between restarts.

The **._id** property is not used with mobkit-exclusive mobs.

### 3.4.5 Petz non-dynamic properties

The following properties are used only by petz-compatible mobs.

- **.avoid_players_flag** - if true, the mob will run away from nearby players, rather than attack them without provocation, overriding the value of **.hostile_to_players_flag**. Applies only to mobs whose behaviour includes the ability to attack. As an example, note that wolves will attack only after being provoked
- **.baby_type_list** - a list of **mob_type**s for the babies of this mob. Intended for creatures like elephants, which are represented by two distinct entities: an adult/baby male and an adult/baby female. If specified, the list can contain any number of items, which need not represent the same species as the parents (but must still have compatible genetics)
- **.can_alight_flag** - applies to flying mobs. If true, the mob can stand and walk on the ground
- **.can_breed_flag** - if true, the mob can produce babies. This flag should be false for mobs that should not be bred using the standard method (feeding them with a certain item)
- **.can_climb_trees_flag** - if true, the creature can climb trees
- **.can_clutch_flag** - if true, the creature can "clutch" suitable small items (e.g. a dog can pick up square balls in its mouth). All "clutchable" items must be registered via a call to **unimobs.petz_api.register_clutchable_item()**
- **.can_fly_flag** - if true, the mob can fly
- **.can_groom_flag** - if true, the mob can be brushed (with a hairbrush) or rubbed with lotion (e.g. beaver oil). In Tamagotchi Mode, both brushing and rubbing increase the mob's affinity for its owner; otherwise, the mob's mood is unaffected
- **.can_herd_flag** - if true, the creature can join herds of similar animals, and follow shepherds (players wielding a shepherd's crook)
- **.can_jump_flag** - if true, the creature can jump
- **.can_perch_flag** - if true, the creature can be placed on a bird stand or similar item
- **.can_pluck_flag** - if true, a feather can be plucked from the mob
- **.can_swim_flag** - if true, the mob can swim. When false and the creature is placed in water, it will take damage and eventually die
- **.capture_type** - specifies the type of item that can capture a creature. Supported values are "lasso", "animal_net", "bug_net" or nil for any mob that can't be captured
- **.default_rotation** - value set (by default) to 0 for all creatures; it is used to set the correct rotation for a creature mounted by a player
- **.die_in_daylight_flag** - true if the creature should die in daylight (specifically, in light levels greater than the value specified by **.spawn_max_light**)
- **.drop_list** - a list of mini-tables specifying one or more items dropped by this creature. The mini-tables are in the form:

        .drop_list = {
            {name = "unilib:food_lamb_chop_raw", chance = 1, min = 1, max = 1},
            {name = "unilib:item_bone_animal", chance = 5, min = 1, max = 1},
        },

In this example, there's a 100% probability of dropping a lamb chop but only a 20% probability of dropping a bone. The **.min** and **.max** fields can be used to drop more than one of each item, when necessary.

- **.dung_name** - specifies the item that is produced as dung from time to time (e.g. **unilib:misc_dung_normal**); if not specified, dung is never produced
- **.egg_name** - the name of the mob's egg (e.g. **unilib:egg_chicken_normal**)
- **.has_tamagotchi_mode_flag** - if true, Tamagotchi Mode (when enabled) applies to this mob; see the README
- **.head_prop_table** - a table of values used to animate the creature's head (or nil, if no special animations are required); see the **mob_sheep_normal** package for an example
- **.hostile_to_players_flag** - if true, will attack nearby players without provocation (as long as the creature's behaviour includes the ability to attack)
- **.igniter_immunity_flag** - if true, the creature doesn't take damage from igniters (fire, lava etc)
- **.is_baby_flag** - a flag initially set to true for all creatures that are inherently babies (like chicklets), and false for all mobs that are inherently adults (like hens and roosters); set to nil (not false) otherwise. The value is subsequently set to true or false when the mob is initialised
- **.is_boss_flag** - if true, the mob is a "boss" monster. No part of the unimobs code uses this property, but it's available if required
- **.is_male_flag** - a flag initially set to true for all creatures that are inherently male, and to false for all creatures that are inherently female; set to nil (not false) otherwise. The value is subsequently set to true or false when the mob is initialised
- **.is_mammal_flag** - true if the mob is a mammal. Aquatic mobs which are not mammals will suffocate in the air
- **.is_milkable_flag** - true for all mobs that can be milked
- **.is_monster_flag** - if true, the mob is an "ordinary" monster (compare **.is_boss_flag)**
- **.is_mountable_flag** - if true, the mob can be mounted (ridden)
- **.is_pet_flag** - flag whose intention in the original code is not clear. When true, herbivores will not flee from players, hunger and grooming apply in Tamagotchi Mode, tamed mobs can't be captured by other players, dreamcatchers can be used on the creature, and nametags can be used on the creature
- **.is_wild_flag** - if true, the mob is a wild animal. These creatures have certain changes in behaviour, such as requiring a lash to be tamed, and having the ability to "guard" the player
- **.jump_chance** - a value used only with creatures whose **.can_jump_flag** is true, and which live on land. It represents the chance of engaging the **hqb_terrestrial_jump** behaviour; a value of 10 corresponds to once in every 10 occasions, when a jump is possible
- **.jump_impulse** - a value used only with mobs whose **.can_jump_flag** is true, and which live on land. It affects the magnitude of the jump, relative to the creature's **.max_speed**, so frogs (impulse 4.0) jump about the same height as rabbits (1.2)
- **.lay_eggs_mode** - a value describing the types of eggs produced by compatible mobs; valid values are "item", "node" or "nest" (or nil for creatures that don't lay eggs)
- **.max_roam_height** - a value specifying the maximum height for roaming/wandering. Does not specify the maximum spawn height; use **.spawn_max_height** for that
- **.nest_empty_name** - the name of the empty nest in which this mob lays an egg, e.g. **unilib:misc_nest**; nil if this creature doesn't require a nest, or doesn't lay eggs at all
- **.nest_full_name** - the name of the full nest in which this mob has laid an egg, e.g. **unilib:misc_nest_with_egg_duck_normal**; nil if this creature doesn't require a nest, or doesn't lay eggs at all
- **.obeys_orders_flag** - if true, the creature can be given orders
- **.parent_type_list** - a list of **mob_type**s for the parents of this mob. Intended for creatures like chickens, which are represented by three distinct entities: an adult male, adult female and baby of either gender. This property has a strict format; if specified, it should contain exactly two items, the female and male **mob_type**s (in that order). In this way, a female baby grows into a female adult
- **.sleep_in_day_flag** - if true, the creature can sleep during the day
- **.sleep_in_night_flag** - if true, the creature can sleep at night
- **.sleep_ratio** - the proportion of each 24-hour period spent asleep; e.g. 0.3 means 60% of the night (or day)
- **.spawn_max_light** - maximum light in which the mob will spawn (or nil for no maximum)
- **.spawn_min_light** - minimum light in which the mob will spawn (or nil for no minimum)
- **.straggle_type_list** - a list of **mob_type**s that this mob straggles (follows behind); can be set for suitable creatures (e.g. puppies follow their parents) and not set for unsuitable creatures (e.g. baby tarantulas don't follow their parents). The items in this list are checked in order, so if the parents are represented by different **mob_type**s, the mother should probably be listed first. Straggling is implemented by a limited range of brain packages: by default, **brain_predator**, **brain_herbivore** and **brain_flying** (though you can add it to your own brain packages, if you want). In those brain packages, babies follow adults (only), and straggling does not happen at all if the **unimobs.petz_setting.enable_straggle_flag** and **unimobs.petz_setting.streamline_behaviour_flag** settings are not true (in the **Minetest** settings menu, these are "Enable baby mobs following their parents" and "Streamline behaviours for better performance").

There are two properties which are set automatically, after the values specified in **mob_settings.csv**. They should not be specified in the entity definition.

- **.spawn_max_height** - maximum height at which the mob will spawn (or nil for no maximum)
- **.spawn_min_height** - minimum height at which the mob will spawn (or nil for no minimum)

## 3.5 Petz baby properties

Most petz-compatible mobs can produce babies; in that case, the babies should be smaller than the parents. When the baby is created, the values of the following properties are used to replace other values:

- **.collisionbox_baby** - replaces the value of **.collisionbox**
- **.selectionbox_baby** - replaces the value of **.selectionbox**
- **.visual_size_baby** - replaces the value of **.visual_size**

The values of these properties can be set following the code examples above.

## 3.6 Petz node replacement properties

A few petz-compatible mobs can replace nodes - for example, sheep eat turf, replacing a dirt-with-turf node with a plain dirt node. For those creatures, the following properties are defined.

- **.replace_data_list** - a list of mini-lists, specifying which nodes should be replaced.

Each mini-list is in the form ( OLD_NODE, NEW_NODE, Y_OFFSET ).

**OLD_NODE** and **NEW_NODE** can be node names like **unilib:sand_ordinary**, as well as group names like **group:grass**. The **Y_OFFSET** varies between mobs, specifying how far below the creature the replaced node is found.

Here's a typical example, from the **mob_sheep_normal** package. Note that it's not necessary to include **unilib** dirt nodes, as they are handled by other properties (see just below); but for the sake of compatibility, we still include dirt nodes from [minetest_game](https://github.com/luanti-org/minetest_game).

        replace_data_list = {
            {"group:grass", "air", -1},
        --  {"unilib:dirt_ordinary_with_turf", "unilib:dirt_ordinary", -2},
            {"default:dirt_with_grass", "default:dirt", -2},
        },

- **.replace_rate** - a measure of how quickly the creature replaces nodes; 10 is a good default value
- **.replace_turf_flag** - if true, the creature can replace any **unilib** dirt-with-turf node, leaving a dirt node in its place
- **.replace_turf_offset** - the vertical offset for replaced dirt-with-turf-nodes; again, the value varies for different creatures

## 3.7 Petz mob-specified properties

A few creatures have properties that are unique to them, or which are shared with one or two other types of creature (for example, camels and ponies have a few properties that are not shared by other creatures).

Consult the relevant packages for more information about these properties.

## 3.8 Required callbacks

All creatures must specify three callbacks. Mobkit-exclusive mobs can use the callbacks imported from **mobkit**:

        get_staticdata = unimobs.mobkit_api.get_staticdata_callback,
        on_activate = unimobs.mobkit_api.on_activate_callback,
        on_step = unimobs.mobkit_api.on_step_callback,

petz-compatible mobs can also use the callbacks imported from **petz**:

        get_staticdata = unimobs.mobkit_api.get_staticdata_callback,

        on_activate = function(self, staticdata, dtime_s)

            unimobs.mobkit_api.on_activate_callback(self, staticdata, dtime_s)
            unimobs.petz_api.set_mob_initial_properties(self, staticdata, dtime_s)

        end,

        on_step = function(self, dtime)

            unimobs.mobkit_api.on_step_callback(self, dtime)
            unimobs.petz_api.on_step_callback(self, dtime)

        end,

It's acceptable to add more code to these functions, but the same callbacks must still be called (see the **mob_pony_normal** package for a practical example).

## 3.9 Optional callbacks

Creatures may have any number of callbacks, besides the required ones described above.

The mobkit-exclusive mobs imported from the **wildlife** mob provide their own **.on_punch()** callbacks; you can copy code from the **mob_deer_simple** or **mob_wolf_simple** packages, if that's convenient.

petz-compatible mobs mostly use the same three optional callbacks:

        on_deactivate = function(self)
            unimobs.petz_api.on_deactivate_callback(self)
        end,

        on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir)

            unimobs.petz_api.on_punch_callback(
                self, puncher, time_from_last_punch, tool_capabilities, dir
            )

        end,

        on_rightclick = function(self, clicker)
            unimobs.petz_api.on_rightclick_callback(self, clicker)
        end,

## 3.10 Extension callbacks

The original **petz** core code included numerous references to specific creatures and items, meaning that some game mechanics could not be extended to new creatures and items.

**unimobs** circumvents this problem by allowing packages to specify their own *extension callbacks*. These are used to supplement the standard game mechanics.

Some callbacks return meaningful values, others return no value in particular. Note that multiple callbacks can be registered for a single mob or item, when necessary.

In a few rare cases, **unimobs** system code does still refer to a specific mob or item: for example, only one type of dreamcatcher is supported.

### 3.10.1 List of extension callbacks

**unimobs.petz_api.register_capture_extension(MOB_TYPE, CALLBACK)**

*Returns: n/a*

Registers a callback, which is called whenever the mob is captured (with a lasso or a net).

**unimobs.petz_api.register_death_extension(MOB_TYPE, CALLBACK)**

*Returns: n/a*

Registers a callback, which is called whenever the mob dies.

**unimobs.petz_api.register_formspec_extension(MOB_TYPE, DATA_TABLE)**

*Returns: see below*

Registers a new button in the main mob formspec, visible only for **MOB_TYPE**. For example, it allows ponies to add a button which can be clicked, in order to drop horseshoes.

Note that the main mob formspec has limited space for new buttons; before adding one, check that there's enough room.

**DATA_TABLE** contains the following optional key-value pairs:

- **.order_flag** - flag set to true for an order button (ordering a tamed mob to do something), false for an action button
- **.click_func** - the callback to be called when the player clicks the button; it returns no value in particular
- **.draw_func** - the callback to be called, just before the button is drawn. If not specified, the button has a generic image and no text. Otherwise, the callback should return a table of values.

The table of values returned by **.draw_func** contains the following optional key-value pairs:

- **.reopen_flag** - true if the whole formspec should be re-drawn, after the button is clicked; false if the formspec should be closed
- **.img** - the filename of the image to display in the button; if no image is specified, a generic one is used
- **.text** - a short piece of text to display at the centre of the button, usually a small number
- **.tooltip** - a tooltip for the button

**unimobs.petz_api.register_initial_extension(MOB_TYPE, CALLBACK)**

*Returns: n/a*

Registers a callback, which is called whenever a new mob's dynamic properties are being initialised; specifically, during the call to **unimobs.petz_api.set_mob_initial_properties()**.

**unimobs.petz_api.register_punch_mob_extension(MOB_TYPE, CALLBACK)**

*Returns: n/a*

Registers a callback, which is called whenever the specified mob is punched.

**unimobs.petz_api.register_punch_with_extension(WEAPON_NAME, CALLBACK)**

*Returns: n/a*

Registers a callback, which is called whenever *any* mob is punched with the specified weapon.

**unimobs.petz_api.register_replenish_extension(MOB_TYPE, CALLBACK)**

*Returns: n/a*

Registers a callback, which is called whenever a mob is replenished - for example, whenever a sheared sheep grows new wool, and whenever a milked cow can be milked again.

**unimobs.petz_api.register_tamagotchi_extension(MOB_TYPE, CALLBACK)**

*Returns: n/a*

Registers a callback which is only called in Tamagotchi Mode, whenever the mob's hunger, grooming and affinity stats are checked and updated (specifically, during the call to the timer function in .**./lib/system/petz/petz_tamagotchi.lua**).

## 3.11 Override callbacks

Unlike *extension callbacks*, which supplement the existing game mechanics, *override callbacks* are used to replace them.

### 3.11.1 List of override callbacks

**unimobs.petz_api.register_rightclick_override(WIELDED_ITEM_NAME, CALLBACK)**

*Returns: true if some action was taken; false if no action was taken (and therefore, the normal action should take place instead)*

Registers a callback, which is called whenever a player right-clicks a mob while wielding the specified item. If the callback decides to take no action, it returns false, and the normal response takes place instead.

**unimobs.petz_api.register_texture_override(MOB_TYPE, CALLBACK)**

*Returns: A texture (as a string) or nil*

Registers a callback, which is called whenever a mob's skin is being created.

If the callback returns a texture (as a string), it is used as the basis for the mob's skin. (Some other textures may still be placed over the top, for example saddles and saddle-bags.)

If the callback returns nil, the next callback on the list is called, continuing until one of them returns a texture string, or there are no more callbacks in the list.

## 3.12 Exposed luaentity members

Some frequently-used entity fields can be accessed directly for convenience.

- self.dtime - the **dtime** passed to **.on_step()**, or 0.5 (whichever is higher); limit of 0.05 to prevent jerkines on long engine steps
- self.hp - the mob's health points
- self.isonground - true if in collision with negative Y for at least two successive steps
- self.isinliquid - true if the node at foot level has the **.drawtype** "liquid"

## 3.13 Registering the mob

The final stage in most mob packages is to register the mob in global variables, and to create its spawn egg. This is done in a standard format; you can adapt this code example for use in your own packages.

        if unimobs.petz_api.register_mob({
            mob_type = "pony_normal",
            mob_name = "unilib:mob_pony_normal",
            description = description,
            insertion_table = insertion_table,

            collisionbox = cbox,
            genetic_init_list = genetic_init_list,
            mesh = mesh,
            skin_init_list = skin_init_list,
            version = version,
            visual_size = visual_size,
        }) then

            unimobs.petz_api.register_spawnegg({
                mob_type = "pony_normal",
                orig_name = "petz:pony_set",

                replace_mode = mode,
                description = description,
                img = "unilib_spawnegg_pony_normal.png",
                mob_name = "unilib:mob_pony_normal",
                sci_name = sci_name,
                tamed_flag = not is_wild_flag,
            })

        end

The key-value pairs not already mentioned are as follows:

- **.genetic_init_list** - a list of mini-lists, each one specifying one of the mob's genetic traits.

Genetic traits (or genes) can be divided into two groups: standard (shared between many creatures), and custom (normally used by just one creature).

The README describes all of the "standard" genes; they are: **agility**, **compliance**, **digestion**, **docility**, **fertility**, **incontinence**, **loftiness**, **luckiness**, **mounted_forward_speed**, **mounted_reverse_speed**, **mounted_speed_boost** **perception**, **productivity**, **springiness**, **toughness**, **variability** and also **generic**.

The **generic** gene is used for some genetic traits that have no effect on the mob; usually, it's given a cryptic description like *sliminess*. It's up to the player to discover which unfamiliar genes have real effects, and which are just for fun.

If multiple **generic** genes are required, they can be called **generic_2**, **generic_3** and so on.

An example of a custom gene is **woolliness**, used only by sheep.

There are three ways to specify the range of possible values for a gene:

- **default** - each gene has an initial value that never changes
- **list** - each gene has a fixed list of initial values; one is chosen at random for every mob
- **range** - each gene has a range of values, e.g. 1-12; a value is chosen at random for every mob

The mini-lists used to define genes are in the following forms:

        { GENE_TYPE, GENE_NAME, "default", INITIAL_VALUE }
        { GENE_TYPE, GENE_NAME, "list", LIST_OF_INITIAL_VALUES }
        { GENE_TYPE, GENE_NAME, "range", INITIAL_MIN, INITIAL_MAX, OVERALL_MIN, OVERALL_MAX }

All values are compulsory, except **OVERALL_MIN** (the default value is 0) and **OVERALL_MAX** (no default maximum applies).

**GENE_TYPE** is the gene's internal name; perhaps one of the names listed above, e.g. "agility" or "generic"

**GENE_NAME** is a short description of the gene that's visible to players, e.g. "Agility" or "Sliminess". It does not need to be unique, and does not even need to be related to **GENE_TYPE**.

- **.insertion_table** - a table of strings used to help with translations. The table follows a standard format; just replace **pony**, **a pony** and **the pony** for each new creature you create:

            local S = unimobs.intllib
            local T = unimobs.strip_tags
            local insertion_table = {
                subject = T(S("pony#subject")),
                subject_an = T(S("a pony#subject")),
                subject_the = T(S("the pony#subject")),
                object = T(S("pony#object")),
                object_an = T(S("a pony#object")),
                object_the = T(S("the pony#object")),
            }

- **.orig_name** - the name of the spawn egg in the original code (or nil, if you're writing a brand new mob)

- **.replace_mode** - the package's replace mode, initialised at the beginning of every **unilib** package. See the [unilib documentation](https://github.com/axcore/unilib) for more details

- **.version** - a number that **unimobs** can use to update older versions of mobs, if necessary. Use version 1 for all mobs that you create, and don't increment it until there's some important change that needs to be applied to existing mobs.

At the time of writing, all petz-compatible mobs have the **.version** 1. If some update needs to be applied in the future, the code will be added to the marked section of the file **../lib/system/petz/petz_init_prop.lua**.

# 4. Built-in brain packages

This section describes the built-in brain packages. Actions are listed roughly in priority order, with the highest-priority actions listed first.

All built-in brain packages use some kind of roaming behaviour when no other behaviours are taking place.

## 4.1 Brains imported from the wildlife mod

### 4.1.1 brain_deer_simple

Used only by simple deer mobs (the **mob_deer_simple** package).

- Swims in water
- Tries to avoid simple wolves
- Flees from nearby players

### 4.1.2 brain_wolf_simple

Used only by simple wolves (the **mob_wolf_simple** package).

- Swims in water
- Hunts simple deer
- Growls at players that get too close

## 4.2 Brains imported from petz

### 4.2.1 brain_ant

Used only by ants from the **mob_ant_misc** package.

- Swims in water
- Takes damage from fire, lava and so on
- Queens hunt other queens
- Queens occasionally establish anthills
- Queens, warriors and workers all attack nearby players
- Queens lay eggs

### 4.2.2 brain_aquatic

Used by several aquatic creatures, such as fish and dolphins.

- Most aquatic creatures (except mammals) suffocate in the air
- Takes damage from fire, lava and so on
- Interacts with players wielding particular items
- Some hostile mobs attack nearby players
- Some mobs can jump

### 4.2.3 brain_bee

Used only by bees from the **mob_bee_misc** package.

- Queens fly around independently
- Workers search for flowers and bring pollen back to the hive
- Queens occasionally establish new hives
- Bees only attack players if provoked
- Bees return to their hive at night

### 4.2.4 brain_flying

Used by several winged creatures, such as parrots and pigeons.

- Takes damage from fire, lava and so on
- Some mobs can be ridden by players (but not any of the built-in flying creatures)
- Will "fly" straight upwards, if in water
- Flees from predators
- Interacts with players wielding particular items
- Some aggressive mobs can attack other mobs
- Some babies will straggle (follow behind) their parents
- Some mobs can jump (when on land)
- Some mobs produce dung
- Some mobs replace nodes
- Some mobs can form herds
- Some mobs look for a food source, such as a pet bowl
- Some mobs can climb trees
- Some mobs can fall asleep
- Some mobs will turn and look at nearby players
- When not busy with any of those activities, flying mobs can take off, fly around, land, and walk on the ground

### 4.2.5 brain_herbivore

Used by many different creatures.

- Takes damage from fire, lava and so on
- Some mobs can be ridden by players
- Swims in water
- Flees from predators, and sometimes from players
- Interacts with players wielding particular items
- Some aggressive herbivores can attack other creatures
- Some babies will straggle (follow behind) their parents
- Some mobs can jump
- Some mobs produce dung
- Some mobs replace nodes (e.g. sheep eat turf)
- Some mobs can form herds or follow shepherds
- Some mobs look for a food source, such as a pet bowl or a straw bale
- Some mobs play with toys such as square balls
- Some mobs can climb trees
- Some mobs can fall asleep
- Some mobs will turn and look at nearby players

### 4.2.6 brain_monster

Used by many monsters.

- Swims in water
- Takes damage from fire, lava and so on
- Hunts prey and attacks players
- Some mobs replace nodes

### 4.2.7 brain_predator

Used by many different creatures.

- Takes damage from fire, lava and so on
- Interacts with players wielding particular items
- Hunts prey, and sometimes attacks nearby players
- Some babies will straggle (follow behind) their parents
- Some mobs produce dung
- Some mobs replace nodes

### 4.2.8 brain_semiaquatic

Used by semi-aquatic creatures such as beavers and frogs.

- Takes damage from fire, lava and so on
- Interacts with players wielding particular items
- Hunts prey, and sometimes attacks nearby players
- Some mobs can jump
- Some mobs produce dung
- Some mobs replace nodes
- Beavers occasionally build a dam

# 5. Built-in behaviour packages

All high-level and low-level behaviour functions return true when they have completed their task, or when they want to abandon it.

*Some* meta-behaviour functions return true in order to indicate some kind of success condition.

By convention, all behaviour functions return nil instead of false.

## 5.1 High-level behaviours

### 5.1.1 hqb_approach_beehive

**unilib.pkg.hqb_approach_beehive.add_to_queue(SELF, PRIORITY)**

Called only for bees to stop them roaming too far from their hives.

Launches **lqb_approach_beehive** and then waits, terminating only when the bee is a reasonable distance from its hive.

### 5.1.2 hqb_aqua_attack

**unilib.pkg.hqb_aqua_attack.add_to_queue(SELF, PRIORITY, TARGET_OBJECT, SPEED)**

Standard attack behaviour for aquatic mobs.

Attacks the TARGET_OBJECT, turning towards it when necessary (**hqb_aqua_turn**).

### 5.1.3 hqb_aqua_jump

**unilib.pkg.hqb_aqua_jump.add_to_queue(SELF, PRIORITY)**

Called for aquatic mobs that have the **.can_jump_flag** property.

Jumps out of the water briefly, making a satisfying splashing sound.

### 5.1.4 hqb_aqua_roam

**unilib.pkg.hqb_aqua_roam.add_to_queue(SELF, PRIORITY, SPEED)**

The default behaviour for many aquatic mobs. The mob chooses a random direction (launching **hqb_aqua_turn** if necessary), then moves towards it at the specified SPEED.

### 5.1.5 hqb_aqua_turn

**unilib.pkg.hqb_aqua_turn.add_to_queue(SELF, PRIORITY, TARGET_YAW, SPEED)**

Called only for aquatic mobs.

Turns towards TARGET_YAW and then sets the mob's velocity to SPEED.

### 5.1.6 hqb_attack

**unilib.pkg.hqb_attack.add_to_queue(SELF, PRIORITY, TARGET_OBJECT)**

Standard attack behaviour for terrestrial mobs.

Waits until the low-level queue is empty. Then, if close enough to TARGET_OBJECT, attacks it (launching a combination of the **lqb_turn_to_pos**, **lqb_jump_attack** and **lqb_dumb_walk** behaviours). Otherwise, this behaviour terminates.

### 5.1.7 hqb_climb_tree

**unilib.pkg.hqb_climb_tree.add_to_queue(SELF, PRIORITY)**

Should be called only for mobs that have the **.can_climb_trees_flag** property.

If the mob is not facing a tree node (including both trunks and leaves), the behaviour terminates immediately.

Otherwise, waits for the low-level queue to be empty, then launches **lqb_climb_tree** to climb the tree.

### 5.1.8 hqb_die

**unilib.pkg.hqb_die.add_to_queue(SELF, PRIORITY)**

Called by most brain packages, which typically check the mob is still alive, before launching a behaviour.

On the first call, makes the mob fall over (**lqb_fall_over**). Then waits a few seconds, before removing the mob from the world.

The PRIORITY argument, if specified, is ignored; this behaviour is always added to the queue with the highest priority.

### 5.1.9 hqb_evade

**unilib.pkg.hqb_evade.add_to_queue(SELF, PRIORITY, TARGET_OBJECT)**

Moves away from TARGET_OBJECT, one waypoint at a time. The behaviour terminates when TARGET_OBJECT is far enough away.

### 5.1.10 hqb_evade_in_liquid_or_air

**unilib.pkg.hqb_evade_in_liquid_or_air.add_to_queue(SELF, PRIORITY, TARGET_OBJECT)**

Called only for flying and swimming mobs.

Waits until the low-level queue is empty, and the mob is not on the ground. Then moves away from TARGET_OBJECT, one waypoint at a time.

### 5.1.11 hqb_find_beehive

**unilib.pkg.hqb_find_beehive.add_to_queue(SELF, PRIORITY)**

Called only for bees.

Assuming that the bee hasn't yet found any pollen, launches **lqb_find_beehive** and then waits, terminating when the bee no longer has pollen (because it was transferred to the beehive).

### 5.1.12 hqb_find_flower

**unilib.pkg.hqb_find_flower.add_to_queue(SELF, PRIORITY, TARGET_POS)**

Called only for bees.

This behaviour launches **lqb_find_flower** and then waits, terminating only when the bee arrives at a flower.

### 5.1.13 hqb_find_land

**unilib.pkg.hqb_find_land.add_to_queue(SELF, PRIORITY)**

Scans for a nearby non-liquid node. If found, approaches it and tries to jump onto it.

If not already in a liquid, the behaviour terminates without doing anything.

### 5.1.14 hqb_find_liquid

**unilib.pkg.hqb_find_liquid.add_to_queue(SELF, PRIORITY)**

Scans for a nearby liquid. If found, approaches it and tries to jump in.

If already in a liquid, the behaviour terminates without doing anything.

### 5.1.15 hqb_fly_alight

**unilib.pkg.hqb_fly_alight.add_to_queue(SELF, PRIORITY, END_STATUS)**

Standard landing behaviour for flying mobs.

If above air, launches the **lqb_fly_alight** behaviour, and waits for the mob to land. If above water, terminates this behaviour and launches **hqb_fly_wander** instead.

Otherwise, the mob is already on the ground. END_STATUS, if specified, is used to set the mob's **.status** property. If its value is "stand", this behaviour launches the **lqb_idle** behaviour; in either case, this behaviour terminates immediately.

### 5.1.16 hqb_fly_attack

**unilib.pkg.hqb_fly_attack.add_to_queue(SELF, PRIORITY, TARGET_OBJECT)**

Standard attack behaviour for flying mobs.

Waits until the low-level queue is empty. Then, if close enough to TARGET_OBJECT, the mob attacks it (**lqb_fly_attack**). Otherwise, this behaviour terminates.

### 5.1.17 hqb_fly_hunt

**unilib.pkg.hqb_fly_hunt.add_to_queue(SELF, PRIORITY, TARGET_OBJECT)**

Standard hunting behaviour for flying mobs.

Waits until the low-level queue is empty. Then, if close enough to TARGET_OBJECT, the mob attacks it (**hqb_fly_attack**). Otherwise it flies towards (or follows) the TARGET_OBJECT (**mtb_fly_to**).

The behaviour terminates when TARGET_OBJECT is too far away or inactive.

### 5.1.18 hqb_fly_liquid_recovery

**unilib.pkg.hqb_fly_liquid_recovery.add_to_queue(SELF, PRIORITY)**

Called by flying mobs in water.

On a continual loop, sets the mob's velocity and acceleration, terminating the behaviour only when the mob is no longer in a liquid.

### 5.1.19 hqb_fly_take_off

**unilib.pkg.hqb_fly_take_off.add_to_queue(SELF, PRIORITY)**

A flying mob on the ground empties its high-level queue, then takes off by launching **lqb_fly_take_off**.

### 5.1.20 hqb_fly_wander

**unilib.pkg.hqb_fly_wander.add_to_queue(SELF, PRIORITY)**

The default roaming behaviour for flying creatures. The mob waits until the low-level queue is empty, then launches **lqb_fly_wander**.

### 5.1.21 hqb_follow

**unilib.pkg.hqb_follow.add_to_queue(SELF, PRIORITY, TARGET_OBJECT)**

The mob follows the TARGET_OBJECT (which might be a player), one waypoint at a time, until the target becomes inactive.

When close enough to TARGET_OBJECT, the mob launches **lqb_idle** and this behaviour continues, with the mob ready to continue following TARGET_OBJECT as soon as it moves away.

### 5.1.22 hqb_follow_and_drop

**unilib.pkg.hqb_follow_and_drop.add_to_queue(SELF, PRIORITY, TARGET_OBJECT)**

The mob follows the TARGET_OBJECT (which might be a player), one waypoint at a time.

When close enough to TARGET_OBJECT, a mob carrying a clutchable item (like a square ball) drops it, and this behaviour terminates. Otherwise, the mob launches **lqb_idle** and this behaviour continues, with the mob ready to continue following TARGET_OBJECT as soon as it moves away.

### 5.1.23 hqb_follow_in_liquid_or_air

**unilib.pkg.hqb_follow_in_liquid_or_air.add_to_queue(SELF, PRIORITY, PLAYER_OBJECT)**

Called only for flying and aquatic mobs.

Makes the mob follow the specified PLAYER_OBJECT, launching **lqb_follow_in_liquid_or_air** to do so.

This behaviour terminates when PLAYER_OBJECT is outside the mob's view range. It also terminates when an aquatic mob is above a non-liquid node. In both cases, **mtb_order_autonomy** is called instead.

### 5.1.24 hqb_goto

**unilib.pkg.hqb_goto.add_to_queue(SELF, PRIORITY, TARGET_POS)**

The mob waits until its low-level queue is empty, then moves towards TARGET_POS, one waypoint at a time.

### 5.1.25 hqb_goto_liquid

**unilib.pkg.hqb_goto_liquid.add_to_queue(SELF, PRIORITY, TARGET_POS)**

TARGET_POS should be a liquid. The mob waits until its low-level queue is empty, then moves towards TARGET_POS, one waypoint at a time. The behaviour terminates upon arrival.

### 5.1.26 hqb_hunt

**unilib.pkg.hqb_hunt.add_to_queue(SELF, PRIORITY, TARGET_OBJECT)**

Standard hunting behaviour for terrestrial mobs.

Waits until the low-level queue is empty. Then, if close enough to TARGET_OBJECT, the mob attacks it (**hqb_attack**). Otherwise it moves towards (or follows) the TARGET_OBJECT, one waypoint at a time.

### 5.1.27 hqb_look_at

**unilib.pkg.hqb_look_at.add_to_queue(SELF, PRIORITY, PLAYER_POS)**

The mob turns its head to look at the player at PLAYER_POS (**mtb_move_head**). A few seconds later, it turns its head back to the neutral position (**mtb_restore_head**).

### 5.1.28 hqb_obey_driver

**unilib.pkg.hqb_obey_driver.add_to_queue(SELF, PRIORITY)**

A behaviour called for mobs that are being ridden by a player. Waits until the mob's low-level queue is empty, then launches the **lqb_obey_driver** behaviour, which responds to the player's (riding) commands.

### 5.1.29 hqb_roam

**unilib.pkg.hqb_roam.add_to_queue(SELF, PRIORITY)**

The default behaviour for many terrestrial mobs. The mob chooses a neighbouring node at random, and calls the **mtb_dumb_step** behaviour to go there, continuing indefinitely.

### 5.1.30 hqb_sleep_until_wake_up

**unilib.pkg.hqb_sleep_until_wake_up.add_to_queue(SELF, PRIORITY, FORCE_FLAG)**

This behaviour should not be called directly; instead, call **unilib.pkg.mtb_fall_asleep.do_action()** (or call **unimobs.petz_api.send_mob_to_sleep()** directly).

Checks whether it's time for the sleeping mob to wake up and, if so, wakes them up.

FORCE_FLAG is true when the mob is sleeping indefinitely (for example, when a cat is placed in a basket). In that case, the mob only wakes up when the basket is destroyed (or the game restarts).

### 5.1.31 hqb_swim_to

**unilib.pkg.hqb_swim_to.add_to_queue(SELF, PRIORITY, TARGET_POS)**

The mob swims towards the specified TARGET_POS, jumping if necessary (**lqb_free_jump**).

### 5.1.32 hqb_terrestrial_jump

**unilib.pkg.hqb_terrestrial_jump.add_to_queue(SELF, PRIORITY)**

The mob jumps in the forward direction, calling the **mtb_set_forward_velocity** behaviour to do so.

This behaviour is not added to the queue at all, when the mob is near water or air (e.g. a cliff)

### 5.1.33 hqb_warn

**unilib.pkg.hqb_warn.add_to_queue(SELF, PRIORITY, TARGET_OBJECT)**

TARGET_OBJECT can be a player or another creature.

If TARGET_OBJECT is too close, the mob attacks it (**hqb_hunt**). Otherwise, the mob turns towards it (**lqb_turn_to_pos**) and occasionally makes warning sounds.

The behaviour terminates when TARGET_OBJECT moves far away.

## 5.2 Low-level behaviours

### 5.2.1 lqb_approach_beehive

**unilib.pkg.lqb_approach_beehive.add_to_queue(SELF)**

Called only for bees which have roamed too far from their hives. The bee moves back in the direction of its hive.

### 5.2.2 lqb_climb_tree

**unilib.pkg.lqb_climb_tree.add_to_queue(SELF)**

This behaviour has been extensively re-written, replacing the original **petz** behaviour which was non-functional.

Checks whether there's a tree that can be climbed (the maximum climbing height is 8). If so, teleports the mob to the top of the tree, giving it a little forward momentum so that it appears to "step" onto the highest node.

### 5.2.3 lqb_dumb_jump

**unilib.pkg.lqb_dumb_jump.add_to_queue(SELF, HEIGHT, ANIMATION)**

The mob, standing on the ground, jumps towards the specified HEIGHT (relative to feet level), using the specified ANIMATION.

### 5.2.4 lqb_dumb_walk

**unilib.pkg.lqb_dumb_walk.add_to_queue(SELF, DESTINATION, SPEED_FACTOR)**

Moves towards the specified DESTINATION, using an appropriate animation. DESTINATION is often a waypoint on a route towards some other location, so will be very close to the mob's current position.

SPEED_FACTOR is optional; its default value is 1. Higher or lower values increase or decrease the creature's walking speed.

### 5.2.5 lqb_fall_over

**unilib.pkg.lqb_fall_over.add_to_queue(SELF)**

Usually launched by the **hqb_die** behaviour upon a mob's death.

Flips the mob over on its side, terminating when the rotation is complete.

### 5.2.6 lqb_find_beehive

**unilib.pkg.lqb_find_beehive.add_to_queue(SELF)**

Called only for bees.

Bees fly towards their hive, "teleporting inside" the hive when they get close enough. The bee's **.has_pollen_flag** property is set back to false, if true (and the hive's pollen and honey counts are incremented).

### 5.2.7 lqb_find_flower

**unilib.pkg.lqb_find_flower.add_to_queue(SELF, TARGET_POS)**

Called only for worker bees.

Moves towards a flower at the specified TARGET_POS. On arrival, the bee's **.has_pollen_flag** property is set to true.

### 5.2.8 lqb_fly_alight

**unilib.pkg.lqb_fly_alight.add_to_queue(SELF)**

Called only for flying mobs.

Gives the mob a slow downwards acceleration, allowing it to land.

### 5.2.9 lqb_fly_attack

**unilib.pkg.lqb_fly_attack.add_to_queue(SELF, TARGET_OBJECT)**

Called only for flying mobs.

Flies towards the TARGET_OBJECT (**mtb_fly_to**), punching it when close enough.

### 5.2.10 lqb_fly_take_off

**unilib.pkg.lqb_fly_take_off.add_to_queue(SELF)**

Called only for flying mobs.

Gives the mob a slow upwards acceleration, allowing it take off.

### 5.2.11 lqb_fly_turn_to_yaw

**unilib.pkg.lqb_fly_turn_to_yaw.add_to_queue(SELF, YAW)**

Turns the mob to the specified YAW, terminating the behaviour when that YAW is reached.

### 5.2.12 lqb_fly_wander

**unilib.pkg.lqb_fly_wander.add_to_queue(SELF, SPEED_FACTOR)**

Called for flying mobs to handle their flight.

The behaviour switches between four modes, depending on conditions. The modes are labelled "ascend", "descend", "stand" and "alight". The code considers switching from one mode to another every 3 seconds.

Depending on the current conditions, this behaviour may terminate to allow another one to start.

SPEED_FACTOR is optional; its default value is 1. Higher or lower values increase or decrease the creature's flying speed.

### 5.2.13 lqb_follow_in_liquid_or_air

**unilib.pkg.lqb_follow_in_liquid_or_air.add_to_queue(SELF, TARGET_OBJECT)**

Called only for flying and swimming mobs.

Calls the **mtb_fly_to** behaviour, terminating immediately afterwards.

### 5.2.14 lqb_free_jump

**unilib.pkg.lqb_free_jump.add_to_queue(SELF)**

An unconditional jump in the direction in which the creature is facing. ("Unconditional" means that even mobs without the **.can_jump_flag** property can call it.)

This behaviour is useful, for example, for getting out of water. The behaviour terminates when the jump apex has been reached, allowing for a controlled landing.

This behaviour is almost identical to the **lqb_short_jump** behaviour, but the magnitude of the jump is slightly bigger.

### 5.2.15 lqb_idle

**unilib.pkg.lqb_idle.add_to_queue(SELF, DURATION, ANIMATION)**

The mob does the specified ANIMATION for DURATION seconds, after which the behaviour terminates.

### 5.2.16 lqb_jump_attack

**unilib.pkg.lqb_jump_attack.add_to_queue(SELF, HEIGHT, TARGET_OBJECT)**

This package provides two separate blocks of code, depending on whether the **unimobs.petz_setting.use_petz_attack_flag** setting is enabled (in the **Minetest** menu, this is "Use jump attacks from petz mod").

Jump towards TARGET_OBJECT at the specified HEIGHT, give or take. Then punch the TARGET_OBJECT.

The behaviour terminates after a punch, or when back on the ground.

### 5.2.17 lqb_obey_driver

**unilib.pkg.lqb_obey_driver.add_to_queue(SELF)**

Called for a mob that's being ridden to a player. Responds to the player's riding commands, changing direction or speed as appropriate.

### 5.2.18 lqb_short_jump

**unilib.pkg.lqb_short_jump.add_to_queue(SELF)**

An unconditional jump in the direction in which the creature is facing. ("Unconditional" means that even mobs without the **.can_jump_flag** property can call it.)

This behaviour is almost identical to the **lqb_free_jump** behaviour, but the magnitude of the jump is slightly smaller.

### 5.2.19 lqb_turn_to_pos

**unilib.pkg.lqb_turn_to_pos.add_to_queue(SELF, TARGET_POS)**

Over several steps, turns the mob in the direction of TARGET_POS. The behaviour terminates when facing TARGET_POS.

## 5.3 Meta-behaviours

### 5.3.1 mtb_attack_player

**unilib.pkg.mtb_attack_player.do_action(SELF, PRIORITY, PLAYER_OBJECT)**

Checks conditions then, if PLAYER_OBJECT is close enough, attacks it using the appropriate behaviour (**hqb_aqua_attack**, **hqb_fly_hunt**, **hqb_hunt**).

For some mobs, the response will be to flee the player instead, launching the **hqb_evade** behaviour.

### 5.3.2 mtb_breed

**unilib.pkg.mtb_breed.do_action(SELF)**

Called by several brain packages.

SELF must be a male creature. If there is a suitable female nearby, she is impregnated.

### 5.3.3 mtb_climb_tree

**unilib.pkg.mtb_climb_tree.do_action(SELF, PRIORITY)**

Checks for an adjacent tree node (including both trunks and leaves). If one is found, launches **hqb_climb_tree** to climb it.

Otherwise, searches for tree nodes within its view range. If one is found, launches **hqb_goto** to approach it.

### 5.3.4 mtb_create_anthill

**unilib.pkg.mtb_create_anthill.do_action(SELF)**

Called only for queen ants.

If the queen is on a suitable node (dirt or sand, no higher than y=8), and if there are no other anthills in the vicinity, then places the anthill schematic at this location.

Note that queens can only create one anthill during their lifetimes.

### 5.3.5 mtb_create_beehive

**unilib.pkg.mtb_create_beehive.do_action(SELF)**

Called only for queen bees.

If there is a tree node in front of the queen (including both trunks and leaves), not higher than the queen's maximum roaming height, then place a beehive at the queen's location.

The queen itself is removed the world, having "teleported inside" the beehive.

### 5.3.6 mtb_dumb_step

**unilib.pkg.mtb_dumb_step.do_action(SELF, HEIGHT, TARGET_POS, SPEED_FACTOR, IDLE_DURATION)**

Tries to move to an adjacent node at TARGET_POS whose height (relative to the mob's current position) is HEIGHT.

First turns in the correct direction (**lqb_turn_to_pos**), then walks (**lqb_dumb_walk**) at a speed specified by SPEED_FACTOR, or jumps (**lqb_dumb_jump**).

Finally, adds the **lqb_idle** behaviour to the queue, to be executed after the turning/walking/jumping behaviours terminate. The mob idles for no longer than the specified IDLE_DURATION (if none is specified, then the maximum idle time is 6 seconds).

### 5.3.7 mtb_fall_asleep

**unilib.pkg.mtb_fall_asleep.do_action(SELF, PRIORITY)**

Depending on the time of day, and on the mob's properties, the mob falls asleep.

The **hqb_sleep_until_wake_up** behaviour is launched automatically (via an API call), and handles waking up.

### 5.3.8 mtb_find_herd

**unilib.pkg.mtb_find_herd.do_action(SELF, PLAYER_OBJECT)**

Looks for nearby mobs of the same type. If none is found, checks whether the PLAYER_OBJECT is wielding a shepherd's crook.

If either is condition is satisfied, launches the **hqb_goto** behaviour to approach the mob(s) or player.

### 5.3.9 mtb_flee_player

**unilib.pkg.mtb_flee_player.do_action(SELF, PRIORITY, PLAYER_OBJECT)**

Sets a new animation, then launches the appropriate behaviour for fleeing PLAYER_OBJECT, **hqb_evade_in_liquid_or_air** or **hqb_evade**.

### 5.3.10 mtb_flee_predator

**unilib.pkg.mtb_flee_predator.do_action(SELF, PRIORITY)**

Checks whether one of the mob's predators is nearby. If so, sets a new animation, then launches the appropriate fleeing behaviour, **hqb_evade_in_liquid_or_air** or **hqb_evade**.

### 5.3.11 mtb_fly_alight

**unilib.pkg.mtb_fly_alight.do_action(SELF, PRIORITY, END_STATUS)**

Called only for flying mobs.

Clears both behaviour queues, updates the mob's animation if necessary, then launches the **hqb_fly_alight** behaviour to attempt a landing.

### 5.3.12 mtb_fly_to

**unilib.pkg.mtb_fly_to.do_action(SELF, TARGET_OBJECT)**

Sets the mob's direction and velocity, so that it flies towards TARGET_OBJECT.

### 5.3.13 mtb_hunt_prey

**unilib.pkg.mtb_hunt_prey.do_action(SELF, PRIORITY, FORCE_FLAG)**

Called by several brain packages, not just **brain_predator**.

Looks for nearby prey and, if one is found, launches the **hqb_hunt** behaviour to hunt it, using the specified PRIORITY.

If FORCE_FLAG is specified, then this mob can hunt other creatures, even when it is tamed.

### 5.3.14 mtb_lay_ant_egg

**unilib.pkg.mtb_lay_ant_egg.do_action(SELF)**

Called only for queen ants.

If there is air in front the queen, and an anthill bed node beneath it, then lays eggs.

### 5.3.15 mtb_look_at

**unilib.pkg.mtb_look_at.do_action(SELF, PRIORITY, PLAYER_POS)**

Decides whether it's appropriate for the mob to look at a nearby player at PLAYER_POS. If so, launches the **hqb_look_at** behaviour with the specified PRIORITY.

### 5.3.16 mtb_move_head

**unilib.pkg.mtb_move_head.do_action(SELF, TARGET_POS)**

Rotates the mob's head towards the specified TARGET_POS, which is often the position of a nearby player.

### 5.3.17 mtb_order_autonomy

**unilib.pkg.mtb_order_autonomy.do_action(SELF)**

Clears both behaviour queues, then launches the appropriate roaming behaviour for the mob's current situation: **hqb_fly_wander**, **hqb_aqua_roam** or just **hqb_roam**.

### 5.3.18 mtb_order_follow

**unilib.pkg.mtb_order_follow.do_action(SELF, PLAYER_OBJECT)**

Follows the PLAYER_OBJECT, launching the appropriate behaviour for the mob's current situation: **hqb_follow_in_liquid_or_air**, **hqb_follow_in_liquid_or_air** or just **hqb_follow**.

### 5.3.19 mtb_order_guard

**unilib.pkg.mtb_order_guard.do_action(SELF)**

Sets the mob's **.status** property to "guard", clears the high-level queue, and then calls **mtb_order_stand** to set velocity and acceleration to zero.

Other packages - for example, **mtb_attack_player** - will, in some situations, only launch an attack on the player when the mob's **.status** is "guard".

### 5.3.20 mtb_order_stand

**unilib.pkg.mtb_order_stand.do_action(SELF)**

Commonly called after the meta-behaviours **mtb_order_guard** and **mtb_order_stand_here** are executed.

Sets the mob's velocity and acceleration to zero.

### 5.3.21 mtb_order_stand_here

**unilib.pkg.mtb_order_stand_here.do_action(SELF)**

Commonly called after the player clicks a button in the main mob formspec (but can be called by anything).

Sets the correct animation, set's the mob's **.status** property, and then calls **mtb_order_stand** to set velocity and acceleration to zero.

### 5.3.22 mtb_replace_node_or_lay_egg

**unilib.pkg.mtb_replace_node_or_lay_egg.do_action(SELF)**

The mob tries to replace a node with a different one (for example, a sheep eats turf, replacing a dirt-with-turf node with a plain dirt node).

On success, the mob's milk, wool (etc) is replenished, if possible. On failure, an egg-laying mob can try to lay an egg.

### 5.3.23 mtb_rescue_suffocating_mob

**unilib.pkg.mtb_rescue_suffocating_mob.do_action(SELF)**

Standard emergency suffocation recovery check, called by many brain packages.

When a mob gets stuck inside a node (as tends to happen quite frequently), teleport it to a nearby air node.

The recovery system is not used on flying mobs, which could otherwise escape any enclosure through its roof.

### 5.3.24 mtb_restore_head

**unilib.pkg.mtb_restore_head.do_action(SELF)**

After an earlier call to **mtb_move_head**, rotates the mob's head back to its original (forward) position.

### 5.3.25 mtb_set_forward_velocity

**unilib.pkg.mtb_set_forward_velocity.do_action(SELF, VELOCITY_VECTOR)**

Sets the mob's velocity to the specified VELOCITY_VECTOR, relative to its current yaw.

### 5.3.26 mtb_show_fear

**unilib.pkg.mtb_show_fear.do_action(SELF, TARGET_POS)b**

Calls **mtb_turn_away_from_danger** to turn away from the player or creature at TARGET_POS, also setting the mob's vertical velocity to zero.

### 5.3.27 mtb_start_following

**unilib.pkg.mtb_start_following.do_action(SELF, PRIORITY, PLAYER_OBJECT)**

Checks whether PLAYER_OBJECT is wielding one of the items that attracts this mob.

If so, launches the appropriate following behaviour, **hqb_follow_in_liquid_or_air** or **hqb_follow**.

### 5.3.28 mtb_start_repelling

**unilib.pkg.mtb_start_repelling.do_action(SELF, PRIORITY, PLAYER_OBJECT)**

Checks whether PLAYER_OBJECT is wielding one of the items that repels this mob.

If so, launches the appropriate evasion behaviour, **hqb_evade_in_liquid_or_air** or **hqb_evade**.

### 5.3.29 mtb_stop_following

**unilib.pkg.mtb_stop_following.do_action(self, player)**

Called for a mob which is following the PLAYER_OBJECT because they are wielding a particular item.

If PLAYER_OBJECT is not specified, or if the player in no longer wielding the right item, then **mtb_order_autonomy** is called. Otherwise, do nothing.

### 5.3.30 mtb_stop_repelling

**unilib.pkg.mtb_stop_repelling.do_action(SELF, PLAYER_OBJECT)**

Called for a mob which is moving away from the PLAYER_OBJECT because they are wielding a particular item.

If PLAYER_OBJECT is not specified, or if the player is no longer wielding the right item, then **mtb_order_autonomy** is called. Otherwise, do nothing.

### 5.3.31 mtb_straggle_parents

**unilib.pkg.mtb_straggle_parents.do_action(SELF)**

Called for baby mobs. If it is near any adults of the same type (actually, one of the adults specified in the **.straggle_type_list** property), then launch the **hqb_goto** behaviour to approach them.

### 5.3.32 mtb_teleport_behind_player

**unilib.pkg.mtb_teleport_behind_player.do_action(SELF, PLAYER_OBJECT, PARTICLE_TYPE)**

Teleports the mob to a position behind the specified PLAYER_OBJECT. No teleportation occurs if there is a node at that position, rather than air.

If **PARTICLE_TYPE** is specified, it is emitted.

### 5.3.33 mtb_turn_away_from_danger

**unilib.pkg.mtb_turn_away_from_danger.do_action(SELF, DANGER_POS)**

Turns the mob to face the opposite direction to DANGER_POS; the mob is then free to move in that direction, if required.

# 6. Engine settings

**Minetest** settings can be configured in the usual way:

- In **Minetest**'s main menu, create a new world, click the Settings button in the top right corner
- In the left panel, scroll down and select **Unified Voxel Library (unilib)**
- **unimobs** settings are now visible in the right panel
- Hover over the **(i)** button for an explanation of each setting

Unfortunately, there is currently no way to divide these settings into groups; but you can consult the **settingtypes.txt** file, if you need that.

Most settings are self-explanatory, or are described elsewhere in the documentation. This section adds some additional information.

## 6.1 Accessing settings in code

Two parts of the code read engine settings, and assign them to global variables:

- ../lib/system/main.lua
- ../lib/system/petz/petz_settings.lua

### 6.1.1 unimobs settings

These settings apply to all mobs, brains, behaviours and/or items.

**unimobs.setting.tweak_mobkit_engine_flag** (default: true)

As mentioned above, code in the **mobkit** mod is duplicated by the **kitz** mod. Most of the duplicated code is identical, but there are some differences.

In most cases, the version of the code found in **kitz** was a little better, or more advanced, or more flexible. Therefore that's the version used by default; however you can change this setting to false, if you need to use the original **mobkit** code for any reason.

**unimobs.setting.apply_tool_wear_flag** (default: true)

In the original **petz** code, wear did not apply to tools such as lassos and nets. In **unimobs**, wear does apply by default; change this setting to false if you want everlasting lassos and nets.

**unimobs.setting.enable_creative_bonus_flag** (default: false)

Some game mechanics require the player to do some work, perhaps a lot of work. You can change the value of this setting to true if you want to reduce the amount of work to be done.

When true, the DNA analyser requires no fuel, and newly-crafted sketchbooks are already full. More items may be affected by this setting in the future.

### 6.1.2 Engine settings

There is a single **unimobs** setting which has the same value as the engine's setting, by default.

**unimobs.setting.abr** (default: 3)

The number of active (map) blocks around the player that are loaded and updated by the engine; it's also used when deciding where mobs are allowed to spawn.

### 6.1.3 wildlife mod settings

These settings apply only to simple deer and simple wolves (the creatures from the **wildlife** mod).

There is a separate spawning system for these mobkit-exclusive creatures (in the **opt_wildlife** package). It's independent from the system used to spawn petz-compatible creatures.

**unimobs.setting.wildlife_spawn_probability** (default: 0.3)

The probability of spawning a creature when there are no other creatures in the active block range. Must be a float in the range 0 to 1, where 0 means "never spawn", and 1 means "always spawn".

**unimobs.setting.wildlife_spawn_reduction_factor** (default: 0.2)

As a population control measure, the spawn probability is reduced by this factor for every creature in the player's active block range. Must be a float in the range 0 to 1, where larger numbers apply a greater reduction.

### 6.1.4 petz settings

The remainining settings apply to petz-compatible mobs.

The values of these settings are stored in a different namespace, **unimobs.petz_setting**. We'll describe just one of them here.

**unimobs.petz_setting.remove_list** (default: an empty list)

(In **setting_types.txt**, the default value is an empty string; the string is converted into a list when imported into global variables.)

A list of strings, e.g. "lion", "lion_normal". Any creatures whose entity names (e.g. **unilib:mob_lion_normal**) match any of the strings in this list are actively removed from the world.

Note that this is a different mechanism from the one described above, in which we add or remove mobs from the **mob_settings.csv** file. Removing creatures from that file will stop them from spawning; changing this setting will not only prevent spawning, but will completely remove existing creatures from your game.

# 7. Global variables and shared functions

Three parts of the code initialise global variables:

- ../lib/system/main.lua
- ../lib/system/petz/petz_api.lua
- ../lib/system/petz/petz_settings.lua

Shared functions - those which are available to all parts of the code - can be divided into two groups:

- Shared system functions, found in ../lib/system/
- Shared package functions, found in ../lib/packages/

The **unimobs** API is comprised of the shared system functions; we don't consider packages to be a part of the API.

All API functions are describe in the section below.

## 7.1 Namespaces

For clarity, global variables are divided into several separate namespaces.

- **unimobs.constant** for constant values
- **unimobs.global** for variables
- **unimobs.setting** for engine settings

Variables and settings imported from the **petz** modpack have their own set of namespaces; these are for use with all petz-compatible mobs, not just those imported directly from **petz**.

- **unimobs.petz_const** for constant values
- **unimobs.petz_global** for variables
- **unimobs.petz_setting** for engine settings
- **unimobs.petz_msetting** for settings specifed by the remix (see below)

API functions are divided into the following separate namespaces, again for clarity.

- **unimobs.mobkit_api** for functions imported from the **mobkit** mod
- **unimobs.kitz_api** for functions imported from the **kitz** mod
- **unimobs.petz_api** for functions imported from the **petz** mod
- **unimobs.misc_api** for functions imported from other mods

In general, mobkit-exclusive mobs should not call **unimobs.kitz_api** or **unimobs.petz_api** functions (although doing so may be appropriate, in some circumstances; consult the API section below or examine the function code directly).

## 7.2 Remix mob settings

The remix provides two files used to configure petz-compatible mobs. The files are **mob_settings.csv** and **constants.csv**, and they are described in detail above.

The contents of these files are read into memory by the **meta_petz_settings** package, and any constants are converted. The data is then available to code in the global table, **unimobs.petz_msetting**.

The table's keys are the mob's internal names (corresponding to their **.mob_type** property); mobkit-exclusive mobs are not included.

Each key has a corresponding value in the form of a data table, for example:

        unimobs.petz_msetting.cat_normal = { ... }
        unimobs.petz_msetting.lion_normal = { ... }
        unimobs.petz_msetting.monster_evil_santa = { ... }

The data table consists of a series of key-value pairs; each key is one of the settings read from **mob_settings.csv**. For example:

        unimobs.petz_msetting.cat_normal.disable_spawn_flag

The settings are as follows:

- **.disable_spawn_flag** - Flag that can be set to true, temporarily, to prevent mobs from spawning naturally (some mobs, such as ants and bees, spawn because of code in separate packages so are not affected by this setting)
- **.custom_spawn_probability** - The probability of spawning at suitable locations; a float in the range 0-1 (e.g. 0.6)
- **.spawn_node_table** - A lookup table, whose keys are node names. If the table is empty, the mob can spawn in/on any node. Otherwise, the mob can spawn only in/on the specified nodes
- **.spawn_node_all_flag** - Flag set to true if **.spawn_node_table** is empty
- **.spawn_biome_table** - A lookup table, whose keys are biome names. If the table is empty, the mob can spawn in any biome. Otherwise, the mob can spawn only in the specified biomes
- **.spawn_biome_all_flag** - Flag set to true if **.spawn_biome_table** is empty
- **.spawn_max_height** - Maximum spawn height (if specified, an integer)
- **.spawn_min_height** - Minimum spawn height (if specified, an integer)
- **.spawn_herd_size** - The maximum size of a spawned herd. If specified, the minimum value is 1, the maximum is **unimobs.petz_setting.max_spawn_herd_size** (5 by default). If not specified, the mob never spawns in herds
- **.predator_list** - List of mobs that are predators of this mob (e.g. **unilib:mob_lion_normal**)
- **.prey_list** - List of mobs that are hunted by this mob (e.g. **unilib:mob_sheep_normal**)
- **.repel_item_table** - A lookup table, whose keys are full node/craftitem/tool names. The mob is repelled by all specified items
- **.repel_item_first** - The first item that was added to **.repel_item_table**, if any
- **.repel_item_none_flag** - Flag set to true if **.repel_item_table** is empty
- **.follow_item_table** - A lookup table, whose keys are full node/craftitem/tool names. The mob is attracted to all the specified items
- **.follow_item_first** - The first item that was added to **.follow_item_table**, if any
- **.follow_item_none_flag** - Flag set to true if **.follow_item_table** is empty
- **.feed_item_table** - A lookup table, whose keys are full node/craftitem/tool names. The specified items can be used to feed the mob
- **.feed_item_first** - The first item that was added to **.feed_item_table**, if any
- **.feed_item_none_flag** - Flag set to true if **.feed_item_table** is empty
- **.custom_tame_count** - The number of times needed to feed the mob, in order to tame it; if not specified, then **unimobs.petz_setting.default_tame_count** applies (default 5)
- **.breed_item_table** - A lookup table, whose keys are full node/craftitem/tool names. The specified items can be used to breed the mob
- **.breed_item_first** - The first item that was added to **.breed_item_table**, if any
- **.breed_item_none_flag** - Flag set to true if **.breed_item_table** is empty
- **.max_mating_distance** - The maximum distance between two mobs in order to produce a baby (default 0)
- **.convert_with_table** - A lookup table, whose keys are full node/craftitem/tool names. The specified items can be used to convert the mob from one type to another (e.g. convert wolves to dogs)
- **.convert_with_first** - The first item that was added to **.convert_with_table**, if any
- **.convert_with_none_flag** - Flag set to true if **.convert_with_table** is empty
- **.convert_to** - The name of the mob that's the result of a conversion, e.g. **unilib:mob_dog_normal**
- **.custom_convert_count** - The number of times the mob must be fed, in order to convert it; if not specified, then **unimobs.petz_setting.default_convert_count** applies (default 5)
- **.harmful_node_data_list** - A list of mini-tables describing nodes that can damage the mob (in addition to fire, lava and so on). Each mini-table is in the form:

        {name = "air", damage = 1, where = "entity"},
        {name = "unilib:grass_ordinary_1", damage = 1, where = "stand"},

The **.name** field is compulsory, but the others are optional. **.damage** is 1, if not specified. **.where** has the value "entity" representing the entity's position, or "stand" representing their standing position (default is "stand").

- **.custom_table** - A table of custom settings used by a single mob, or by a small group of mobs. Packages retrieving this setting should specify default values, in case they have been omitted in **mob_settings.csv**. Here is a code example from the **mob_beaver_normal** package:

        unimobs.petz_api.initialise_custom_msetting("beaver_normal", "can_create_beaver_dam", true)

The custom settings used by built-in mobs, and their default values, are as follows:

        .can_create_beaver_dam=true     (for unimobs:mob_beaver_normal)
        .cocoon_max_time=1500           (for unimobs:mob_silkworm_normal)
        .cocoon_min_time=1200           (for unimobs:mob_silkworm_normal)
        .custom_lay_egg_interval=1200   (for unimobs:mob_ant_queen)
        .custom_lifespan=3600           (not used by any built-in mob)
        .custom_max_laid_eggs=50        (for unimobs:mob_ant_queen)
        .custom_max_laid_eggs=1         (for unimobs:mob_gecko_normal)
        .is_dyeable=true                (for unimobs:mob_sheep_normal)
        .lay_egg_max_time=240           (for unimobs:mob_moth_normal)
        .lay_egg_min_time=150           (for unimobs:mob_moth_normal)
        .lay_egg_on_node=group:leaves   (for unimobs:mob_silkworm_normal)
        .max_population=5               (for unimobs:mob_ant_queen)
        .spawn_month=12                 (for unimobs:mob_monster_evil_santa)
        .spawn_month=10                 (for unimobs:mob_monster_mr_pumpkin)

## 7.3 Accessing remix mob settings

Typically, values in **unimobs.petz_msetting** are not accessed directly, but through a number of convenience functions. They are described in full in the API section below.

## 7.4 Global constants

These are the remaining global constants and their values.

**unimobs.constant.gravity** (value: -9.81)

Note that the original code used the value -9.8.

**unimobs.constant.abs_gravity** (value: 9.81)

This value is (slightly) useful in some calculations.

**unimobs.constant.friction** (value: 0.4)

Inert entities will slow down when in contact with the ground. The smaller the number, the greater the effect.

**unimobs.constant.terminal_velocity** (value: approx. 20)

A 20-metre fall is usually fatal.

**unimobs.constant.safe_velocity** (value: approx. 5)

A 5-metre fall is safe.

**unimobs.constant.tool_wear** (value: 1024)

The wear applied to unimob tools, every time they are used (but only when **unimobs.setting.apply_tool_wear_flag** is true).

### 7.4.1 Global constants for petz-compatible mobs

These values should not be changed.

**unimobs.kitz_const.default_max_hear_distance** (value: 5)

**unimobs.kitz_const.default_feed_rate** (value: 0.3)

**unimobs.petz_const.visual** (value: "mesh")

**unimobs.petz_const.visual_size** (value: {x=10, y=10} )

**unimobs.petz_const.rotate** (value: 0)

**unimobs.petz_const.colour_table** (a table translating the keys "green" and "red" into RGB strings)

## 7.5 Global variables

These are the remaining global variables.

**unimobs.global.active_mob_table**

A table used only when **unimobs.setting.tweak_mobkit_engine_flag** is true. Table in the form

        active_mob_table[mob_id] = mob_luaentity

...where **mob_id** is the value mob's **._id** property. This table should only be modified by system code.

**unimobs.global.forbidden_spawn_table**

A table of mobs that must not be spawned naturally; includes mobs like ants and bees which are "spawned" using custom code. Mobs can be added to the table directly; here's a code example from the **mob_ant_misc** package.

        -- Queens can spawn naturally, but workers/warriors cannot
        if variant_table[variant]["forbidden_spawn_flag"] then
            unimobs.global.forbidden_spawn_table[mob_type] = true
        end

**unimobs.global.spawnegg_lookup_table**

Converts a mob's entity name into the name of its spawn egg. Table in the form

        spawnegg_lookup_table["unilib:mob_duck_normal"] = "unilib:spawnegg_duck_normal"

As described above, this table should be populated by a call to **unimobs.petz_api.register_spawnegg()**, immediately after a successful call to **unimobs.petz_api.register_mob()**. The table is updated automaticaly during calls to **unimobs.petz_api.register_standard_mob()**.

### 7.5.1 Global variables for petz-compatible mobs

**unimobs.petz_global.mob_list**

A list of mob internal names (matching each mob's **.mob_type** property, e.g. "lion_normal"). Packages should call **unimobs.petz_api.register_mob()** to populate this list.

**unimobs.petz_global.mob_table**

A table whose keys are the same as those used in **unimobs.petz_global.mob_list**. The corresponding values are data tables, which contain the following key-value pairs:

- **.mob_name** - matches the entity name, e.g. **unilib:mob_lion_normal**
- **.description** - matches the entity's description, e.g. "Lion (Normal)"
- **.collisionbox**, **.genetic_init_list**, **.mesh**, **.skin_init_list**, **.visual_size** - copies of the values stored in the mob's **.initial_properties** field (and not easily accessible without this table)
- **.genetic_range_table** - derived from **.genetic_init_list**, a lookup table with minimum/maximum values for each gene of the category "range", in the form:

        genetic_range_table[gene_type] = {
            initial_min = value,
            initial_max = value,
            overall_min = value,
            overall_max = value,
        }

Use the convenience function **unimobs.petz_api.get_genetic_range_table()** to quickly access those values.

- **.insertion_table** - table providing substitutions for visible translated text, in the form described above
- **.version** - a code version for this mob. When the game starts, pre-existing mobs are checked in case any major updates need to be applied. At the moment, all built-in mobs have a **.version** with the value 1, so no updates are applied

**unimobs.petz_global.mob_remove_list**

A list of strings matching the entity name or internal name for any mob that should be removed from the game (so both "lion" and "lion_nor" would remove the entity **unilib:mob_lion_normal**).

When strings are added to this list, the corresponding packages are still loaded (as long as that package is specified by a remix). Also, **unilib.register_entity()** is still called, but the corresponding spawn egg is not created.

See also the **unimobs.petz_api.set_initial_properties()** function, which will remove any matching entities from the world.

Note that items added to the **Minetest** setting **unimobs.petz_setting.remove_list** are automatically added to this list. Any code can add more items to the list, when necessary.

**unimobs.petz_global.formspec_player_table**

A table of players who currently have the main mob formspec open; this table should only be modified by system code.

# 8. API

This section describes the complete **unimobs** API - the shared functions found in **../lib/system**.

Shared functions provided by packages are not considered part of the API, so are not described in this document.

Note that some functions and/or their arguments are poorly understood, due to inadequate documentation in the original mods. Note also that some functions may have been designed to be called only by system code; when possible, those functions are marked.

## 8.1 API functions derived from mobkit

### 8.1.1 mobkit_callbacks.lua

**unimobs.mobkit_api.default_brain_callback(self)**

*Was mobkit.default_brain(), duplicated by kitz.default_brain()*

Default brain function for any mob that doesn't define its own brain function (see above for details of how brains are implemented). Launches the **hqb_roam** behaviour (which continues indefinitely).

**unimobs.mobkit_api.default_physics_callback(self, col_info_table)**

*Was mobkit.physics(), duplicated by kitz.physics()*

The default physics callback.

This function's behaviour differs when **unimobs.setting.tweak_mobkit_engine_flag** is set.

**unimobs.mobkit_api.get_staticdata_callback(self)**

*Was mobkit.statfunc(), duplicated by kitz.statfunc()*

Callback for the mob entity's **.get_staticdata** field.

Returns a string that will be passed to an object's **.on_activate()**, the next time the object is instantiated.

**unimobs.mobkit_api.on_activate_callback(self, staticdata, dtime_s)**

*Was mobkit.actfunc(), duplicated by kitz.actfunc()*

Standard **.on_activate()** callback for all mob entities. Called when an object is instantiated.

This function's behaviour differs when **unimobs.setting.tweak_mobkit_engine_flag** is set.

**unimobs.mobkit_api.on_step_callback(self, dtime, col_info_table)**

*Was mobkit.stepfunc(), duplicated by kitz.stepfunc()*

Callback for the entity's **.on_step()** field. Called on every server tick, after movement and collision processing.

**unimobs.mobkit_api.sensors_callback()**

*Was sensors()*

Scans the mob's vicinity, updating its **.nearby_obj_list** property.

### 8.1.2 mobkit_failsafes.lua

**unimobs.mobkit_api.on_die_failsafe(self)**

*Original to unimobs*

Failsafe function for use when **unilib.pkg.hqb_die.add_to_queue()** is not available, also replacing *mobkit.hq_die()* / *kitz.hq_die()*.

### 8.1.3 mobkit_memory.lua

For more information about mob memories and how to use them, see the section above.

**unimobs.mobkit_api.add_mob_memory(self, key, val)**

*Was mobkit.remember(), duplicated by kitz.remember()*

Permanently store a key-value pair in the specified mob's long-term "memory".

**unimobs.mobkit_api.forget_mob_memory(self, key)**

*Was mobkit.forget(), duplicated by kitz.forget()*

Clears a key-value pair from the specified mob's long-term "memory".

**unimobs.mobkit_api.recall_mob_memory(self, key)**

*Was mobkit.recall(), duplicated by kitz.recall()*

Retrieves the value of the specified key from the specified mob's long-term "memory".

### 8.1.4 mobkit_queue.lua

For more information about behaviour queues, see the section above.

**unimobs.mobkit_api.add_to_high_level_queue(self, name, func, priority)**

*Was mobkit.queue_high(), duplicated by kitz.queue_high()*

Adds a behaviour definition to the high-level queue. This function is only for use in behaviour packages.

*CHANGES TO ORIGINAL MOBKIT BEHAVIOUR:* The behaviour's **name** (usually matching its package name) should be specified, so it can be displayed when required. The **priority** argument can be -1, which means "this behaviour automatically has the highest priority".

**unimobs.mobkit_api.add_to_low_level_queue(self, name, func)**

*Was mobkit.queue_low(), duplicated by kitz.queue_low()*

Adds a behaviour definition to the low-level queue. This function is only for use in behaviour packages.

*CHANGES TO ORIGINAL MOBKIT BEHAVIOUR:* The behaviour's **name** (usually matching its package name) should be specified, so it can be displayed when required.

**unimobs.mobkit_api.clear_both_queues(self)**

*Original to unimobs*

A convenience function for emptying both behaviour queues; a bit quicker than calling **.clear_high_level_queue()** and **.clear_low_level_queue()** consecutively.

**unimobs.mobkit_api.clear_high_level_queue(self)**

*Was mobkit.clear_queue_high(), duplicated by kitz.clear_queue_high()*

Empties the high-level queue.

**unimobs.mobkit_api.clear_low_level_queue(self)**

*Was mobkit.clear_queue_low(), duplicated by kitz.clear_queue_low()*

Empties the low-level queue.

**unimobs.mobkit_api.execute_queues(self)**

*Was execute_queues()*

Called by **unimobs.mobkit_api.on_step_callback()**.

Executes the first high-level behaviour (if any), and then the first low-level behaviour (if any).

**unimobs.mobkit_api.get_queue_priority(self)**

*Was mobkit.get_queue_priority(), duplicated by kitz.get_queue_priority()*

Returns the priority of the highest-priority behaviour in the high-level queue; this is the behaviour that's currently running.

**unimobs.mobkit_api.is_behaviour_in_high_level_queue(self, name)**

*Original to unimobs*

Returns true if the named behaviour is in the high-level queue, false if not.

**unimobs.mobkit_api.is_behaviour_in_low_level_queue(self, name)**

*Original to unimobs*

Returns true if the named behaviour is in the low-level queue, false if not.

**unimobs.mobkit_api.is_high_level_queue_empty(self)**

*Was mobkit.is_queue_empty_high(), duplicated by kitz.is_queue_empty_high()*

Returns true if the high-level queue is empty, false otherwise.

**unimobs.mobkit_api.is_low_level_queue_empty(self)**

*Was mobkit.is_queue_empty_low(), duplicated by kitz.is_queue_empty_low()*

Returns true if the low-level queue is empty, false otherwise.

### 8.1.5 mobkit_utils.lua (from mobkit/init.lua)

**unimobs.mobkit_api.apply_damage(luaent, val, reason)**

*Was mobkit.hurt(), duplicated by kitz.hurt()*

Decrease the specified luaentity's **.hp** by **val**.

Returns true if the luaentity exists and damage can be applied to it; false otherwise (this is a change to the original **mobkit** code, which returned nil or false).

**reason** is optional (it was used in the original **kitz** code, but not in the corresponding original **mobkit** code).

This function's behaviour differs when **unimobs.setting.tweak_mobkit_engine_flag** is set.

**unimobs.mobkit_api.check_main_timer(self, interval)**

*Was mobkit.timer(), duplicated by kitz.timer()*

Returns true approximately once every **interval** seconds, otherwise false.

Used to prevent execution of any code that doesn't necessarily need to run on every engine step.

**unimobs.mobkit_api.check_vitals(self)**

*Was mobkit.vitals(), duplicated by kitz.vitals()*

Checks for drowning and fall damage. This function should be called before checking a mob's **.hp**.

**unimobs.mobkit_api.convert_dir_to_rot(dir, rot)**

*Was mobkit.dir_to_rot(), duplicated by kitz.dir_to_rot()*

Converts a 3d vector **dir** to a **Minetest** rotation vector in the form returned by **core.set_rotation()**, i.e. (pitch, yaw, roll).

**rot** is optional; if specified, it is the current object rotation.

**unimobs.mobkit_api.convert_rot_to_dir(rot)**

*Was mobkit.rot_to_dir(), duplicated by kitz.rot_to_dir()*

Converts a **Minetest** rotation vector - in the form returned by **core.set_rotation()**, i.e. (pitch, yaw, roll) - into a direction unit vector.

**rot** must be in the range ( -pi/2, pi/2 ).

**unimobs.mobkit_api.do_entity_animation(self, anim)**

*Was mobkit.animate(), duplicated by kitz.animate()*

Makes the entity **self** play the animation **anim** (a string like "stand").

Does nothing if the animation is not defined, or if the same animation is already running.

**unimobs.mobkit_api.do_entity_sound(self, sound)**

*Was mobkit.make_sound(), duplicated by kitz.play_sound()*

Makes the entity **self** play the specified **sound** (a string like "warn"), or does nothing if the specified **sound** is not defined.

Returns the sound handle.

**unimobs.mobkit_api.does_object_exist(obj)**

*Was mobkit.exists(), duplicated by kitz.exists()*

Checks whether the specified object exists in the world.

**obj** can be a luaentity or ObjectRef; this function is used for stored luaentities and ObjectRefs.

**unimobs.mobkit_api.get_closest_entity(self, name)**

*Was mobkit.get_closest_entity(), duplicated by kitz.get_closest_entity()*

Returns the closest entity named **name**, or nil if no such entity is found nearby.

This function's behaviour differs when **unimobs.setting.tweak_mobkit_engine_flag** is set.

**unimobs.mobkit_api.get_closest_entity_to_pos(pos, name)**

*Original to unimobs*

An alternative to **unimobs.mobkit_api.get_closest_entity(**), in which we find the closest entity to the specified **pos**, returning nil if no entity is found.

The **name** argument is optional; if not specified, any entity which satisfies the **unimobs.mobkit_api.is_object_alive()** test is returned.

**unimobs.mobkit_api.get_collision_box_bottom(self)**

*Was mobkit.get_hitbox_bottom(), duplicated by kitz.get_hitbox_bottom()*

Gets the position of the bottom of the object's collisionbox.

**unimobs.mobkit_api.get_collision_box_height(obj)**

*Was mobkit.get_box_height(), duplicated by kitz.get_box_height()*

Returns the height of the specified object's collision box.

**unimobs.mobkit_api.get_columns_displaced_by_node_box(pos, node_box, vec, dist)**

*Was mobkit.get_box_displace_cols(), duplicated by kitz.get_box_displace_cols()*

Returns a list of items representing columns, in the form {x=n, z=n}.

Each column is displaced by the **node_box** (e.g. a collision box), when it is at the position **pos** and moves in the horizontal vector **vec**.

If **dist** is specified, then the vector **vec** is normalised (i.e. reduced to a length of 1), before being multipled by the **dist** itself.

**unimobs.mobkit_api.get_columns_intersected_by_node_box(pos, node_box)**

*Was mobkit.get_box_intersect_cols(), duplicated by kitz.get_box_intersect_cols()*

Returns a list of items representing columns, in the form {x=n, z=n}.

Each column is intersected by the **node_box** (e.g. a collision box), when it is at the position **pos**.

**unimobs.mobkit_api.get_dot_product(v1, v2)**

*Was mobkit.dot(), duplicated by kitz.dot()*

Returns the dot product of two vectors.

**unimobs.mobkit_api.get_feet_pos(obj)**

*from mobkit/init.lua, commented out in original code*

Returns the object's pos projected onto the bottom face of its collisionbox (only); compare **unimobs.mobkit_api.get_standing_pos()**.

**obj** can be a luaentity or ObjectRef.

**unimobs.mobkit_api.get_min_value_within_range(v, m)**

*Was mobkit.minmax(), duplicated by kitz.minmax()*

Returns **v** trimmed to the range (**-m**, **m**).

**unimobs.mobkit_api.get_name_of_node_at_vector(pos, vec)**

*Was mobkit.get_nodename_off(), duplicated by kitz.get_nodename_off()*

Gets the name of the node at the specified vector **vec** from **pos**.

**unimobs.mobkit_api.get_node_defn_at_pos(pos)**

*Was mobkit.nodeatpos(), duplicated by kitz.nodeatpos()*

Returns the definition of the node at the specified **pos**, or nil if it's an ignore node.

**unimobs.mobkit_api.get_node_height(pos)**

*Was mobkit.get_node_height(), duplicated by kitz.get_node_height()*

Returns three values which are not descibed by original **mobkit** documentation.

This function's behaviour differs when **unimobs.setting.tweak_mobkit_engine_flag** is set.

**unimobs.mobkit_api.get_pos_of_node_centre(pos)**

*Was mobkit.get_node_pos(), duplicated by kitz.get_node_pos()*

Returns **pos** tweaked so that it's the centre of the node, e.g. {x = 10.5, y = 51.5, z = 0.5}

**unimobs.mobkit_api.get_random_nearby_entity(self, name)**

*Was mobkit.get_nearby_entity(), duplicated by kitz.get_nearby_entity()*

Returns a random entity from those that are nearby, or nil if no entities are nearby.

**unimobs.mobkit_api.get_random_nearby_player(self)**

*Was mobkit.get_nearby_player(), duplicated by kitz.get_nearby_player()*

Returns a random player from those that are nearby, or nil if no players are nearby.

This function's behaviour differs when **unimobs.setting.tweak_mobkit_engine_flag** is set.

**unimobs.mobkit_api.get_spawn_pos(dtime, interval, radius, chance, reduction)**

*Was mobkit.get_spawn_pos_abr(), duplicated by kitz.get_spawn_pos_abr()*

Returns a potential spawn position at random intervals.

Arguments:

- dtime (float): Time interval
- interval (float): Average spawn attempt interval for every player
- radius (int): Spawn distance in nodes, the engine's active block range (i.e. **unimobs.setting.abr**) multiplied by 16 is recommended
- chance (float): Value in the range 0-1. The chance of spawning a mob if there are no other objects in the area
- reduction (float): Value in the range 0-1. The spawn chance is reduced by this factor for every object in the area

Return values:

- nil for nothing to spawn, or items in the form (suggested_pos, liquid_flag)

Usage:

        core.register_globalstep(function(dtime)
            local spawn_pos = unimobs.mobkit_api.get_spawn_pos(...)
            if spawn_pos then
                [LOGIC GOES HERE]
            end
        end)

**unimobs.mobkit_api.get_spawn_pos_kitz(abr)**

*Was kitz.get_spawn_pos_abr()*

An alternative to **unimobs.mobkit_api.get_spawn_pos()**, called only by code imported from **kitz**.

Returns a potential spawn position at random intervals.

**unimobs.mobkit_api.get_standing_pos(obj)**

*Was mobkit.get_stand_pos(), duplicated by kitz.get_stand_pos()*

Returns the object's pos projected onto the bottom face of its collisionbox, and its actual pos; compare **unimobs.mobkit_api.get_feet_pos()**.

**obj** can be a luaentity or ObjectRef.

N.B. The original code returned false on failure. All calling code must now check for a nil return value (original **mobkit** and **petz** code made no such checks).

**unimobs.mobkit_api.get_table_of_nodes_in_area(pos1, pos2, advanced_flag)**

*Was mobkit.get_nodes_in_area(), duplicated by kitz.get_nodes_in_area()*

In basic mode (**advanced_flag** is false or nil), returns a table of unique nodes within the area specified by the opposite corners **pos1** and **pos2**; the table is indexed by node definition, i.e.

        table[node_definition] = true

In advanced mode (**advanced_flag** = true) returns a table of nodes definitions indexed by position, i.e.

        table[pos] = node_definition

The maximum number of nodes searched is 125.

**unimobs.mobkit_api.get_walkable_terrain_height(pos, steps, dir, liquid_flag)**

*Was mobkit.get_terrain_height(), duplicated by kitz.get_terrain_height()*

Recursively searches for a walkable surface on, above or below the specified **pos**.

Arguments:

- pos (table): The target position
- steps (int or nil): Number of recursion steps, or how far above/below **pos** to check; default value is 3
- dir (int or nil): Direction of search: 1 to search above, -1 to search below, 0 to search in both directions (default is 0)
- liquid_flag (bool): Do not specify this parameter in initial calls to the function; during recursion, it is set to true if a surface is covered in water

Return values:

- y_coordinate_of_found_surface, liquid_flag_for_that_surface

**unimobs.mobkit_api.has_reached_destination(current_pos, dir, dest_pos)**

*Was mobkit.is_there_yet2d(), kitz.is_there_yet2d()*

Returns true if the position **dest_pos** is behind **current_pos**, according to the vector of direction **dir**, indicating that something has reached its destination.

y components are ignored, so the check is performed as if the positions were on a plane; thus true is returned if **dest_pos** is in the rear half-plane, as defined by **current_pos** and **dir**.

**unimobs.mobkit_api.heal_damage(luaent, val)**

*Was mobkit.heal(), duplicated by kitz.heal()*

Increases the specified luaentity's **.hp** by **val**.

Returns true if the luaentity exists and healing can be applied to it; false otherwise (this is a change to the original **mobkit** code, which returned nil or false).

**unimobs.mobkit_api.is_object_alive(obj)**

*Was mobkit.is_alive(), duplicated by kitz.is_alive()*

Checks whether the specified object exists in the world and is alive.

**obj** can be a luaentity or ObjectRef; this function is used for stored luaentities and ObjectRefs.

Assumes that luaentities are considered dead when their **.hp** is 0 or below.

In the original **mobkit** code, this function is marked as non-essential (for reasons not explained).

N.B. The **kitz** version of this function contains some minor changes from the original **mobkit** version, which were NOT copied into this **unimobs** function.

**unimobs.mobkit_api.is_pos_in_box(pos, box_pos, box)**

*Was mobkit.is_pos_in_box(), duplicated by kitz.is_pos_in_box()*

Returns true if **pos** is within the collision **box**, which is at the position **box_pos**.

**unimobs.mobkit_api.is_pos_in_cube(pos1, pos2, radius)**

*Was mobkit.isnear3d(), duplicated by kitz.isnear3d()*

Returns true if **pos2** is within a cube whose centre is **pos1**, and whose radius is **radius**; otherwise returns false.

**unimobs.mobkit_api.is_pos_in_square(pos1, pos2, radius)**

*Was mobkit.isnear2d(), duplicated by kitz.isnear2d()*

Returns true if **pos2** is within a square whose centre is **pos1**, and whose radius is **radius**; otherwise returns false.

y components are ignored, so **pos1.y** need not be equal to **pos2.y**, in order to return true.

**unimobs.mobkit_api.move_towards_pos(self, target_pos, speed, turn_rate, dist)**

*Was mobkit.drive_to_pos(), duplicated by kitz.drive_to_pos()*

Moves in the facing direction while gradually turning towards **target_pos**.

Arguments:

- target_pos (table): The target position
- speed (float): Speed in metres per second
- turn_rate (float): Turning rate in radians per second
- distance (float): Desired distance from the target, in metres

Return values:

- true if within the distance **dist** from **target_pos**, otherwise false

**unimobs.mobkit_api.set_acceleration(obj, vec, limit)**

*Was mobkit.set_acceleration(), duplicated by kitz.set_acceleration()*

Called when an object is in a liquid, in order to set its acceleration; in the air, **obj:set_acceleration()** can be called directly.

**unimobs.mobkit_api.set_forward_velocity(self, speed)**

*Was mobkit.go_forward_horizontal(), duplicated by kitz.go_forward_horizontal()*

Sets an entity's horizontal velocity in the yaw direction; its vertical velocity is unaffected.

**unimobs.mobkit_api.shift_pos_by_horizontal_distance(pos, yaw, dist)**

*Was mobkit.pos_translate2d(), duplicated by kitz.pos_translate2d()*

Returns **pos** shifted in the direction of **yaw** by the distance **dist**.

**unimobs.mobkit_api.shift_pos_by_vector(pos, vec)**

*Was mobkit.pos_shift(), duplicated by kitz.pos_shift()*

Returns **pos** shifted by the specified vector, **vec**.

**pos** must be a full **Minetest** position table, containing .x, .y and .z fields.

The fields in **vec** are optional; any missing fields are handled as 0, e.g. {y = 1}.

**unimobs.mobkit_api.turn_to_yaw(self, target_yaw, rate)**

*Was mobkit.turn2yaw(), duplicated by kitz.turn2yaw()*

Gradually turns towards the specified yaw.

Arguments:

- self (luaentity): A mob
- target_yaw (float): Target yaw in radians
- rate (float): Turn rate in radians per second

Return values:

- Returns two values, in the form: true_if_facing_target_yaw_otherwise_false, current_yaw

### 8.1.6 mobkit_utils.lua (from mobkit/example_behaviors.lua)

**unimobs.mobkit_api.convert_vector_to_neighbour_num(dir)**

*Was mobkit.dir2neighbor(), duplicated by kitz.dir2neighbor()*

Converts a 3d vector to a neighbour number (in the range 1-8). The y-component of **dir** is ignored.

**unimobs.mobkit_api.get_next_neighbour(neighbour_num, shift)**

*Was mobkit.neighbor_shift(), duplicated by kitz.neighbor_shift()*

Converts **neighbour_num** (in the range 1-8, representing a neighbouring node) into one of the other indices (representing a different neighbouring node).

If **shift** is positive, move clockwise; if negative, move anti-clockwise, e.g. (1, 1) -> 2, (1, -2) -> 7.

**unimobs.mobkit_api.get_next_waypoint(self, target_pos)**

*Was mobkit.get_next_waypoint()*

Called by **unimobs.mobkit_api.goto_next_waypoint().**

**unimobs.mobkit_api.get_next_waypoint_fast(self, target_pos, no_go_pos)**

*Was mobkit.get_next_waypoint_fast(), duplicated by kitz.get_next_waypoint_fast()*

An alternative to **unimobs.mobkit_api.get_next_waypoint()**; not currently called by code imported from the original **mobkit** mod.

The **no_go_pos** argument, if specified, is ignored.

**unimobs.mobkit_api.goto_next_waypoint(self, target_pos)**

*Was mobkit.goto_next_waypoint(), duplicated by kitz.goto_next_waypoint()*

This function groups common operations, causing mobs to move in a specific direction.

It's not a behaviour in itself, but is used by some built-in high-level behaviours which use a node-by-node movement algorithm.

**unimobs.mobkit_api.is_neighbour_node_reachable(self, neighbour_num)**

*Was mobkit.is_neighbor_node_reachable(), duplicated by kitz.is_neighbor_node_reachable()*

If the neighbouring node, whose position is specified by **neighbour_num** (in the range 1-8) is reachable, then return the values (height, target_pos, liquid_flag); otherwise return nil.

This function's behaviour differs when **unimobs.setting.tweak_mobkit_engine_flag** is set.

### 8.1.7 mobkit_utils.lua (original to unimobs)

**unimobs.mobkit_api.apply_brain_death(self)**

*Original to unimobs*

A mob becomes "brain dead" when its **.brain_func** property is set to an empty function.

That functionality is wrapped inside this new function for the sake of clarity.

**unimobs.mobkit_api.is_behaviour_safe(self)**

*Original to unimobs*

Because of changes to the engine, functions like **self.object:get_yaw()** and **self.object:get_pos()** can now return nil unexpectedly, if the specified mob has been removed from the world; this causes a number of crashes.

We already have **unimobs.mobkit_api.does_object_exist()** and **unimobs.mobkit_api.is_object_alive()**, both of which could be used to intercept such problems.

This function is a stripped-down version of both of them, that should be called by every high-level and low-level behaviour package, before doing anything else. It can also be called by any meta-behaviour package which uses ObjectRef functions like **:get_yaw()**, **:set_pos()** and so on.

This function assumes that **self** is the mob's luaentity, and does not refer to an ObjectRef or to a player.

If calls to this function return false, the behaviour should terminate itself.

**unimobs.mobkit_api.sort_keys_by_values(t)**

*Original to unimobs*

Returns a list of keys, sorted by value.

## 8.2 API functions derived from kitz

### 8.2.1 kitz_active_mobs.lua

**unimobs.kitz_api.register_active_mob(self)**

*Was kitz.logon_mob()*

Adds a mob to the **unimobs** table of active mobs (used only by code imported from **kitz**).

**unimobs.kitz_api.unregister_active_mob(self)**

*Was kitz.logout_mob()*

Removs a mob from the **unimobs** table of active mobs (used only by code imported from **kitz**).

### 8.2.2 kitz_clear_mobs.lua

**unimobs.kitz_api.clear_mobs_in_range(pos, mod_name)**

*Was kitz.clear_mobs()*

Removes all entities within a 100 block radius of **pos** which were created by the specified **mod_name**. However, petz-compatible mobs whose **.is_tamed_flag** is true are *not* removed.

### 8.2.3 kitz_cron.lua

**unimobs.kitz_api.create_cron_task_to_clear_mobs(cron_time, mod_name)**

*Was kitz.cron_clear()*

Creates a cron task to clear all the untamed mobs from the mod **mod_name** within range of all server players, from time to time.

If **cron_time** <= 0, then the cron task does not run.

### 8.2.4 kitz_drops.lua

**unimobs.kitz_api.drop_object(obj)**

*Was kitz.drop_object()*

Drops an object (such as a pony's horseshoe) as an entity, if possible; otherwise just removes it from the world.

**unimobs.kitz_api.set_drop_velocity(obj)**

*Was kitz.drop_velocity()*

Sets the velocity of an entity being dropped by a mob (e.g. a pony's horseshoe).

**unimobs.kitz_api.make_mob_drop_single_item(self, itemstack)**

*Was kitz.drop_item()*

Causes the mob (or player) to drop only one item, **itemstack**.

**unimobs.kitz_api.make_mob_drop_multiple_items(self, killed_by_player_flag)**

*Was kitz.drop_items()*

Called when the mob dies.

Causes the mob to drop one or more items, as specified by the entity's **.drop_list** field.

If **killed_by_player_flag** is true, the mob drops only rare items (self.drop_list.min = 0).

An example of a **.drop_list** field:

        .drop_list = {
            {name = "unilib:food_lamb_chop_raw", chance = 1, min = 1, max = 1},
            {name = "unilib:item_bone_animal", chance = 5, min = 1, max = 1},
        },

**unimobs.kitz_api.make_node_drop_items(pos)**

*Was kitz.node_drop_items()*

Causes the node at the specified **pos** to drop one or more items, as specified by the **.drop_list** field in the node's metadata.

Since nodes not created by **unimobs** probably don't define a **.drop_list** field, then only a few nodes are affected.

### 8.2.5 kitz_feed_tame.lua

**unimobs.kitz_api.feed_mob(self, clicker, feed_rate, msg_full_health, sound_type)**

*Was kitz.feed()*

Feeds the specified mob using the player's wielded item (as long as it appears in the list of feedable items in the remix CSV).

**feed_rate** is a value in the range 0-1, representing the fraction of the mob's **.max_hp** to be restored. **msg_full_health** is optional. **sound_type** is the type of sound stored in the mob's **.sound** field.

Returns true if the creature has been fed, or false otherwise.

**unimobs.kitz_api.get_active_mobs_by_owner(owner, nametag)**

*Was kitz.get_active_mobs_by_owner()*

Returns of list of active mobs which belong to the specified **owner**.

If the optional **nametag** is specified, only mobs with that name are returned.

This function only returns mobs from **unimobs.global.active_mob_table**, which itself may only include petz-compatible mobs.

**unimobs.kitz_api.remove_mob_owner(self)**

*Was kitz.remove_owner()*

Marks the mob as unowned, by resetting its **.is_tamed_flag** and **.owner** fields.

**unimobs.kitz_api.set_mob_health(self, factor)**

*Was kitz.set_health()*

Adjusts the mob's health. **factor** is a value in the range 0-1, representing the fraction of **.max_hp** to be added
(if positive) or removed (if negative).

**unimobs.kitz_api.set_mob_owner(self, owner_name)**

*Was kitz.set_owner()*

Marks the mob as owned, by setting its **.is_tamed_flag** and **.owner** fields.

**unimobs.kitz_api.tame_mob(self, tame_count, owner_name, msg_tamed, limit_table)**

*From kitz.tame()*

Tames the specified mob.

**tame_count** is the amount of food required to tame the mob (before reductions due to the "digestion" gene are applied); if not specified, then the default value is used.

**limit_table** is an optional table in the form:

- **.max** - The maximum number of tamed mobs per player
- **.count** - The number of mobs currently tamed by the player that is trying to tame this mob
- **.msg** - Message to display when the maximum is reached (in which case, the taming process is aborted)

### 8.2.6 kitz_maths.lua

**unimobs.kitz_api.delimit_number(number, range_table)**

*Was kitz.delimit_number()*

Returns **number** adjusted to lie within the minimum/maximum values specified by **range_table**.

The format of **range_table** is {min = 1, max = 99}.

**unimobs.kitz_api.round_number(x)**

*Was kitz.round()*

Return the specified value, rounded down (for positive numbers), or rounded up (for negative numbers).

**unimobs.kitz_api.convert_degrees_to_radians(degrees)**

*Was kitz.degrees_to_radians()*

Converts degrees to radians.

**unimobs.kitz_api.convert_radians_to_degrees(radians)**

*Was kitz.radians_to_degrees()*

Converts radians to degrees.

**unimobs.kitz_api.convert_yaw_to_degrees(yaw)**

*Was kitz.degrees(), kitz.yaw_to_degrees()*

Converts yaw to degrees.

**unimobs.kitz_api.round_degrees(degree)**

*Was kitz.degree_round()*

Returns **degree** rounded up to an integer.

### 8.2.7 kitz_replace.lua

**unimobs.kitz_api.make_mob_replace_node(self, sound_name, max_hear_distance)**

*Was kitz.replace()*

Causes the mob to replace one node with another (for example, causes it to "eat" turf, leaving behind a dirt node).

The **sound_name** and **max_hear_distance** arguments are optional.

Example mob properties, replacing grass with dirt:

        .replace_data_list = {
            { OLD_NODE, NEW_NODE, Y_OFFSET },
            {"group:grass", "air", -1},
            {"default:dirt_with_grass", "default:dirt", -2}
        }
        .replace_rate = 10
        .replace_turf_flag = true

Note that even when **.replace_turf_flag** is true, we still list **minetest_game** nodes in **.replace_data_list**, when appropriate (for compatibility with worlds using **minetest_game** nodes instead of the **unilib** equivalents).

**unimobs.kitz_api.refine_replace_data(entity_name)**

*Original to unimobs*

Called from the **.post()** function of any mob packages which set their **.replace_data_list** property.

Refines the list to remove non-existent nodes.

### 8.2.8 kitz_sound.lua

**unimobs.kitz_api.make_sound(dest_type, dest, sound_file, max_hear_distance)**

*Was kitz.make_sound()*

Causes the item **dest** to play the specified **sound_file**.

**dest_type** can be "object", "player" or "pos".

ATTENTION: When composing the **sound_file** argument using a particular petz-compatible creature, use its **.generic_type** field, not its **.mob_type** field.

**unimobs.kitz_api.make_misc_sound(self, chance, max_hear_distance)**

*Was kitz.make_misc_sound()*

Plays one of the sound files, selected at random, from the "misc" sound definition.

This function does not check all of the formats supported by the original **mobkit** API, but only mobs whose **.sounds** are in the following formats, widely used in the original **petz** code:

        sounds = {
            misc = "unilib_mob_cat_normal_miaow_1",
        },

        sounds = {
            misc = {"unilib_mob_cat_normal_miaow_1", "unilib_mob_cat_normal_miaow_2", ... },
        },

### 8.2.9 kitz_utils.lua

**unimobs.kitz_api.does_file_exist(path)**

*Was kitz.file_exists()*

Returns true if the specified filepath exists, false if not.

**unimobs.kitz_api.register_discovered_item(player, mob_type, discovery_type, full_name)**

*Original to unimobs*

The main formspec for mobs displays the item(s) used for repelling/following/feeding/breeding/capturing.

However, if **unimobs.petz_setting.conceal_unused_items_flag** is true, the items are concealed (not visible) unless they've actually been used by the player for that purpose.

When repelling/following/feeding/breeding/capturing occurs, this function should be called to register the items used in the player's metadata.

Note that discoveries are only stored when **unimobs.petz_setting.conceal_unused_items_flag** is true, and when the player is in survival mode.

**discovery_type** should be one of the strings "repel", "follow", "feed", "breed", "capture".

**full_name** is the full name of the item, e.g. **unilib:crop_wheat_harvest**.

**unimobs.kitz_api.remove_mob(self)**

*Was kitz.remove_mob()*

Clears the mob's high-level and low-level behaviour lists, before removing it from the world.

**unimobs.kitz_api.retrieve_discovered_item(player, mob_type, discovery_type, item_list)**

*Original to unimobs*

A convenience function for retrieving the data, stored as player metadata, in calls to **unimobs.kitz_api.register_discovered_item()**.

Note that discoveries are only stored when **unimobs.petz_setting.conceal_unused_items_flag** is true, and when the player is in survival mode. Before calling this function, it's up to the calling code to check both of those conditions.

**item_list** can be a single item (e.g. **unilib:crop_wheat_harvest**) or a list of items.

Returns the first item in that list which has been stored as a discovery, or nil if none of the items have been stored as discoveries.

**unimobs.kitz_api.create_inv_cube(tile_list)**

*Was kitz.create_inv_cube()*

Returns an inventory cube composed of the specified textures, for use in formspecs.

**unimobs.kitz_api.clamp_value_in_range(val, low, high)**

*Was kitz.math.clamp()*

Returns **val** clamped to the specified **low** and **high** values.

**unimobs.kitz_api.get_list_of_adjacent_node_positions(pos, non_oblique_flag)**

*Was kitz.adjacent_pos_grid()*

Returns a list of positions, which are adjacent to the position **pos**; the returned list is in a random order.

By default, returns only the north/south/west/east positions; if **non_oblique_flag** is true, returns all eight positions.

**unimobs.kitz_api.get_random_adjacent_node_position(pos, non_oblique_flag)**

*Was kitz.get_random_adjacent_pos()*

Returns a random position which is adjacent to the position **pos**.

By default, returns only one of the north/south/west/east positions; if **non_oblique_flag** is true, returns one of eight positions.

**unimobs.kitz_api.is_air(pos)**

*Was kitz.is_air()*

Returns true if the node at position **pos** is air, false otherwise.

**unimobs.kitz_api.is_liquid(pos)**

*Was kitz.is_liquid()*

Returns true if the node at position **pos** is a liquid, false otherwise.

**unimobs.kitz_api.is_walkable(pos, offset)**

*Was kitz.is_walkable()*

Returns true if the node at position **pos**, adjusted (in the vertical direction) by the optional **offset**, is walkable. Returns false otherwise.

**unimobs.kitz_api.node_has_group(pos, group)**

*Was kitz.in_group()*

Tests whether the node at position **pos** has the specified **group**.

If not, returns false; otherwise returns the matching group's value.

**unimobs.kitz_api.is_string_empty(s)**

*Was kitz.string_is_empty(), duplicated by petz.str_is_empty()*

Returns true if the specified string is empty, false otherwise.

**unimobs.kitz_api.remove_whitespace_in_string(val)**

*Was petz.str_remove_spaces()*

Removes any whitespace from the specified string, **val**.

**unimobs.kitz_api.is_table(val)**

*Was kitz.is_table()*

Returns true if the specified value is a table, false otherwise.

**unimobs.kitz_api.is_table_empty(t)**

*Was kitz.table_is_empty()*

Returns true if the specified value is an empty table, false otherwise.

**unimobs.kitz_api.shuffle_table_indices(t)**

*Was kitz.table_shuffle()*

Shuffles the numeric indices of the specified table, and returns it.

## 8.3 API functions derived from petz

### 8.3.1 petz_breed.lua

**unimobs.petz_api.get_genetic_range(self, gene_type)**

*Original to unimobs*

Convenience function to look up the current value of the specified gene in the specified mob according to its **.genetic_table**, and also the gene's minimum/maximum values.

Returns three values, in the form: **current_value**, **min_value**, **max_value**.

If the specified **gene_type** isn't recognised, uses a fallback value of 1.

If the specified **gene_type** isn't of the category "range" (meaning that it isn't some value in a range between a minimum and maximum), then **min_value** and **max_value** have the same value as **current_value**.

**unimobs.petz_api.compose_pregnant_icon(self)**

*From petz.compose_pregnant_icon()*

Returns a combined image, consisting of the spawn egg with a heart overlay in one corner.

**unimobs.petz_api.get_genetic_range_table(self, gene_type)**

*Original to unimobs*

Convenience function to extract a table of values from **unimobs.petz_global.mob_table**, giving the minimum/maximum values for genes of the category "range".

Returns nil if the table doesn't exist; otherwise returns a table in the form:

        {
            initial_min = value,
            initial_max = value,
            overall_min = value,
            overall_max = value,
        }

**unimobs.petz_api.is_mob_fertile(self)**

*From petz.is_fertile()*

Returns true if the mob can become pregnant, or false if it has had too many pregnancies already.

This function must be called in context (in other words, having already checked other properties such as **.is_male_flag**); this function only checks **self.pregnancy_countdown**.

**unimobs.petz_api.stimulate_mob_breeding(self, clicker, wielded_item, wielded_name)**

*From petz.breed()*

Called by **unimobs.petz_api.on_rightclick_callback()** when the mob is right-clicked with a suitable item.

Puts the mob into "search for a mate" (rut) mode.

**wielded_item** is optional; if specified, it is consumed.

**unimobs.petz_api.breed_mob_naturally(mother, father)**

*Adapted from petz.bh_breed()*

Called from **unilib.pkg.mtb_breed.do_action()** when a male is close enough to a female to impregnate her (and when both are ready for breeding).

**unimobs.petz_api.breed_mob_with_implement(mother, father_genetic_table)**

*Adapted from petz.pony_breed()*

Alternative to **unimobs.petz_api.breed_mob_naturally()**, when the impregnation is done with an implement (such as a syringe).

**father_genetic_table** is a table of "genes" to be passed to the mother, for later use when the baby mob is generated.

**unimobs.petz_api.interrupt_mob_breeding(self, clicker)**

*Original to unimobs*

Called by code in the **admin_tool_mob_interrupter** package.

Cancels a mob's rut mode or the mob's pregnancy.

**unimobs.petz_api.pregnant_timer(self, dtime)**

*From petz.pregnant_timer()*

Called by **unimobs.petz_api.on_step_callback()** at regular intervals.

When it's time to end the pregnancy, create the baby mob.

**unimobs.petz_api.cooldown_timer(self, dtime)**

*Original to unimobs*

Called by **unimobs.petz_api.on_step_callback()** at regular intervals.

When it's time to end the cooldown period (following a pregnancy), update the female mob's properties.

**unimobs.petz_api.growth_timer(self, dtime)**

*From petz.growth_timer()*

Called by **unimobs.petz_api.on_step_callback()** at regular intervals.

When it's time to convert the baby into an adult, go ahead and convert it.

**unimobs.petz_api.set_heritable_traits(self, data_table)**

*Original to unimobs*

Convenience function for adding key-value pairs to the mob's **.genetic_table**, and the memory associated with it.

**unimobs.petz_api.set_heritable_traits_from_father(self, data_table)**

*Oriqinal to unimobs*

Convenience function for adding key-value pairs to the mob's **.father_genetic_table**, and the memory associated with it.

### 8.3.2 petz_capture.lua

**unimobs.petz_api.register_capture_extension(mob_type, callback)**

*Original to unimobs*

Called by any package which wants to extend the standard behaviour, when a mob is captured.

**unimobs.petz_api.can_capture_mob(self, clicker, wielded_name, check_room_in_inv_flag)**

*Adapted from petz.check_capture_items()*

Called by **unimobs.petz_api.on_rightclick_callback()**, after the call to **unimobs.petz_api.can_capture_mob_with_item()**, but in advance of a call to **unimobs.petz_api.capture_mob()**.

This function checks whether the player is allowed to capture the specified mob with the specified wielded item, checking (for example) that there's enough room in their inventory.

If allowed, returns true; otherwise returns false.

If false is returned, it's a fatal error; the calling code should not continue checking other uses of the wielded item.

**unimobs.petz_api.can_capture_mob_with_item(self, wielded_name)**

*Adapted from petz.check_capture_items()*

Called by **unimobs.petz_api.on_rightclick_callback()**, in advance of calls to **unimobs.petz_api.can_capture_mob()** and **unimobs.petz_api.capture_mob()**.

**unimobs** permits multiple wieldable items to be used as a lasso or a net; any registerd lasso, animal net or bug net can be used to capture a compatible mob.

This function checks whether the specified item can be used to capture the specified mob, returning true if so, and false if not.

If false is returned, it's a non-fatal error; the calling code can continue checking other uses of the wielded item.

**unimobs.petz_api.capture_mob(self, clicker, wielded_name, put_in_inventory_flag)**

*From petz.capture()*

Commonly called by **unimobs.petz_api.on_rightclick_callback()** (or by any other code; for example in code in the **shared_petz_bottles** package). Should usually be preceded by calls to **unimobs.petz_api.can_capture_mob_with_item()** and **unimobs.petz_api.can_capture_mob()**.

"Captures" the mob by converting an entity into a spawn egg, preserving much of its metadata. Optionally places the spawn egg into the player's inventory.

Returns the metadata for the new stack, so that the calling code can perform further operations if necessary (for example, to convert a moth spawn egg into a moth in a bottle).

**unimobs.petz_api.release_mob(placer, itemstack, mob_name, pos)**

*From petz.create_pet()*

"Releases" a mob by converting a spawn egg into an entity, preserving much of its metadata (thus this function is the opposite of **unimobs.petz_api.capture_mob()** ).

Commonly called by the spawn egg's **.on_place()** callback, but is also called by other code (for example, by the cat basket and bird stand packages).

Returns the luaentity on success.

### 8.3.3 petz_clutching.lua

**unimobs.petz_api.register_clutchable_item(full_name, entity_name)**

*Original to unimobs*

Called by any package which provides a clutchable item.

**unimobs.petz_api.is_node_clutchable(full_name)**

*Original to unimobs*

Returns true if the specified item is clutchable, false otherwise.

**unimobs.petz_api.is_entity_clutchable(entity_name)**

*Original to unimobs*

Returns true if the specified entity is the equivalent of a clutchable item, false otherwise.

**unimobs.petz_api.convert_clutchable_node_to_entity(full_name)**

*Original to unimobs*

Converts the name of the specified clutchable node into its entity equivalent.

**unimobs.petz_api.convert_clutchable_entity_to_node(entity_name)**

*Original to unimobs*

Converts the specified clutchable entity into the equivalent node name.

**unimobs.petz_api.attach_clutchable_item(clutch_ent, mob_ent, thing_obj, thrower_name)**

*From petz/petz/api/api_squareball.lua, was petz.attach_squareball()*

Can be called by brain pacakges (e.g. by the **brain_herbivore** package); also called by **unimobs.petz_api.update_clutchable_item()**.

Attaches the clutchable item entity to a mob entity, as if the mob were carrying a ball in its mouth.

Arguments:

- clutch_ent (luaentity): The luaentity for the clutchable item (e.g. the square ball), created by the calling code using a call to **core.add_entity()**
- mob_ent (luaentity): The luaentity for the mob to which the item will be attached
- mob_obj (entity): The actual mob entity

Optional arguments:

- thrower_name (str): The name of the player that threw the clutchable item, if known (used in games of fetch)

**unimobs.petz_api.detach_clutchable_item(self, clicker, full_name)**

*From petz/petz/api/api_squareball.lua (originally the .on_rightclick() callback for the petz:ent_square_ball entity)*

Called when the player right-clicks a clutched item.

Detaches the clutched item from the mob to which it's attached, and places the equivalent node (**full_name**) in the player's inventory.

**unimobs.petz_api.throw_clutchable_item(user, entity_name, strength)**

*From petz/petz/api/api_squareball.lua, was petz.spawn_square_ball()*

Called by a node's **.on_use()** function.

Generates an entity corresponding to the clutchable node, and "throws" it in the correct direction and at the correct angle.

**unimobs.petz_api.update_clutchable_item(self, full_name)**

*From petz/petz/api/api_squareball.lua (originally the .on_step() callback for the petz:ent_square_ball entity)*

Called while the clutchable item, having been thrown, is still moving.

Checks for collisions with other mobs and/or nodes, handling the first collision found.

### 8.3.4 petz_collisionbox.lua

*From petz.get_collisionbox(), .get_selectionbox() and .get_box()*

Returns two collisionboxes whose size has been multiplied by the specified factors, creating boxes that match both the adult and baby variants of a mob.

(The returned collisionboxes can also be used as selectionboxes, when required.)

### 8.3.5 petz_convert.lua

**unimobs.petz_api.convert_mob(self, pname, wielded_name)**

*From petz.convert()*

Called by **unimobs.petz_api.on_rightclick_callback()**,

Converts one type of mob to another (e.g. converts wolves to dogs, using a wielded bone).

In **unimobs.petz_msetting**, the **.convert_with_table** (etc) fields specify the item needed to do the conversion (e.g. a bone), and the **.convert_to** field specifies the new mob (e.g. a wolf).

The player name **pname** is a compulsory argument, but **wielded_name** is optional.

### 8.3.6 petz_death.lua

**unimobs.petz_api.register_death_extension(mob_type, callback)**

*Original to unimobs*

Called by any package which wants to extend the standard behaviour, when a mob dies.

**unimobs.petz_api.handle_mob_death(self)**

*From petz.on_die()*

Called by various brain packages when a mob's **.hp** reaches zero (or in other situations, as appropriate).

Handles the death gracefully, setting **.is_dead_flag** to true and initiating the death behaviour **hqb_die**.

### 8.3.7 petz_dung.lua

**unimobs.petz_api.make_mob_produce_dung(self, pos)**

*From petz.poop()*

Called by brain packages like **brain_herbivore** and **brain_flying**.

If dung is enabled globally, and if the specified mob can produce dung, then occasionally create the dung node.

(The rate at which a mob produces dung is specified in settings.)

### 8.3.8 petz_eggs.lua

**unimobs.petz_api.lay_egg(self)**

*From petz.lay_egg()*

Makes the specified mob lay an egg at random intervals (if permitted).

**unimobs.petz_api.extract_egg_from_nest(pos, player, itemstack, egg_name, empty_nest_name)**

*From petz.extract_egg_from_nest()*

When the player right-clicks a nest-with-egg node, move the egg to the player's inventory, and replace the full nest with an empty one.

**itemstack** is the item wielded by the player (if any), **egg_name** is a string like "unilib:egg_chicken_normal", and the optional **empty_nest_name** argument is a string like "unilib:misc_nest".

### 8.3.9 petz_env_damage.lua

**unimobs.petz_api.apply_env_damage(self, entity_pos, priority)**

*From petz.env_damage()*

Called by numerous brain packages.

Applies environmental damage to the specified mob.

Damage is caused to all mobs by fire, lava and other igniters. Damage will also be caused to any mobs for which the remix CSV has specified one or more harmful nodes.

### 8.3.10 petz_formspecs.lua

**unimobs.petz_api.register_formspec_extension(mob_type, data_table)**

*Original to unimobs*

Called by any package which wants to add additional buttons to the main mob formspec.

**unimobs.petz_api.create_standard_mob_form(pname)**

*Original to unimobs*

Replaces the confusing main mob formspec from the original **petz** modpack.

Called by **unimobs.petz_api.on_rightclick_callback()** when the player right-clicks a tamed mob, and no other action has been taken as a result.

Creates the main mob formspec.

**unimobs.petz_api.create_buy_mob_form(pname)**

*Adapted from code in /petz/petz/api/api_forms.lua (was not a separate function in the original code)*

Creates the formspec for buying and selling mobs.

**unimobs.petz_api.create_show_mob_genetics_form(mob)**

*Original to unimobs*

Creates the formspec for displaying genetic data.

### 8.3.11 petz_init_prop.lua

**unimobs.petz_api.add_dynamic_property(prop_name, prop_type, default_val)**

*Original to unimobs*

Called by mob packages to add a property to the standard table of dynamic properties.

Duplicate **prop_name** values are ignored.

**prop_type** should be one of the following values: "bool", "entity", "num", "player", "pos", "str" or "table"; if another type is specified, the property is ignored.

**unimobs.petz_api.register_initial_extension(mob_type, callback)**

*Original to unimobs*

Called by any package which wants to extend the standard behaviour, when a mob's initial properties are being set.

**unimobs.petz_api.adjust_mounted_value(self, gene_type)**

*Original to unimobs*

A mounted creature's speed is represented as a value in the range 0-10, by default (the setting **.max_mounted_speed** specifies the limit of 10).

However, the values stored in the creature's **.genetic_table** have an arbitrary minimum and maximum (so the range might be 0-10, or perhaps 0-12, or perhaps 10-25).

This function converts a value in this arbitrary range, into a value in the range 0-10 (or whatever the maximum specified by the setting is).

**unimobs.petz_api.update_convert_countdown_from_genetics(self)**

*Original to unimobs*

Called by **unimobs.petz_api.update_mob_properties_from_genetics()**, and by code in **reinitialise_old_mob()** (a local function in this file) in order to set the property back to its correct value.

**unimobs.petz_api.update_feed_countdown_from_genetics(self)**

*Original to unimobs*

Called by **unimobs.petz_api.update_mob_properties_from_genetics()**, and by **unimobs.kitz_api.tame_mob()** when a creature is tamed, in order to reset the property from 0 to its original (maximum) value.

**unimobs.petz_api.update_jump_height_from_genetics(self)**

*Original to unimobs*

Called by **unimobs.petz_api.update_mob_properties_from_genetics()**, and by code in **reinitialise_old_mob()** (a local function in this file) in order to set the property back to its correct value.

**unimobs.petz_api.update_lash_countdown_from_genetics(self)**

*Original to unimobs*

Called by **unimobs.petz_api.update_mob_properties_from_genetics()**, and by **unimobs.petz_api.tame_mob_with_lash()** when a creature is tamed, in order to reset the property from 0 to its original (maximum) value.

**unimobs.petz_api.update_max_hp_from_genetics(self)**

*Original to unimobs*

Called by **unimobs.petz_api.update_mob_properties_from_genetics()**, and by code in **reinitialise_old_mob()** (a local function in this file) in order to set the property back to its correct value.

**unimobs.petz_api.update_max_roam_height_from_genetics(self)**

*Original to unimobs*

Called by **unimobs.petz_api.update_mob_properties_from_genetics()**, and by code in **reinitialise_old_mob()** (a local function in this file) in order to set the property back to its correct value.

**unimobs.petz_api.update_max_speed_from_genetics(self)**

*Original to unimobs*

Called by **unimobs.petz_api.update_mob_properties_from_genetics()**, and by code in **reinitialise_old_mob()** (a local function in this file) in order to set the property back to its correct value.

**unimobs.petz_api.update_pregnancy_countdown_from_genetics(self)**

*Original to unimobs*

Called by **unimobs.petz_api.update_mob_properties_from_genetics()**, and by code in **reinitialise_old_mob()** (a local function in this file) in order to set the property back to its correct value.

**unimobs.petz_api.update_replace_countdown_from_genetics(self)**

*Original to unimobs*

Called by **unimobs.petz_api.update_mob_properties_from_genetics()**, and by code in **petz_replenish.lua** (and similar package callbacks) when a creature is replenished, in order to reset the property from 0 to its original (maximum) value.

**unimobs.petz_api.update_view_range_from_genetics(self)**

*Original to unimobs*

Called by **unimobs.petz_api.update_mob_properties_from_genetics()**, and by code in **reinitialise_old_mob()** (a local function in this file) in order to set the property back to its correct value.

**unimobs.petz_api.update_mob_properties_from_genetics(self)**

*Original to unimobs*

Replaces the initial values of various mob properties, depending on the mob's **.genetic_table**.

**unimobs.petz_api.set_mob_initial_properties(self, staticdata, dtime_s)**

*From petz.set_initial_properties()*

Called by **.on_activate()** for each mob.

Sets the initial properties for a mob, in the following situations:

1. A new mob has spawned (because of a call to **unimobs.petz_api.spawn_mob()** )
2. A mob already exists (must be re-initialised because the game has just re-started)
3. A spawn egg has been placed (must be converted into a mob, and its metadata transferred to the new mob)

### 8.3.12 petz_lifespan.lua

**unimobs.petz_api.check_lifespan(self)**

*From petz.check_lifetime()*

Called from **unimobs.petz_api.on_step_callback()**.

Returns the mob's lifespan (in seconds), or nil.

**unimobs.petz_api.lifespan_timer(self, lifespan, on_step_time)**

*From petz.lifetime_timer()*

Function called regularly, by **unimobs.petz_api.on_step_callback()**, to apply damage to a mob whose lifespan has expired (does not apply to mobs without a lifespan).

### 8.3.13 petz_mount.lua

**unimobs.petz_api.do_wagon_animation(self, animation_name)**

*Original to unimobs*

Gets the wagon animation function for the specified mob, if any, and then calls it.

**unimobs.petz_api.get_saddle_overlay(saddle_name, mob_type)**

*Original to unimobs*

Returns the overlay texture for the specified saddle (e.g. **unilib:item_saddle_normal**) and **mob_type** (e.g. "pony_normal").

**unimobs.petz_api.get_saddlebag_overlay(saddlebag_name, mob_type)**

*Original to unimobs*

Returns the overlay texture for the specified saddle-bag (e.g. **unilib:item_saddlebag_normal**) and **mob_type** (e.g. "camel_normal").

**unimobs.petz_api.get_wagon_craftitem(self)**

*Original to unimobs*

Retrieves the craftitem corresponding to the wagon entity stored in the specified mob, if any.

**unimobs.petz_api.register_saddle(saddle_name, mob_type_list)**

*Original to unimobs*

Called by any package which provides a saddle.

**unimobs.petz_api.register_saddlebag(saddlebag_name, mob_type_list)**

*Original to unimobs*

Called by any package which provides a saddle-bag.

**unimobs.petz_api.register_wagon(entity_name, craftitem_name, animation_func)**

*Original to unimobs*

Called by any package which provides a wagon compatible with mountable mobs.

Only the **entity_name** argument is compulsory; the others may be nil.

**unimobs.petz_api.interact_with_mountable_mob(self, clicker, wielded_item, wielded_name)**

*From petz.mount()*

Handles mounting/dismounting a mountable mob such as a pony or a camel.

Also handles saddles, saddle-bags and wagons, when compatible with the mob.

Returns true to show that an action has been taken, or false to show that no action has been taken, and that the calling code should therefore open the main mob formspec.

**unimobs.petz_api.put_equipment_on_mountable_mob(self, clicker, wielded_item, wielded_name)**

*From petz.put_saddle()*

Puts a saddle or saddle-bag on the specified mob.

Updates the specified mob's properties, including its texture.

**unimobs.petz_api.remove_equipment_from_mountable_mob(self)**

*From petz.free_saddles(), .free_saddle(), .free_saddlebag()*

Removes saddles and/or saddle-bags from the specified mob, and updates properties.

**unimobs.petz_api.mount_player_on_mob(entity, player)**

*Was petz.attach()*

Mounts the specified player on the specified entity (which should be a mountable mob, like a pony).

**unimobs.petz_api.force_dismount_player_from_mob(player)**

*Was petz.force_detach()*

A force-dismount function, called (for example) when a player leaves the server.

Also called by **unimobs.petz_api.dismount_player_from_mob()** itself, since the code is the same for soft/forced dismounts.

**unimobs.petz_api.dismount_player_from_mob(player, offset)**

*Was petz.detach()*

A normal dismount function called, for example, when a player right-clicks a mob on which they're already mounted.

**unimobs.petz_api.check_gallop_mode(self, dtime)**

*Was petz.gallop()*

Called by **unimobs.petz_api.on_step_callback()** for a mob in gallop mode.

Check whether the time limit has expired, in which case disable gallop mode, and mark the mob as exhausted.

**unimobs.petz_api.apply_horseshoe_speed_bonus(self, speed_bonus)**

*From petz.speedup_change()*

Applies the specified speed bonus (which may be positive or negative) to the specified mob.

**unimobs.petz_api.cancel_horseshoe_speed_bonus(self)**

*Original to unimobs*

Restores the original values of a mounted mob's speed properties, removing any bonus applied during calls to **unimobs.petz_api.apply_horseshoe_speed_bonus()**.

**unimobs.petz_api.remove_horseshoes_from_mob(self)**

*From petz.horseshoes_reset()*

Removes any horseshoes from the specified mob and resets its properties, removing any speed bonus that was applied.

### 8.3.14 petz_nametag.lua

**unimobs.petz_api.update_mob_nametag(self)**

*From petz.update_nametag()*

Updates the nametag that's visible in the world for the specified mob.

If the mob's **.nametag** property is set (and if nametags are enabled globally), makes it visible in the game; otherwise sets an empty nametag (that is not visible).

**unimobs.petz_api.remove_mob_nametag(self)**

*From petz.delete_nametag()*

Without changing any of the mob's properties, removes the entity's nametag.

### 8.3.15 petz_on_deactivate.lua

**unimobs.petz_api.on_deactivate_callback(self)**

*From petz.on_deactivate()*

Standard **.on_deactivate()** callback for all petz-compatible mob entities.

### 8.3.16 petz_on_punch.lua

**unimobs.petz_api.register_punch_mob_extension(mob_type, callback)**

*Original to unimobs*

Called by any package which wants to extend the standard behaviour, when a mob is punched.

**unimobs.petz_api.register_punch_with_extension(full_name, callback)**

*Original to unimobs*

Called by any package which wants to extend the standard behaviour, when a mob is punched with a wielded item.

**unimobs.petz_api.on_punch_callback(self, puncher, time_from_last_punch, tool_capabilities, dir)**

*From petz.on_punch()*

Standard **.on_punch()** callback for all petz-compatible mob entities.

### 8.3.17 petz_on_rightclick.lua

**unimobs.petz_api.register_rightclick_override(wielded_name, callback)**

*Original to unimobs*

Called by any package which wants to override the standard behaviour, when a mob is right-clicked with **wielded_name**.

**unimobs.petz_api.on_rightclick_callback(self, clicker)**

*From petz.on_rightclick()*

Standard **.on_rightclick()** callback for all petz-compatible mob entities.

### 8.3.18 petz_on_step.lua

**unimobs.petz_api.on_step_callback(self, dtime)**

*From petz.on_step()*

Standard **.on_step()** callback for all petz-compatible mob entities.

### 8.3.19 petz_particles.lua

**unimobs.petz_api.show_standard_particles(pos, particle_type, override_texture_name)**

*From petz.do_particles_effect()*

Produces the specified set of standard particles (as defined by the table in this file).

**particle_type** must be one of the values "dreamcatcher", "fire", "heart", "hungry", "pollen", "pregnant", "pumpkin", "sleep" or "star".

In a change to the original code, the **override_texture_name** can now be specified for any **particle_type**; if not specified, a generic texture is used.

**unimobs.petz_api.show_blood_particles(self)**

*From petz.blood()*

Displays blood particles around the specified mob, if permitted.

**unimobs.petz_api.show_death_particles(self)**

*Adapted from code in petz.on_die()*

Displays death particles around the specified mob, if permitted.

### 8.3.20 petz_register.lua

**unimobs.petz_api.register_mob(data_table)**

*Original to unimobs*

Called by every mob_X package that wants to use the **kitz**/**petz** APIs.

Registers the mob in the global variables **unimobs.petz_global.mob_list** and **unimobs.petz_global.mob_table** (replacing the original **petz.settings.petz_list**).

Calling code should not register a spawn egg (via a call to **unimobs.petz_api.register_spawnegg()** ) unless this function returns true.

**data_table** compulsory fields:

- mob_type (str): Matches the entity's .mob_type, e.g. "lion_normal"
- mob_name (str): Matches the entity name, e.g. **unilib:mob_lion_normal**
- description (str): Matches the entity's description, e.g. "Lion (Normal)"
- insertion_table (table): Table providing substitutions for visible translated text, in the form:

        (Used as the subject of a sentence)
        .subject = "dog#subject"
        .subject_an = "a dog#subject"
        .subject_the = "the dog#subject"
        (Used as the object of a sentence)
        .object = "dog#object"
        .object_an = "a dog#object"
        .object_the = "the dog#object"

**data_table** optional fields:

- collisionbox (table): Standard **Minetest** collisionbox table
- genetic_init_list (list): List of mini-lists, in the format described by **petz_init_prop.lua**
- mesh (str): Filename of the mesh, e.g. "unilib_mob_lion_normal.b3d"
- skin_init_list (list): List of mini-lists, in the format described by **petz_init_prop.lua**
- version (int): Code version for this mob. Code in **petz_init_prop.lua** checks the value so that, in case of any major changes to the mob, old mob entities can be updated. When first written, mobs should have a .version with the value 1; later changes should be numbered 2, 3 etc. If not specified, 1 is used
- visual_size (table): Standard **Minetest** **.visual_size** table

Return values:

- true on success, false on failure (for example, if a mob matching **mob_type** already exists)

**unimobs.petz_api.register_standard_mob(data_table)**

*From petz.register()*

Registers a mob entity using standard properties. Also registers the mob's spawn egg. (Some packages will call this function; but most mob packages register their own entity.)

**data_table** compulsory fields:

- mob_type (str): e.g. "gecko_normal"
- orig_spawnegg_name (str): e.g. "petz:gecko_set"
- def_table (table): Entity definition table for the mob
- insertion_table (table): Table providing substitutions for visible translated text, in the form described in **unimobs.petz_api.register_mob()**

**data_table** optional fields:

- replace_mode (str): e.g. "defer"
- version (int): Code version for this mob. Code in **petz_init_prop.lua** checks the value so that, in case of any major changes to the mob, old mob entities can be updated. When first written, mobs should have a **.version** with the value 1; later changes should be numbered 2, 3 etc. If not specified, 1 is used

**unimobs.petz_api.register_spawnegg(data_table)**

*From petz:register_egg()*

Creates a spawn egg for the specified mob.

**data_table** compulsory fields:

- mob_type (str): e.g. "lion_normal"
- orig_name (str): e.g. "petz:lion_set"

**data_table** optional fields:

- replace_mode (str): e.g. "defer"
- description (str): e.g. "Lion (Normal)"
- img (str): e.g. "unilib_spawnegg_lion_normal.png"
- mob_name (str): e.g. "unilib:mob_lion_normal"
- sci_name (str): e.g. "Felis catus"
- tamed_flag (bool): e.g. true

**unimobs.petz_api.register_egg_node(data_table)**

*From petz.register__egg()*

Registers an egg in the form of a node. (In the original mod code, this function was only called for gecko eggs.)

**data_table** compulsory fields:

- mob_type (str): e.g. "gecko_normal"
- orig_name (str): e.g. "petz:gecko_egg"
- drawtype (str): e.g. "nodebox"

**data_table** optional fields:

- replace_mode (str): e.g. "defer"
- baby_max (int): The maximum number of baby mobs produced by each egg (default is 1, otherwise a random number of eggs between 1 and the maximum is produced; use the  value 0 to prevent eggs from producing any babies)
- baby_name (str): If not specified, "unilib:mob_TYPE", where TYPE is **data_table.mob_type**
- description (str): e.g. "Normal Gecko Egg"
- mesh (str or nil): The mesh to use, if any
- node_box (table): Standard **Minetest** nodebox

**unimobs.petz_api.register_egg_entity(data_table)**

*Original to unimobs*

Registers an egg in the form of an entity, which is converted to a craftitem when picked up by the player. (This solves the problem of penguin eggs in the original code, which are spawned as craftitems, and which therefore never hatch.)

**data_table** compulsory fields:

- mob_type (str): e.g. "penguin_normal"
- orig_name (str): e.g. The name of the original craftitem, e.g. "petz:penguin_egg"

**data_table** optional fields:

- replace_mode (str): e.g. "defer"
- baby_name (str): If not specified, "unilib:mob_TYPE", where TYPE is **data_table.mob_type**
- description (str): e.g. "Normal Penguin Egg"
- satiation (int): The value used in the call to **unilib.cuisine.eat_on_use()** when the craftitem is eaten by the player; 1 if not specified
- scale_factor (float): a value of 1 is approximately the same height as a node; 0.5 is approximately half the height of a node, and so on. Default value is 0.5

### 8.3.21 petz_replenish.lua

**unimobs.petz_api.register_replenish_extension(mob_type, callback)**

*Original to unimobs*

Called by any package which wants to extend the standard behaviour, when a mob is to be replenished.

**unimobs.petz_api.replenish_mob(self, clicker)**

*From petz.refill()*

Replenish the mob, for example by restoring sheared wool, refilling its milk, and so on. If there is nothing to replenish, then do nothing.

**clicker** is an optional argument, specified only when a player is the cause of the event (e.g. by feeding a sheep).

**unimobs.petz_api.extract_milk_from_mob(self, clicker, full_bucket_name)**

*From petz.milk_milk()*

Milk the mob, updating its properties, and generating a full bucket of milk in the player's inventory.

### 8.3.22 petz_settings.lua

**unimobs.petz_api.get_msetting(mob_type, mini_table_key)**

*Original to unimobs*

Wrapper function to extract values from **unimobs.petz_msetting**, which is in the form

        petz_msetting[mob_type] = mini_table

...where **mob_type** is a string like "lion_normal".

If we try to access the key-value pairs in the **mini_table** directly, there's a risk that the **mini_table** doesn't exist at all, creating a crash; this function checks that "lion_normal" exists as key in **unimobs.petz_msetting**, before extracting the value matching **mini_table_key**.

**unimobs.petz_api.initialise_msetting(mob_type, mini_table_key, mini_table_value)**

*Original to unimobs*

Wrapper function to initialise a field in **unimobs.petz_msetting**, which is in the form

        petz_msetting[mob_type] = mini_table

...where **mob_type** is a string like "lion_normal".

The contents of **unimobs.petz_msetting** should be initialised by the the remix CSV. If a default value is required, a mob package can call this function to set that default value, in case the remix CSV didn't set a value at all.

However, this should be a rare occurence; compare **unimobs.petz_api.initialise_custom_msetting()**, which is called by mob packages in almost all cases, in order to set a default value.

If **unimobs.petz_msetting[mob_type]** does not exist, it is created.

If **unimobs.petz_msetting[mob_type][mini_table_key]** already exists, it is not overwritten; this function returns false.

Otherwise, this function adds the specified key-value pair to the **mini_table**, and returns true.

**unimobs.petz_api.check_msetting_by_group(mob_type, mini_table_key, check_value)**

*Original to unimobs*

Wrapper function to test values from **unimobs.petz_msetting**, which is in the form

        petz_msetting[mob_type] = mini_table

...where **mob_type** is a string like "lion_normal".

If the specified **mob_type** or **mini_table_key** don't exist, we return false.

If the value corresponding to **mini_table_key** is a group name (e.g. **group:stick**), we assume that **check_value** is the name of an item (e.g. **unilib:item_stick_ordinary**), and return true if that item contains the group, false if not.

Otherwise, we just compare the value corresponding to **mini_table_key** directly, returning true if they're identical, false if not.

**unimobs.petz_api.get_custom_msetting(mob_type, mini_table_key)**

*Original to unimobs*

Wrapper function to extract values from the **.custom_table** field in **unimobs.petz_msetting**.

Table in the form

        petz_msetting[mob_type]["custom_table"] = mini_table

...where **mob_type** is a string like "lion_normal"

If we try to access the key-value pairs in the **mini_table** directly, there's a risk that the **mini_table** doesn't exist at all, creating a crash; this function checks that "lion_normal" exists as a key in **unimobs.petz_msetting**, before extracting the value matching **mini_table_key**.

**unimobs.petz_api.initialise_custom_msetting(mob_type, mini_table_key, mini_table_value)**

*Original to unimobs*

Wrapper function to initialise a field of the **.custom_table** field in **unimobs.petz_msetting**.

Table in the form

        petz_msetting[mob_type]["custom_table"] = mini_table

...where **mob_type** is a string like "lion_normal"

The contents of **unimobs.petz_msetting.custom_table** should be initialised by the the remix CSV. If a default value is required, a mob package can call this function to set that  default value, in case the remix CSV didn't set a value at all.

In almost all cases, mob packages should call this function to set a default value

If **unimobs.petz_msetting[mob_type]["custom_table"]** does not exist, it is created.

If **unimobs.petz_msetting[mob_type]["custom_table"][mini_table_key]** already exists, it is not overwritten; this function returns false.

Otherwise, this function adds the specified key-value pair to the **.custom_table** field, and returns true.

**unimobs.petz_api.check_custom_msetting_by_group(mob_type, mini_table_key, check_value)**

*Original to unimobs*

Wrapper function to test values from the **.custom_table** field in **unimobs.petz_msetting**.

Table in the form

        petz_msetting[mob_type]["custom_table"] = mini_table

...where **mob_type** is a string like "lion_normal"

If the specified **mob_type** or **mini_table_key** don't exist, we return false.

If the value corresponding to **mini_table_key** is a group name (e.g. **group:stick**), we assume that **check_value** is the name of an item (e.g. **unilib:item_stick_ordinary**), and return true if that item contains the group, false if not.

Otherwise, we just compare the value corresponding to **mini_table_key** directly, returning true if they're identical, false if not.

**unimobs.petz_api.check_lookup_table_in_msetting(mob_type, mini_table_key, lookup_table_key)**

*Original to unimobs*

Wrapper function to test whether the specified **lookup_table_key** exists in **unimobs.petz_msetting**, in the special situation in which the value corresponding to **mini_table_key** is a lookup table.

Table in the form

        petz_msetting[mob_type][mini_table][lookup_table]

...where **mob_type** is a string like "lion_normal", and **lookup_table** consists of a table of keys, whose values are irrelevant (in most cases, they should be set to true).

If we try to access the key-value pairs in the **lookup_table** directly, there's a risk that the **lookup_table** doesn't exist at all, creating a crash; this function checks that, before testing whether **lookup_table_key** exists in **lookup_table**.

**unimobs.petz_api.check_lookup_table_in_msetting_by_group(mob_type, mini_table_key, lookup_table_key)**

*Original to unimobs*

Alternative to **unimobs.petz_api.check_lookup_table_in_msetting()**, in which we assume that the lookup table specified by **mob_type** and **mini_table_key** can contain either names of items (e.g. **unilib:item_stick_ordinary**), group names (e.g. **group:stick**), or some other arbitrary value.

If the lookup table actually contains the specified **lookup_table_key**, then return true, as before.

Otherwise, assume that **lookup_table_key** is the name of an item, and check the keys in that same table, returning true if a matching group is found.

### 8.3.23 petz_sleep.lua

**unimobs.petz_api.calculate_sleep_times(self)**

*From petz.calculate_sleep_times()*

Called from **unimobs.petz_api.calculate_sleep_times()**.

If sleeping is enabled, sets the specified mob's **.sleep_start_time** and **.sleep_end_time** properties.

**unimobs.petz_api.send_mob_to_sleep(self, priority, force_flag)**

*From petz.sleep()*

Can be called by anything, to put the specified mob into sleep mode.

Having set new textures and a few properties, starts the **hqb_sleep_until_wake_up** behaviour (so sleep mode won't start if that package is not loaded).

The **priority** and **force_flag** arguments are passed directly to the **hqb_sleep_until_wake_up** behaviour.

### 8.3.24 petz_spawn.lua

**unimobs.petz_api.check_mob_limit(pos, mob_type, optional_search_radius)**

*From petz.limit_reached()*

Counts the number of mobs within the specified **optional_search_radius** (if not specified, then the search radius is 50).

Returns true if the number of mobs is already at the maximum; false if we're still below the limits specified by settings.

There are two limits specified by settings: a maximum number of (all) mobs, and a maximum number of mobs of the same type; both limits are checked.

**unimobs.petz_api.refine_spawn_position(mob_type, pos)**

*From petz.pos_to_spawn()*

When a mob is due to be spawn at position **pos**, tweak the y component of the position, hoping to make the mob spawn just above the surface, regardless of its size.

**unimobs.petz_api.spawn_mob(spawn_pos, liquid_flag, abr, check_limits_flag)**

*From petz.spawn_mob()*

Spawns one or more mobs, at or near the specified **spawn_pos**.

Usually called by **core.register_globalstep()**, but is available to be called by other code, when appropriate.

Returns a list of spawned entities (may be an empty list).

**liquid_flag** should be true if **spawn_pos** is in a liquid.

If **check_limits_flag** is true, check the population limits specified by settings, before spawning mobs.

### 8.3.25 petz_tamagotchi.lua

**unimobs.petz_api.register_tamagotchi_extension(mob_type, callback)**

*Original to unimobs*

Called by any package which wants to extend the standard behaviour, when a Tamagotchi Mode check occurs.

**unimobs.petz_api.calculate_affinity_change(rate)**

*From petz.calculate_affinity_change()*

In Tamagotchi Mode, calculates the increase/decrease in the mob's affinity, given the specified **rate** of change.

Affinity increases if **rate** is positive, but decreases if **rate** is negative.

**unimobs.petz_api.init_tamagotchi_timer(self)**

*From petz.init_tamagochi_timer()*

Called by **unimobs.petz_api.set_initial_properties()** and **unimobs.petz_api.on_step_callback()**.

When a mob is compatible with Tamagotchi Mode, its **.init_tamagotchi_timer_flag** is initially set to true, which starts the timer (and sets the flag back to false).

The flag can be set back to true at any time in order to re-initiate the timer.

**unimobs.petz_api.set_mob_affinity(self, rate)**

*From petz.set_affinity()*

In Tamagotchi Mode, sets the mob's affinity according to the specified **rate** of change.

Affinity increases if **rate** is positive, but decreases if **rate** is negative.

**unimobs.petz_api.update_tamagotchi_mob_after_feed(self)**

*From petz.do_feed()*

In Tamagotchi Mode, this function is called after a creature is fed, in order to update its properties.

**unimobs.petz_api.update_tamagotchi_mob_after_tame(self)**

*From petz.after_tame()*

This function can be called for all mobs, so that in Tamagotchi Mode, its properties can be updated.

### 8.3.26 petz_tame.lua

**unimobs.petz_api.tame_mob_with_lash(self, puncher)**

*From petz.tame_whip()*

Called by **unimobs.petz_api.on_punch_callback()** for a mob with the **.is_wild_flag** property.

Such mobs can be tamed using a lash (such as an obedience whip). In Tamagotchi Mode, a lash maintains the mob's affinity.
Returns true if the mob is tamed during this call, false otherwise (if the mob was already tamed, has not been tamed yet, or if **puncher** is not wielding a suitable lash).

**unimobs.petz_api.abandon_tamed_mob(self, msg)**

*From petz.abandon_pet()*

Resets the properties of a tamed mob to make it an untamed mob, and displays the specified message.

### 8.3.27 petz_teleport.lua

**unimobs.petz_api.teleport_mob_back_home(self)**

*From petz.back_home()*

Teleportation function for mobs which have a dreamcatcher, or which have any other item which sets the mob's **.back_home_flag** to true, and **.back_home_pos **to a home position.

Normally called by **unimobs.petz_api.on_step_callback()**, but is available for any other code that wants it.

### 8.3.28 petz_textures.lua

**unimobs.petz_api.compile_texture_list(mob_type, skin_init_list)**

*Original to unimobs*

Called by various mob packages, in order to produce a simple list of textures, to be used in the **unilib.register_entity()** call (as the **.initial_properties.textures** field).

**skin_init_list** is a list of mini-lists, each in the form

        { skin_type, skin_name, relative_probability }

...for example,

        { "brown", S("Brown"), 1 }

**unimobs.petz_api.register_texture_override(mob_type, callback)**

*Original to unimobs*

Called by any package which wants to override the default skin.

**unimobs.petz_api.get_skin_description(self)**

*Original to unimobs*

Get a displayable description of the specified mob's current skin, or an empty string on failure.

**unimobs.petz_api.colourise_mob(self, colour)**

*From petz.colorize()*

Can be called by any code in order to colourise a mob; commonly called when sheep are colourised using dye.

This function expects that two special textures for the specified mob exist, in the form "unilib_mob_MOBTYPE_bg.png" and "unilib_mob_MOBTYPE_overlay.png (where MOBTYPE matches **self.mob_type**).

**colour** is a **Minetest** ColorString. Use the **unimobs.petz_api.get_colour_group()** function to obtain the  ColorString associated with an item, such as a dye.

**unimobs.petz_api.get_mob_colourisation(self)**

*Original to unimobs*

An alternative to **unimobs.petz_api.colourise_mob()**, when we don't want to update the entity's colourised skin texture directly, but just retrieve it.

**unimobs.petz_api.get_colour_group(full_name)**

*From petz.get_color_group()*

**full_name** is an item whose **.groups** field has a colour group such as "colour_red" or "colour_green_dark" (or the American equivalents, "color_red" and so on).

**full_name** is usually a dye, but can be any other item with a colour_X/color_X group.

Returns the colour of the first colour group found, e.g. "red", "green_dark" (or nil if the item has no colour group).

**unimobs.petz_api.revert_mob_colourisation(self, img)**

*Code adapted from parts of petz.lamb_wool_shave(), and moved to this new function*

Resets changes to the mob, made in an earlier call to **unimobs.petz_api.colourise_mob()**; the calling code must supply a replacement texture.

**unimobs.petz_api.compose_skin_texture(self)**

*From petz.compose_texture()*

Returns a texture to be used as the specified mob's skin. The texture may be the default one,  or one supplied by an override function.

For mountable mobs, the returned texture will include overlays for the saddle and/or saddle-bag, when necessary

### 8.3.29 petz_utils.lua

**unimobs.petz_api.get_mob_height(self)**

*Was petz.check_height()*

Checks the specified mob's height above the surface (or above the nearest block directly below, in case of buildings, trees etc).

If the height is within the mob's **.max_roam_height**, then returns the height; otherwise returns nil.

**unimobs.petz_api.get_node_at_named_location(self, location)**

*Was petz.node_name_in()*

On success, returns a list of two values:

- The pos of the specified **location**, relative to the specified mob
- The node at that pos

On failure, returns nil.

The **location** argument must be one of the strings "front", "top", "below", "back", "self", "front_top" or "front_below".

**unimobs.petz_api.is_mob_in_group(self)**

*Was petz.bh_check_pack()*

Returns true if the specified mob is close to another mob of the same type.

This is useful for certain types of mob in certain situations; for example, for wolves in hunting mode, the calling code might be able to assume that they are behaving as if in a wolfpack.

**unimobs.petz_api.is_mob_standing_still(self)**

*Was petz.is_standing()*

Returns true if the mob's (scalar) speed is 0, false otherwise.

**unimobs.petz_api.is_mob_jumping(self)**

*Was petz.is_jumping()*

Counterpart to **unimobs.petz_api.is_mob_standing_still()**; this function is really just a wrapper to check **self.isonground**; in **unimobs**, we retain the function rather than checking **self.isonground** directly, so that a block of code that checks both functions is easier to read.

**unimobs.petz_api.is_obstacle_in_front_of_mob(self)**

*Was petz.check_front_obstacle()*

Returns true if there are any obstacles in front of the mob, checking up to a maximum distance (default value is 5); false otherwise.

N.B. This is the OPPOSITE behaviour of the original function, which returned false when an obstacle was detected.

**unimobs.petz_api.convert_value_to_stringified_bool(val)**

*From petz.vartostring()*

Converts any value to a stringified boolean, returning either the string "true" or the string "false".

"false" is returned when the specified **val** is nil, 0 or false.

**unimobs.petz_api.get_pos_behind_player(player)**

*Adapted from petz.get_player_back_pos()*

Returns the pos behind the specified **player**.

N.B. The original version of this function returned two values, the position itself and the node at that position.

**unimobs.petz_api.get_pos_in_front_of_player(player)**

*From petz.pos_front_player()*

Returns the pos in front of the specified **player**.

**unimobs.petz_api.is_day()**

*Original to unimobs, adapted from petz.is_night()*

Returns true during the day, false at night, or nil if the world has not yet been loaded.

**unimobs.petz_api.is_mob_in_liquid(self)**

*From petz.isinliquid()*

Returns true if the specified mob is in a liquid, false otherwise.

**unimobs.petz_api.is_night()**

*From petz.is_night()*

Returns true at night, false during the day, or nil if the world has not yet been loaded.

**unimobs.petz_api.is_string_empty(val)**

*From petz.str_is_empty()*

Returns true if the specified **val** is an empty string (or nil); false otherwise.

**unimobs.petz_api.set_mob_properties(self, prop_table)**

*From petz.set_properties()*

Sets the specified mob's properties, first checking that the **self** argument is the correct thing to be updating.

**unimobs.petz_api.round_numeric_value(value, decimal_places)**

*Original to unimobs*

Rounds up/down a numeric value to the specified precision.

**unimobs.petz_api.truncate_numeric_value(value, decimal_places)**

*From petz.truncate()*

Rounds down a numeric value to the specified precision.

**unimobs.petz_api.get_os_month()**

*From petz.get_os_month()*

Returns a number in the range 1-12, representing the current (real-world) month.

**unimobs.petz_api.can_jump_in_liquid(self, pos)**

*Was petz.can_jump()*

Called by **unilib.pkg.brain_aquatic.brain()** to test whether a mob in a liquid can jump. If successful, the calling code launches the **hqb_aqua_jump** behaviour.

**unimobs.petz_api.check_tree(self)**

*Was petz.check_tree()*

Called by the **mtb_climb_tree** and **hqb_climb_tree** packages.

Checks whether the specified mob can climb the tree in front of it.

**unimobs.petz_api.is_tree_like(node)**

*Was petz.is_tree_like()*

Checks whether the specified **node** it a tree trunk or leaves node.

**unimobs.petz_api.get_displayable_formspec_image(def_table)**

*Adapted from code in /petz/petz/api/api_forms.lua*

Returns an image that can be added to a formspec string.

For craftitems, returns the **.inventory_image**, but for nodes, returns an inventory cube. On failure, return an empty string.

**unimobs.petz_api.is_pos_inside_collisionbox(self, pos, box_pos, cbox)**

*Was petz.is_pos_in_box()*

Returns true if the specified **pos** is inside the specified mob's collision box **cbox** at the position **box_pos**, taking into account any offset specified in the mob's properties.

**unimobs.petz_api.get_insertion(mob_type, insertion_type)**

*Original to unimobs*

Convenience function for looking up a value in a translation insertion table in **unimobs.petz_global.mob_table**.

**insertion_type** should be one of the strings "subject", "subject_an", "subject_the", "object", "object_an", "object_the".

**unimobs.petz_api.get_random_interval(average_time)**

*Original to unimobs, using code split off from unimobs.petz_api.lay_egg()*

Returns a random value in the vicinity of **average_time**, plus or minus 20%.

**unimobs.petz_api.get_standard_visual_size(scale_factor)**

*Original to unimobs*

Returns a standard **.visual_size** table for those mobs that use it.

**unimobs.petz_api.pos_to_string(pos, decimal_places)**

*Original to unimobs*

Truncates the values in the specified **pos**, then returns the return value of a call to **core.pos_to_string()**.

This ensures that (for example) any log messages use values like 11.7, and not values like 11.700000762939.

## 8.4 API functions derived from other mods

### 8.4.1 misc_harm_bars.lua

These functions are derived from the Visual Harm 1ndicators (vis_harm_1nd) mod.

When settings are enabled (as they are by default), harm bars are drawn above players and mobs whose health is below the maximum.

**unimobs.misc_api.update_harm_bar(obj, hp, hp_max)**

*Was VH1.update_bar()*

Called for all mobs - even mobkit-exclusive ones - by **unimobs.mobkit_api.check_vitals()**, which in turn is called by most brain packages.

Other code (particularly any new brain packages you write) could call this function directly, if necessary. In that case, it should be called whenever an object's HP changes.

The "hp" and "hp_max" arguments are optional. If not specified, the built-in **obj:get_hp()** and **obj:get_properties().max_hp** values are used instead (which may not match the values used internally by **unimobs**).

**unimobs.misc_api.clear_harm_bar(obj)**

*Was VH1.clear_bar()*

Removes the specified object's harm bar entity, updating local variables.

If this function is not called explicitly on death, the harm bar entity will still be removed automatically when the parent **obj** is removed.

**unimobs.misc_api.clear_harm_bar_after_delay(obj)**

*Was VH1.clear_bar_delay()*

Sets the timer to remove the specified object's harm bar entity, after a short delay (1 second by default).

**unimobs.misc_api.set_harm_bar_default_size(x, y)**

*Was VH1.set_default_size()*

Can be called by any code to change the default size of harm bars. The default size is {x=0.8, y=0.1}.
