var black:FlxSprite;
var black1:FlxSprite;


function onCreate()
{
    black = new FlxSprite().makeGraphic(1280, 1000);
    black.color = FlxColor.BLACK;
    black.alpha = 0;
    black.cameras = [game.camGoodBye];
    black.x -= 50;
    black.y -= 50;
    black.screenCenter();
    add(black);

    black1 = new FlxSprite().loadGraphic(Paths.image('black'));
    black1.alpha = 0;
    black1.cameras = [game.camGoodBye];
    black1.screenCenter();
    add(black1);

}

function onEvent(name, value1, value2){
    var poopval = Std.parseInt(value1);
    if (name == 'poopcity') {
       if(poopval == 0){
            black.alpha = 0;
            black1.alpha = 0;
         }
        else if (poopval == 1){
            if (Std.parseInt(value2) == 1) black1.alpha = 1; 
              black.alpha = 1;
       }
    }
}

