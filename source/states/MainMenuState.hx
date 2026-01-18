package states;

import flixel.addons.display.FlxTiledSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.display.FlxBackdrop;
import objects.SpriteFromSheet;
import objects.FunkinSprite;
import flixel.FlxObject;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import states.editors.MasterEditorMenu;
import options.OptionsState;
import openfl.display.Shape;
import openfl.display.BitmapData;
import flixel.graphics.FlxGraphic;

class CodeBG extends FlxSpriteGroup {

	var backdrops:Array<FlxBackdrop> = [];

	public var speed:Float = 100;
	public function new(x:Float = 0,y:Float = 0,_width:Float = 1280,_height:Float = 720) {
		super(x,y);

		final tSize:Int = 24;
		final tWidth:Int = Std.int(tSize * 0.75);

		trace('length ' + Std.int(_width/tWidth));

		for (i in 0...Std.int(_width/tWidth)) {


			var t = new FlxText(0,0,0,FlxG.random.bool(50) ? '0' : '1',tSize);
			t.font = Paths.font('vcr.ttf');
			t.color = FlxColor.LIME;
	
			for (i in 0...3) {
				t.text += FlxG.random.bool(50) ? '\n0' : '\n1';
			}
			@:privateAccess t.regenGraphic();

			// var bgGraphic = t.graphic.bitmap.clone();
			// t.destroy();
			//flxtiled sprite doesnt work well for this sadly
			var s = new FlxBackdrop(t.graphic,Y);
			s.x += t.width * i;
			//trace(s.x + ' LOL: ' + i);
			add(s);
			backdrops.push(s);
			if (i % 2 ==0) s.velocity.y = speed;
			else s.velocity.y = -speed;
		}

		var grad = flixel.util.FlxGradient.createGradientFlxSprite(1, Std.int(_height), ([0x0,FlxColor.BLACK]));
		grad.scale.x = _width;
		grad.updateHitbox();
		add(grad);

	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		// for (k=>i in backdrops) {
		// 	if (!i.active) continue;
		// 	if (k % 2 == 0) i.scrollY += speed * elapsed;
		// 	else i.scrollY -= speed * elapsed;
		// }

	}

}
class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.7.3'; // This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxText>;

	var optionShit:Array<String> = [
		'story',
		'members',
		'settings'
	];

	
	var belly:FlxSprite;
	var chickenOnTheRocks:FlxSprite;
	var bg:FlxSprite;
	var weird:FlxSprite;
	override function create()
	{
		// Paths.clearStoredMemory();
		// Paths.clearUnusedMemory();
		//if(FlxG.sound.music == null) 
			FlxG.sound.playMusic(Paths.music('goonsong'), 0);

		//trace("Directory of music:" + Paths.music('goonsong'));

		Conductor.bpm = 127;

			

		#if MODS_ALLOWED
		Mods.pushGlobalMods();
		#end
		Mods.loadTopMod();

		#if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		// var test = new CodeBG(5,0,FlxG.width * 2);
		// add(test);

		bg = new FlxSprite();
		bg.loadGraphic(Paths.image('boob/ZambieBG'));
		bg.screenCenter();
		bg.origin.set(bg.width / 2, bg.height / 2);
		add(bg);

		var uiRect = new FlxSprite(0, 0);
		uiRect.makeGraphic(230, FlxG.height, FlxColor.BLACK);
		add(uiRect);

		belly = new FlxSprite();
		belly.loadGraphic(Paths.image('boob/belly'));
		belly.screenCenter();
		belly.origin.set(belly.width / 2, belly.height / 2);
		
		belly.scale.set(0.5,0.4);
		belly.x -= 215;
		belly.y -= 185;
		add(belly);


		chickenOnTheRocks = new FlxSprite(330,50);
		chickenOnTheRocks.loadGraphic(Paths.image('boob/ChickenOnTheRocks'));
		chickenOnTheRocks.scale.set(0.50,0.50);
		chickenOnTheRocks.angle = 10;
		add(chickenOnTheRocks);

		var timeOfPeak = 2;


		




		menuItems = new FlxTypedGroup<FlxText>();
		add(menuItems);

		for (i in 0...optionShit.length)
		{

			var scale = FlxG.random.int(1,4);
			var tex = new FlxText(-60,350 + (i * (40 + 30)),0,optionShit[i],40);
			tex.font = Paths.font('ARIAL.TTF');
			var width = tex.width;
			tex.size = Std.int(tex.size/scale);
			tex.setScale(scale);
			tex.x = 50;
			if (i == FlxG.random.int(0,optionShit.length)) {
				tex.x += FlxG.random.int(5,20);
				tex.y += FlxG.random.int(-10,0);
			}
		
			menuItems.add(tex);
		}



		//spawn();
		changeItem();
		selectedSomethin = false;
		scrollingTriangles();


		super.create();
	}


/*
	function spawn() 
	{

		fire.graphicSize(0,FlxG.height);
		var scale = fire.scale.y;
		fire.scale.y = 0;

		logo.visible = false;
		for (i in menuItems) i.visible = false;
		FlxTween.num(0, scale, 2, {onComplete: Void->{

			logo.visible=true;
			logo.animation.play('i');
			logo.animation.finishCallback = (s:String)->{for (i in menuItems) i.visible = true; selectedSomethin=false;}
		}}, (f)->{
			fire.scale.y = f;
			fire.updateHitbox();
			fire.y = FlxG.height - fire.height + 25;
		});
	}
*/
	var selectedSomethin:Bool = true;
	var logoScale:Float = 0.5;
	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.FOUR) FlxG.resetState();


		if (FlxG.sound.music != null) {
			if (FlxG.sound.music.volume < 0.8)
			{
				FlxG.sound.music.volume += 0.5 * elapsed;
				if (FreeplayState.vocals != null)
					FreeplayState.vocals.volume += 0.5 * elapsed;
			}
			Conductor.songPosition = FlxG.sound.music.time;
		}
		
		chickenOnTheRocks.scale.set(FlxMath.lerp(chickenOnTheRocks.scale.x,logoScale,elapsed * 3),FlxMath.lerp(chickenOnTheRocks.scale.y,logoScale,elapsed * 3));
		bg.scale.set(FlxMath.lerp(bg.scale.x, 1.0, elapsed * 3), FlxMath.lerp(bg.scale.y, 1.0, elapsed * 3));
		//belly.scale.set(FlxMath.lerp(belly.scale.x, 0.5, elapsed * 3), FlxMath.lerp(belly.scale.y, 0.4, elapsed * 3));
		if (!selectedSomethin)
		{
			// if (FlxG.keys.justPressed.T) {
			// 	FlxG.switchState(new FreeplayState());
			// }
			if (controls.UI_UP_P || controls.UI_DOWN_P) changeItem(controls.UI_UP_P ? -1 : 1);

			if (controls.ACCEPT)
			{

				FlxG.sound.music?.stop();

				FlxG.sound.play(Paths.sound('bass'));
				selectedSomethin = true;

				FlxFlicker.flicker(menuItems.members[curSelected], 1, 0.06, false, false, function(flick:FlxFlicker)
				{
					switch (optionShit[curSelected])
					{
						case 'story':
							openSubState(new PlayMenu());
							// MusicBeatState.switchState(new PlayMenu());
						case 'members':
							FlxTransitionableState.skipNextTransIn = FlxTransitionableState.skipNextTransOut = true;
							MusicBeatState.switchState(new CreditsState());
						case 'settings':
							FlxTransitionableState.skipNextTransIn = FlxTransitionableState.skipNextTransOut = true;
							MusicBeatState.switchState(new OptionsState());
							OptionsState.onPlayState = false;
							if (PlayState.SONG != null)
							{
								PlayState.SONG.arrowSkin = null;
								PlayState.SONG.splashSkin = null;
								PlayState.stageUI = 'normal';
							}
					}
				});
			}
			#if debug
			if (controls.justPressed('debug_1'))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);
	}

	override function beatHit()
	{
		super.beatHit();
		chickenOnTheRocks.scale.set(logoScale + 0.05, logoScale + 0.05);
		bg.scale.set(1.05, 1.05);
		//belly.scale.set(0.5 * 1.05, 0.4 * 1.05);
	}

	function changeItem(huh:Int = 0)
	{
		if (huh != 0)
		FlxG.sound.play(Paths.sound('click'));

		menuItems.members[curSelected].color = FlxColor.WHITE;
		curSelected = FlxMath.wrap(curSelected + huh,0,menuItems.length-1);
		menuItems.members[curSelected].color = FlxColor.YELLOW;

	}

		function scrollingTriangles(){
		var triangleHeight = 40;
		var triangleWidth = 60;
		var numTriangles = 10;
		var graphicWidth = triangleWidth * numTriangles;
		var graphicHeight = triangleHeight;
		var bitmap = new BitmapData(graphicWidth, graphicHeight, true, 0x00000000);
		var shape = new Shape();
		var g = shape.graphics;
		g.beginFill(0xFF000000);
		for (i in 0...numTriangles) {
			var x = i * triangleWidth;
			g.moveTo(x + triangleWidth / 2, 0);
			g.lineTo(x, triangleHeight);
			g.lineTo(x + triangleWidth, triangleHeight);
			g.lineTo(x + triangleWidth / 2, 0);
		}
		g.endFill();
		bitmap.draw(shape);
		var triangleGraphic = FlxGraphic.fromBitmapData(bitmap);
		var triangleBackdrop = new FlxBackdrop(triangleGraphic, X);
		triangleBackdrop.y = FlxG.height - triangleHeight;
		triangleBackdrop.velocity.x = -100;
		add(triangleBackdrop);
	}


}
