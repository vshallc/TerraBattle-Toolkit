-- Map TouchElf functions to AutoTouch functions --
-- Compatibility for other Lua-based tools might be added later


-- Note: it is unnesscery to map touchUp(id) in touchElf to touchUp(id, x, y)
-- since the tailing x, y will be ignored

-- Map logDebug to log
if log == nil then
    if logDebug ~= nil then
        log = logDebug
    end
end


-- Map notifyMessage to alert
if alert == nil then
    if notifyMessage ~= nil then
        alert = notifyMessage
    end
end

-- Map mSleep to usleep
if usleep == nil then
    if mSleep ~= nil then
        local ceil = math.ceil
        function usleep(microseconds)
            mSleep(ceil(microseconds/1000))
        end
    end
end


-- Map snapshotRegion(picpath, x1, y1, x2, y2, quality) to screenshot(filePath, region)
-- Note:1) region: {x, y, width, height}
--      2) we ignore the quality parameter
--      3) AutoTouch only support .bmp while TouchElf support both .bmp and .jpg

if screenshot == nil then
    if snapshotRegion ~= nil and snapshotScreen ~= nil then
        function screenshot(filePath, region)
            if region == nil then
                snapshotScreen(filePath)
            else
                snapshotRegion(filePath, region[1], region[2], region[1] + region[3], region[2] + region[4])
            end
        end
    end
end

-- create an empty main() function for touchElf

function main()
    return 0
end


