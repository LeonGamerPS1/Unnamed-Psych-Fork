package objects.note;

import objects.note.NoteSplash.PixelSplashShaderRef;

class HoldCover extends FlxSprite
{
	public var parent:StrumNote;

	public static var fag = ["Purple", "Blue", "Green", "Red"];

	public function new(id:Int = 0, parent:StrumNote)
	{
		super(parent.x, parent.y);
		var png = 'holdCover${fag[id % fag.length]}';
		frames = Paths.getSparrowAtlas(png);

		animation.addByPrefix('hold', png, 24, true);
		animation.play('hold');
		antialiasing = true;

		if (PlayState.isPixelStage)
		{
			var shd = new PixelSplashShaderRef();
			shader = shd.shader;
			shd.copyValues(parent.rgbShader.parent);
		}
	}
}
