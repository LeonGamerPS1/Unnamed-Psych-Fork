package objects.note;

import objects.other.TiledSprite;

class Sustain extends TiledSprite
{
	public var parent:Note;

	public function new(parent:Note)
	{
		parent.sustain = this;

		this.parent = parent;
		super(-5000, -5000);
		reload();
	}

	function reload()
	{
		if (!PlayState.isPixelStage)
		{
			frames = parent.frames;
			adjustFrame = true;
			animation.copyFrom(parent.animation);
			animation.play('hold');
			setTail('end');
			scale.set(parent.scale.x, parent.scale.y);
			updateHitbox();
		}
		else
		{
			adjustFrame = false;
			@:privateAccess
			var graphic = Paths.image(parent.suspath);
			loadGraphic(graphic, true, Math.floor(graphic.width / 4), Std.int(graphic.height / 2));

			animation.add('hold', [parent.noteData % 4]);
			animation.add('end', [parent.noteData % 4 + 4]);

			animation.play('hold');
			setTail('end');

			scale.set(6, 6);
			updateHitbox();
		}
		antialiasing = parent.antialiasing;
	}

	override function draw()
	{
		var bength = parent.sustainLength;

		if (parent.wasGoodHit && !parent.inEditor)
			bength -= Conductor.songPosition - parent.strumTime;
		var height = (bength * parent.speed * 0.45) + tailHeight();
		this.height = Math.abs(height);
		alpha = parent.alpha * 0.7;
		angle = parent.strum != null ? parent.strum.direction - 90 : angle;
		if (shader != parent.shader)
			shader = parent.shader;

		setPosition(parent.x + ((parent.width - width) * 0.5), parent.y + (parent.height * 0.5));
		if(parent.flip) {
			y -= 30;
			angle += 180;
			}
		super.draw();
	}
}
