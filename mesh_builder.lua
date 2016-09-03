-- Terra Battle AutoTouch Utilities (compatible with TouchElf) --
-- Author: Xiaoxi Wang -- --


local floor = math.floor
local width, height = getScreenResolution()
--local width, height = 750, 1336 -- only for test
local hw_rate = height / width
-- local game_width = width
-- local game_height = height
-- local game_ox = 0               -- original point x (game)
-- local game_oy = 0               -- original point y (game)

-- build mesh table to save coordinates
local mesh_size
local mesh_ox                   -- original point x (mesh)
local mesh_oy                   -- original point y (mesh)

local mesh = { x = {{true, true, true, true, true, true}, 
                    {true, true, true, true, true, true},
                    {true, true, true, true, true, true},
                    {true, true, true, true, true, true},
                    {true, true, true, true, true, true},
                    {true, true, true, true, true, true},
                    {true, true, true, true, true, true},
                    {true, true, true, true, true, true}},
               y = {{true, true, true, true, true, true},
                    {true, true, true, true, true, true},
                    {true, true, true, true, true, true},
                    {true, true, true, true, true, true},
                    {true, true, true, true, true, true},
                    {true, true, true, true, true, true},
                    {true, true, true, true, true, true},
                    {true, true, true, true, true, true}}}  -- 8 x 6 mesh to save (x, y)

-- game canvas 568:960 --
-- game height seperation: 45:337:18 (if total is 400) (may wrong)
-- mesh: 8x6 --

if hw_rate >= 1.80 then
    -- alert("This phone is tall!")
    mesh_size = (width - 2) / 6  -- 1px for left & right margin
    mesh_ox = width  / 2 - mesh_size * 3
    mesh_oy = height / 2 - mesh_size * 3.5
    for row = 1, 8 do
        for col = 1, 6 do
            mesh['x'][row][col] = mesh_ox + (col - 0.5) * mesh_size
            mesh['y'][row][col] = mesh_oy + (row - 0.5) * mesh_size
        end
    end
    --[[ DEBUG
    log(string.format("width: %f\nheight: %f\nmesh size: %f\nupperleft: (%f, %f)\nupperright: (%f, %f)\nlowerleft: (%f, %f)\nlowerright: (%f, %f)", 
        width,
        height,
        mesh_size,
        mesh[1][1][1], mesh[1][1][2], 
        mesh[1][6][1], mesh[1][6][2],
        mesh[8][1][1], mesh[8][1][2],
        mesh[8][6][1], mesh[8][6][2]))
    --]]
else
    -- alert("This phone is stout!")
    game_width = height / 1.8
    mesh_size = (game_width - 2) / 6
    mesh_ox = width  / 2 - mesh_size * 3
    mesh_oy = height / 2 - mesh_size * 3.5
    for row = 1, 8 do
        for col = 1, 6 do
            mesh['x'][row][col] = mesh_ox + (col - 0.5) * mesh_size
            mesh['y'][row][col] = mesh_oy + (row - 0.5) * mesh_size
        end
    end
end

-- save buttons coordinates (will be added in future)


-- scripts

local ret = {}

local function mesh2coords(row, col)
    return mesh['x'][row][col], mesh['y'][row][col]
end

local function meshshot(filePath, row, col)
    local x, y = mesh2coords(row, col)
    local x1 = floor(x - mesh_size / 2 + 0.5)
    local y1 = floor(y - mesh_size / 2 + 0.5)
    screenshot(filePath, {x1, y1, mesh_size, mesh_size})
end

ret.mesh_size = mesh_size
ret.mesh = mesh
ret.mesh2coords = mesh2coords
ret.meshshot = meshshot

return ret






