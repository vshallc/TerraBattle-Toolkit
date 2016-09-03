-- Terra Battle AutoTouch Utilities (compatible with TouchElf) --
-- -- Author: Xiaoxi Wang -- --

local mesh_ret = require "mesh_builder"
-- local mesh = mesh_ret.mesh
local mesh_size = mesh_ret.mesh_size
local mesh2coords = mesh_ret.mesh2coords
local meshshot = mesh_ret.meshshot

local acts = {}

--
-- speed 6px/ms
local SPEED = mesh_size / 3.999
local SHORT_SLEEP_TIME = 5000      -- 0.010s
local MEDIUM_SLEEP_TIME = 50000     -- 0.050s
local LONG_SLEEP_TIME = 1000000     -- 1.000s
--[[
local SHORT_SLEEP_TIME = 200000     -- 0.20s
local MEDIUM_SLEEP_TIME = 500000    -- 0.50s
local LONG_SLEEP_TIME = 5000000     -- 5.00s
--]]
local FINGER_ID = 9

local floor = math.floor
local max = math.max
local abs = math.abs

local sx, sy

local function meshTo(r, c)
    local nx, ny = mesh2coords(r, c)
    local dx = nx - sx
    local dy = ny - sy
    local dist = abs(dx) + abs(dy)
    local speed_x = SPEED * dx / dist
    local speed_y = SPEED * dy / dist
    local xx, yy = sx, sy
    local n_steps = floor(abs(dx / speed_x))
    for k = 1, n_steps do
        xx = xx + speed_x
        yy = yy + speed_y
        touchMove(FINGER_ID, xx, yy)
        usleep(SHORT_SLEEP_TIME)
    end
    sx, sy = nx, ny
    touchMove(FINGER_ID, sx, sy)
    usleep(SHORT_SLEEP_TIME)
end

local function tap(r, c)
    sx, sy = mesh2coords(r, c)
    touchDown(FINGER_ID, sx, sy)
    usleep(MEDIUM_SLEEP_TIME)
    touchUp(FINGER_ID, sx, sy)
    usleep(SHORT_SLEEP_TIME)
end

local function meshDown(r, c)
    sx, sy = mesh2coords(r, c)
    touchDown(FINGER_ID, sx, sy)
    usleep(MEDIUM_SLEEP_TIME)
end

local function meshUp()
    touchUp(FINGER_ID, sx, sy)
    usleep(MEDIUM_SLEEP_TIME)
end

--[[
local function meshTo(r, c)
    sx, sy = mesh2coords(r, c)
    touchMove(FINGER_ID, sx, sy)
    usleep(SHORT_SLEEP_TIME)
end
]]--

local function roll(r, c, ...)
    local stops = {...}
    local n = #stops
    meshDown(r, c)
    local last_r, last_c = r, c
    --local last_r, last_c = stops[1], stops[2]
    --meshDown(last_r, last_c)
    local dr, dc, d_max, step_r, step_c
    for i = 1, n, 2 do
        meshTo(stops[i], stops[i+1])
        usleep(SHORT_SLEEP_TIME)
        usleep(SHORT_SLEEP_TIME)
        --[[
        dr = stops[i] - last_r
        dc = stops[i+1] - last_c
        d_max = max(abs(dr), abs(dc))
        step_r = dr / d_max
        step_c = dc / d_max
        --log(string.format("last_r: %f last_c: %f\ndr: %f dc: %f\nd_max: %f\nstep_r: %f, step_c: %f",
        --                   last_r, last_c, dr, dc, d_max, step_r, step_c))
        for i = 1, d_max do
            local tmp_r = last_r + step_r * i
            local tmp_c = last_c + step_c * i
            --log(string.format("row: %f col: %f", tmp_r, tmp_c))
            meshTo(tmp_r, tmp_c)
            --meshTo(last_r + step_r * i, last_c + step_c * i)
        end
        last_r, last_c = stops[i], stops[i+1]
        ]]--
    end
    meshUp()
end


acts.tap = tap
acts.meshDown = meshDown
acts.meshUp = meshUp
acts.meshTo = meshTo
acts.roll = roll
acts.meshshot = meshshot

return acts

