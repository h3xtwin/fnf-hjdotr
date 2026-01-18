function onBeatHit()

	if curBeat == 156 or curBeat == 160 or curBeat == 164 or curBeat == 168 then
		setProperty('health', getProperty('health')/2)
	end
	
	if curBeat >= 188 and curBeat < 220 then
		if curBeat % 2 then
			setProperty('health', getProperty('health')/1.1)
		end
	end
end