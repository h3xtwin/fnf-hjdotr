
var nice:FlxSprite;
var evil:FlxSprite;
var around:FlxSprite;
var imscared:FlxSprite;

// cool shader stuff
var shader;
var scaryShader;
var timeval;

function onCreate() {
    game.skipCountdown = true;

    nice = new FlxSprite(125, 280).loadGraphic(Paths.image('nice'));
    nice.scale.x = 2;
    nice.scale.y = 2;
    nice.alpha = 1;
    addBehindGF(nice);

    evil = new FlxSprite(125, 280).loadGraphic(Paths.image('evil'));
    evil.scale.x = 2;
    evil.scale.y = 2;
    evil.alpha = 0;
    addBehindGF(evil);


    game.camGame.alpha = game.camHUD.alpha = 0;
  
    around = new FlxSprite().loadGraphic(Paths.image('aroundy'));
    around.setGraphicSize(FlxG.width, FlxG.height);
    around.cameras = [game.camGoodBye];
    around.screenCenter();
    around.alpha = 0;
    add(around);

    imscared = new FlxSprite().loadGraphic(Paths.image('imscared'));
    around.setGraphicSize(FlxG.width+100, FlxG.height+100);
    imscared.setPosition(0,0);
    imscared.x -= FlxG.width/2;
    imscared.y -= FlxG.height/2;
    imscared.alpha = 1;
    imscared.visible = false;
    addBehindGF(imscared);

}

function onSongStart() {
    for (i in [game.camGame, game.camHUD]) {
        FlxTween.tween(i, {alpha: 1},1, {ease: FlxEase.quadIn});
    }

    for (i in 0...game.opponentStrums.length){
    //    trace("it works");
        var note = game.opponentStrums.members[i];
        note.x = game.playerStrums.members[i].x;
        note.alpha = 0;
        note.cameras = [FlxG.camera];
        note.texture = "noteskins/NOTE_assets_evil";
   }
}

    
function onEvent(ev,val1,val2,time) {
    switch(ev){
        case 'aroundy':
            FlxTween.tween(around, {alpha: 1}, val1, {ease: FlxEase.quadIn});
        case 'ooohbg':
            FlxTween.tween(evil, {alpha:1},2.0,{ease: FlxEase.quadIn});
        case 'ooohbg1':
            imscared.visible = true;
    }
}

