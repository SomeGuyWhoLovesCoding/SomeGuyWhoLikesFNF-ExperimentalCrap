local targetTime = 173060; -- In milliseconds!

function onCreatePost()
	--setProperty("timeBar.scale.x", 1.4)
	--setProperty("timeBarBG.scale.x", 1.4)
	setProperty("timeBar.origin.x", 0)
	setProperty("timeBarBG.origin.x", 0)
end

local timeBGReducedScaling = 0;
function onUpdatePost(elapsed)
	elapsed = elapsed + elapsed
	setProperty("songLength", targetTime)
	if getSongPosition() < targetTime then
		setTextString('timeTxt', formatTime(targetTime - getSongPosition()))
	else
		-- Reduced scaling was 0.000002 btw
		timeBGReducedScaling = timeBGReducedScaling + (0.34612 / targetTime) * playbackRate; -- DO NOT CHANGE THIS!!
		setTextString('timeTxt', "-" .. formatTime(getSongPosition() - targetTime))
		scaleObject("timeBar", (getSongPosition() / targetTime), 1)
		scaleObject("timeBarBG", getProperty("timeBar.scale.x") - timeBGReducedScaling, 1)
		--debugPrint(getProperty('timeBar.scale.x'))
	end
end

function formatTime(millisecond)
    local seconds = math.floor(millisecond / 1000)
    return string.format("%02d:%02d", (seconds / 60) % 60, seconds % 60)  
end