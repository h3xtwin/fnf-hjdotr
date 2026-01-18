function onCreate()
	setProperty('camHUD.alpha', 0)
	
	setProperty('skipCountdown', true)
	makeLuaSprite('theSky', 'john/Sky', 400, 350)
	addLuaSprite('theSky', false)
	setLuaSpriteScrollFactor('theSky', 0.7, 0.9);
	
	makeLuaSprite('theGlowSky', 'john/Wowie', 400, 350)
	addLuaSprite('theGlowSky', false)
	setLuaSpriteScrollFactor('theGlowSky', 0.7, 0.9);
	setProperty('theGlowSky.alpha', 0);
	
	makeLuaSprite('theWhat', 'john/What', -300, -50)
	addLuaSprite('theWhat', false)
	setLuaSpriteScrollFactor('theWhat', 1, 1);
	
	makeLuaSprite('theBG', 'john/BOMB', -300, -50)
	addLuaSprite('theBG', false)
	setLuaSpriteScrollFactor('theBG', 1, 1);
	
	makeLuaSprite('theGlowBG', 'john/WOAHHH', -300, -50)
	addLuaSprite('theGlowBG', false)
	setLuaSpriteScrollFactor('theGlowBG', 1, 1);
	setProperty('theGlowBG.alpha', 0);

	makeLuaSprite('BlackScreen', 'john/IdkHowToFade', 0,0)
	setProperty("BlackScreen.scale.x", 10)
	setProperty("BlackScreen.scale.y", 10)
	setProperty('BlackScreen.alpha', 0);
	addLuaSprite('BlackScreen',true)

	end
	
	function onSongStart()
	setProperty('gf.visible', false);
	end
	
	function onUpdate(elapsed)
	
	if curBeat >= 68 and curBeat < 72 then
	setProperty('theBG.alpha', (getProperty('theBG.alpha')-0.008));
	setProperty('theSky.alpha', (getProperty('theSky.alpha')-0.004));
	end
	
	if curBeat >= 72 and curBeat < 200 then
	setProperty('theGlowSky.alpha', (getProperty('theGlowSky.alpha')-0.04));
	end
	
	if curBeat >= 328 and curBeat < 332 then
	setProperty('theBG.alpha', (getProperty('theBG.alpha')-0.008));
	setProperty('theSky.alpha', (getProperty('theSky.alpha')-0.004));
	end
	
	if curBeat >= 332 then
	setProperty('theGlowSky.alpha', (getProperty('theGlowSky.alpha')-0.04));
	end
	end
	
	function onBeatHit()
	
	if curBeat == 8 then
	doTweenAlpha('dadFadeEventTween', 'camHUD', 1, 2, 'linear');
	end
	
	if curBeat >= 72 and curBeat < 200 then
	if curBeat % 2 then
	setProperty('theGlowBG.alpha', 1);
	setProperty('theGlowSky.alpha', 1);
	doTweenAlpha('dadFadeEventTween', 'theGlowBG', 0, 0.5, 'linear');
	end
	end
	
	if curBeat == 200 then
	setProperty('theGlowBG.alpha', 0);
	setProperty('theGlowSky.alpha', 0);
	setProperty('theSky.alpha', 1);
	doTweenAlpha('dadFadeEventTween', 'theBG', 1, 2, 'linear');
	end
	
	if curBeat >= 332 then
	if curBeat % 2 then
	setProperty('theGlowBG.alpha', 1);
	setProperty('theGlowSky.alpha', 1);
	doTweenAlpha('dadFadeEventTween', 'theGlowBG', 0, 0.5, 'linear');
	end
	end
	
	if curBeat == 394 then
	doTweenAlpha('dadFadeEventTween', 'camHUD', 0, 5, 'linear');
	end
	if curBeat >= 460 then
	doTweenAlpha("dadFadeEventTween", "BlackScreen",1,0.6,'linear')
	end

	
	end