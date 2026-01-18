package export.release.windows.bin.mods.opeor.events;


var black:FlxSprite;
function onCreate()
{
    black = new FlxSprite().makeGraphic(1280, 1000);
    black.color = FlxColor.BLACK;
    black.alpha = 0;
    black.screenCenter();
    black.x += 300;
    black.y += 200;
    black.cameras = game.camGoodBye;

    add(black);

}

function onEvent(name, value1){
    var poopval = Std.parseInt(value1);
    if (name == 'poopcity') {
       if(poopval == 0){
              black.alpha = 0;
         }
        else if (poopval == 1){
              black.alpha = 1;
       }
    }
}