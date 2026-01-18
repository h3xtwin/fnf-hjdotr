var nice:FlxSprite;
var evil:FlxSprite;


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
  
}
/*
function onUpdatePost(elapsed) {

}
*/

function onSongStart() {
    for (i in [game.camGame, game.camHUD]) {
        FlxTween.tween(i, {alpha: 1},1, {ease: FlxEase.quadIn});
    }
}

    
function onEvent(ev,val1,val2,time) {
    if (ev == 'ah'){
        evil.alpha = 1;
        nice.alpha = 0;
    }
}