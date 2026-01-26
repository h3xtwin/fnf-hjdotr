var poop:Array<FlxSprite>;

function onCreate(){
    poop = new Array<FlxSprite>(4);

    poop[0] = new FlxSprite().loadGraphic(Paths.image('scary/scary1'));
    poop[1] = new FlxSprite().loadGraphic(Paths.image('scary/scary2'));
    poop[2] = new FlxSprite().loadGraphic(Paths.image('scary/scary3'));
    poop[3] = new FlxSprite().loadGraphic(Paths.image('scary/scary4'));

    for (i in 0...poop.length){
        poop[i].visible = false;
        poop[i].setGraphicSize(FlxG.width, FlxG.height);
        poop[i].cameras = [game.camGoodBye];
        poop[i].screenCenter();
        add(poop[i]);
    }
}

function onEvent(name){
    if (name == 'poop') {
        var ran = FlxG.random.int(0, poop.length - 1);
        poop[ran].visible = true;
        new FlxTimer().start(0.15, function(tmr:FlxTimer) {
            poop[ran].visible = false;
        });
    }
}