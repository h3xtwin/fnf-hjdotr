-- THANK YOU DREW ILY


function onCreatePost()
	initLuaShader("EarthBound_BG")

	makeLuaSprite("bg", "menuBG", 0, 0)
	setObjectCamera("bg", "camHUD")
	addLuaSprite("bg")

	setSpriteShader("bg", "EarthBound_BG")
end

function onUpdatePost(elapsed)
	-- Simple waves, horizontal

	-- Sets the amplitude
	setShaderFloatArray("bg", "amplitude1", {0.25, 0}) -- X and Y

	-- Sets the wave frequency
	setShaderFloatArray("bg", "frequency1", {10, 0}) -- X and Y

	-- The SNES only supported one direction at a time, but here you can use both!

	-- To animate the wave effect, we need to advance time, this also works as wave speed
	-- Giygas first phase doesn't use this, instead it animates the amplitude on X, then Y
	setShaderFloat("bg", "time1", os.clock())

	-- SNES Grid Snap
	-- Will make the image look pixelated according to the SNES Resolution
	setShaderBool("bg", "snesGridSnap", false) -- set it to true to activate

	-- Interweaving
	-- Odd scanlines will wave in the opposite direction horizontally
	-- This is used in Giygas 2nd phase, along with animated time and amplitude on X
	setShaderBool("bg", "interweaved1", false) -- set it to true to activate

	-- 2nd layer
	-- The SNES supports a 2nd layer for the background, with limited color palette
	-- we don't have that limitation here

	-- setShaderSampler2D("bg", "secondLayer", "path/to/your/image")
	-- to control the second layer, use time2, amplitude2, offset2 and so on

	-- this is used in Giygas first background as a fainter image
	-- you can control layer alpha with:
	-- setShaderFloat("bg", "alpha2", 1)
end