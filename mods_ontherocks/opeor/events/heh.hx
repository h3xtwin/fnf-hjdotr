var gassy:FunkinSprite;

function onCreate(){

    gassy = new FunkinSprite();
    gassy.frames = Paths.getSparrowAtlas('idkhowtodothisdifferently/heh');
    gassy.animation.addByPrefix('i','Gassy',24);
    gassy.animation.play('i');
    gassy.visible = false;
    gassy.screenCenter();
    gassy.x -= 500;
    gassy.y -= 300;
    add(gassy);
}


function onEvent(ev, val1){
    if (ev == 'heh'){
        var val = Std.parseInt(val1);
        if(val == 1){
            game.isCameraOnForcedPos = true;
            game.camFollow.x = 0;
            game.camFollow.y = 0;
            game.camGame.snapToTarget();
            gassy.visible = true;

        }
        else if (val == 0){
            gassy.visible = false;
        }
    }

}