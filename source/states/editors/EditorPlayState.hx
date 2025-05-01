package states.editors;

class EditorPlayState extends MusicBeatSubstate
{
	public function new(playbackRate:Float)
	{
		super();

		var tipText:FlxText = new FlxText(10, FlxG.height - 24, 0, 'Press ESC, Unfinished, but you can stay. i love you', 16);
		tipText.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		tipText.borderSize = 2;
		tipText.scrollFactor.set();
		add(tipText);
		FlxG.mouse.visible = false;
	}

	override function update(elapsed:Float)
	{
		if (controls.BACK || FlxG.keys.justPressed.ESCAPE)
		{
			close();
			super.update(elapsed);
			return;
		}

		super.update(elapsed);
	}

	override function destroy()
	{
		FlxG.mouse.visible = true;
		super.destroy();
	}
}
