package objects.other;

class Ultimatrix extends FlxSpriteGroup
{
	public var ultimatrixSprite:FlxSprite;
	public var ultimatrixColor:FlxSprite;

	public function new(omnitrixColor:FlxColor = 0x00FF00, ?x:Float = 0, ?y:Float = 0)
	{
		super(x, y);

		ultimatrixColor = new FlxSprite(0, 0, Paths.image('ultimatrix_mask'));
		ultimatrixColor.antialiasing = ClientPrefs.data.antialiasing;
        ultimatrixColor.color = omnitrixColor;
		add(ultimatrixColor);

		ultimatrixSprite = new FlxSprite(0, 0, Paths.image('ultimatrix'));
		ultimatrixSprite.antialiasing = ClientPrefs.data.antialiasing;
		add(ultimatrixSprite);
	}
}
