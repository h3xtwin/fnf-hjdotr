function onCreate()
	setProperty('skipCountdown', true)

	makeLuaSprite('theBG', 'john/RenxsHouse', -450, 0)
	addLuaSprite('theBG', false)

end

function onSongStart()
	setProperty('gf.visible', false);
end

function onUpdate(elapsed)
end

function onBeatHit()

end