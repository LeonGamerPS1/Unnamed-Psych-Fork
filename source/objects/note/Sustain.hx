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
			animation.copyFrom(parent.animation);
			animation.play('hold');
			setTail('end');
			scale.set(parent.scale.x, parent.scale.y);
			updateHitbox();
		}
		antialiasing = parent.antialiasing;
	}

	override function draw()
	{
		var bength = parent.sustainLength;

		if (parent.wasGoodHit && !parent.inEditor)
			bength -= Conductor.songPosition - parent.strumTime;
		var height = (bength * parent.speed * 0.45);
		this.height = Math.abs(height);
		alpha = parent.alpha;
		angle = parent.strum != null ? parent.strum.direction - 90 : 0;

		setPosition(parent.x + ((parent.width - width) * 0.5), parent.y + (parent.height * 0.5));
		super.draw();
	}
}
