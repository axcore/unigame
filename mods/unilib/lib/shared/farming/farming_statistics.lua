---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- farming_statistics.lua
--      Statistical functions for farming
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Shortcut
local root_of_2 = math.sqrt(2.0)
-- Values used in approximations for erf(x) and erfInv(x) from
--      https://en.wikipedia.org/wiki/Error_function
local A = 8 * (math.pi - 3.0) / (3.0 * math.pi * (4.0 - math.pi))
local B = 4.0 / math.pi
local C = 2.0 / (math.pi * A)
local D = 1.0 / A
-- Values used in calculating poisson distributions (or something)
local cdf_table = {}

---------------------------------------------------------------------------------------------------
-- Local functions (approximations functions)
---------------------------------------------------------------------------------------------------

local function approx_erf(x)

    -- Error function (N.B. not called by any unilib code)

    if x == 0 then
        return 0
    end

    local xSq = x * x
    local aXSq = A * xSq
    local v = math.sqrt(1.0 - math.exp(-xSq * (B + aXSq) / (1.0 + aXSq)))

    return (x > 0 and v) or -v

end

local function approx_erf_inv(x)

    -- Inverse error function

    if x == 0 then
        return 0
    end

    if x <= -1 or x >= 1 then
        return nil
    end

    local y = math.log(1 - x * x)
    local u = C + 0.5 * y
    local v = math.sqrt(math.sqrt(u * u - D * y) - u)

    return (x > 0 and v) or -v

end

---------------------------------------------------------------------------------------------------
-- Local functions (other functions)
---------------------------------------------------------------------------------------------------

local function std_normal(u)

    return root_of_2 * approx_erf_inv(2.0 * u - 1.0)

end

local function generate_cdf(lambda_index, lambda)

    local max = math.ceil(4 * lambda)
    local pdf = math.exp(-lambda)
    local cdf = pdf
    local t = { [0] = pdf }

    for i = 1, max - 1 do

        pdf = pdf * lambda / i
        cdf = cdf + pdf
        t[i] = cdf

    end

    return t

end

local function poisson(lambda, max)

    if max < 2 then
        return (math.random() < math.exp(-lambda) and 0) or 1
    elseif lambda >= 2 * max then
        return max
    end

    local u = math.random()
    local lambda_index = math.floor(4 * lambda + 0.5)
    local cdfs = cdf_table[lambda_index]

    if cdfs then

        lambda = 0.25 * lambda_index

        if u < cdfs[0] then
            return 0
        end

        if max > #cdfs then
            max = #cdfs + 1
        else
            max = math.floor(max)
        end

        if u >= cdfs[max - 1] then
            return max
        end

        -- Binary search
        if max > 4 then

            local s = 0

            while s + 1 < max do

                local m = math.floor(0.5 * (s + max))

                if u < cdfs[m] then
                    max = m
                else
                    s = m
                end

            end

        else

            for i = 1, max - 1 do

                if u < cdfs[i] then
                    return i
                end

            end

        end

        return max

    else

        local x = lambda + math.sqrt(lambda) * std_normal(u)

        return (x < 0.5 and 0) or (x >= max - 0.5 and max) or math.floor(x + 0.5)

    end

end

---------------------------------------------------------------------------------------------------
-- Statistical functions for farming
---------------------------------------------------------------------------------------------------

function unilib.farming._clamp_to_min_max(x, min, max)

    -- Adapted from farming_redo/init.lua, was .clamp()

    return (x < min and min) or (x > max and max) or x

end

function unilib.farming._do_standard_normal_distribution(mu, sigma)

    -- Standard normal distribution function (mean 0, standard deviation 1)
    --
    -- @param mu
    --    The distribution mean
    -- @param sigma
    --    The distribution standard deviation
    -- @return
    --    Any real number (actually between -3*sigma and 3*sigma)

    local u = math.random()

    if u < 0.001 then
        return mu - 3.0 * sigma
    elseif u > 0.999 then
        return mu + 3.0 * sigma
    end

    return mu + sigma * std_normal(u)

end

function unilib.farming._do_poisson_distribution(lambda, max)

    -- Poisson distribution function
    --
    -- @param lambda
    --    The distribution mean and variance
    -- @param max
    --    The distribution maximum
    -- @return
    --    An integer between 0 and max (both inclusive)

    lambda, max = tonumber(lambda), tonumber(max)

    if not lambda or not max or lambda <= 0 or max < 1 then
        return 0
    end

    return poisson(lambda, max)

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

for li = 1, 100 do
    cdf_table[li] = generate_cdf(li, 0.25 * li)
end
