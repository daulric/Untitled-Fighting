local devbox = require(game.ReplicatedStorage.Packages.devbox)

local Controllers = devbox.controllers

local TimeController = Controllers.CreateController {
	Name = "Number to Time",
}

function TimeController:Convert(Time)
	local minute = tostring(math.floor(Time / 60))
	local seconds = math.floor(Time%60)
	
	if seconds < 10 then
		seconds = "0"..tostring(math.floor(Time%60))
	end
	
	return minute..":"..seconds	
end

return TimeController