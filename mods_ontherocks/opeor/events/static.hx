var statc:FunkinSprite;

function onCreate(){
    statc = new FunkinSprite();
    statc.frames = Paths.getSparrowAtlas('scary/Epsteinstatic');
    statc.animation.addByPrefix('i','Epsteinfilesstatic',24);
    statc.setGraphicSize(FlxG.width, FlxG.height);
    statc.animation.play('i');
    statc.visible = false;
    statc.cameras = [game.camGoodBye];
    statc.screenCenter();
    add(statc);
}

function onEvent(ev, value1){
    var val = Std.parseInt(value1);
    trace("the value is "+ val);
    
    if (ev == "static") statc.visible = (val == 1);
}