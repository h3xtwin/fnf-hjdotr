var pixelShader;
var saturateShader;
var shaders:Array<ShaderFilter>;

function onCreate()
{
    pixelShader = game.createRuntimeShader("pixel"); 
    saturateShader = game.createRuntimeShader("saturate");

    saturateShader.setFloat("saturation", 1.0);

    shaders = [
        new ShaderFilter(pixelShader),
        new ShaderFilter(saturateShader)
    ];
}

function onEvent(ev:String, value1:String, value2:String)
{
    if (ev == "opeored")
    {
        if (value1 == "0")
        {
            game.camGame.setFilters(null);
            game.camHUD.setFilters(null);
            return;
        }

        var parts = value1.split(",");

        var saturation = Std.parseFloat(parts[0]);

        var brightness = (parts.length > 1)
            ? Std.parseFloat(parts[1])
            : -0.15;

        pixelShader.setFloat("size", Std.parseFloat(value2));
        saturateShader.setFloat("saturation", saturation);
        saturateShader.setFloat("brightness", brightness);

        game.camGame.setFilters(null);
        game.camHUD.setFilters(null);
        game.camGame.setFilters(shaders);
        game.camHUD.setFilters(shaders);
    }
}

