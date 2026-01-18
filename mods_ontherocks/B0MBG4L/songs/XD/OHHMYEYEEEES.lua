local red = 0xff0000;
local cian = 0x00eaff;
local purple = 0xae00ff;
local yellow = 0xfffb00;
local orange = 0xff9500;
local current = red;

function onBeatHit()
	if curBeat >= 332 then
		if curBeat % 1 then
			setProperty('dad.color', current);
			setProperty('boyfriend.color', current);
			setProperty('theSky.color', current);
			setProperty('theGlowSky.color', current);
			setProperty('theBG.color', current);
			setProperty('theGlowBG.color', current);
			if current == red then
				current = cian;
			elseif current == cian then
				current = purple;
			elseif current == purple then
				current = yellow;
			elseif current == yellow then
				current = orange;
			elseif current == orange then
				current = red;
			end
		end
	end
end