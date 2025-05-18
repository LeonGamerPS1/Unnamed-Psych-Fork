package states.stages;

import flixel.addons.effects.chainable.FlxOutlineEffect;
import flixel.addons.effects.chainable.FlxEffectSprite;
import objects.Character;
import shaders.DropShadowShader;
import states.stages.SchoolErect.CharacterType;
import flixel.addons.effects.FlxTrail;
import states.stages.objects.*;
import substates.GameOverSubstate;
import cutscenes.DialogueBox;
import openfl.utils.Assets as OpenFlAssets;
import objects.note.Note;

class SchoolEvilErect extends BaseStage
{
	override function create()
	{
		var _song = PlayState.SONG;
		if (_song.gameOverSound == null || _song.gameOverSound.trim().length < 1)
			GameOverSubstate.deathSoundName = 'fnf_loss_sfx-pixel';
		if (_song.gameOverLoop == null || _song.gameOverLoop.trim().length < 1)
			GameOverSubstate.loopSoundName = 'gameOver-pixel';
		if (_song.gameOverEnd == null || _song.gameOverEnd.trim().length < 1)
			GameOverSubstate.endSoundName = 'gameOverEnd-pixel';
		if (_song.gameOverChar == null || _song.gameOverChar.trim().length < 1)
			GameOverSubstate.characterName = 'bf-pixel-dead';

		var posX = 400;
		var posY = 200;

		var bg:BGSprite;

		bg = new BGSprite('weeb/erect/evilSchoolBG', posX, posY, 0.8, 0.9);
		bg.scale.set(PlayState.daPixelZoom, PlayState.daPixelZoom);
		bg.antialiasing = false;
		add(bg);
		setDefaultGF('gf-pixel');

		FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
		FlxG.sound.music.fadeIn(1, 0, 0.8);
		if (isStoryMode && !seenCutscene)
		{
			initDoof();
			setStartCallback(schoolIntro);
		}
	}

	var glow:FlxSprite;

	override function createPost()
	{
		var trail:FlxTrail = new FlxTrail(dad, null, 4, 24, 0.3, 0.069);
		addBehindDad(trail);
		glow = new FlxSprite(dad.x, dad.y);
		add(glow);

		addDropshadowCharacter(boyfriend, BF);
		addDropshadowCharacter(gf, GF);
		addDropshadowCharacter(dad, DAD);
	}

	public function addDropshadowCharacter(character:Character, charType:CharacterType):Void
	{
		// Apply the shader automatically to each character as it gets added.
		trace('Applied stage shader to ' + character.curCharacter);

		var rim = new DropShadowShader();
		rim.setAdjustColor(-66, -10, 24, -23);
		rim.color = 0xFFD40909;
		rim.antialiasAmt = 0;
		rim.attachedSprite = character;
		rim.distance = 5;

		switch (charType)
		{
			case CharacterType.BF:
				rim.angle = 170;
				character.shader = rim;

				rim.altMaskImage = Paths.image('weeb/erect/masks/bfPixel_mask').bitmap;
				rim.maskThreshold = 1;
				rim.useAltMask = true;

				character.animation.onFrameChange.add(function(name:String, frame:Int, index:Int)
				{
					if (boyfriend != null)
					{
						rim.updateFrameInfo(boyfriend.frame);
					}
				});

			case CharacterType.GF:
				rim.setAdjustColor(-42, -10, 5, -25);
				rim.angle = 180;
				character.shader = rim;
				rim.distance = 5;
				rim.threshold = 0.3;

				rim.altMaskImage = Paths.image('weeb/erect/masks/gfPixel_mask').bitmap;
				rim.maskThreshold = 1;
				rim.useAltMask = true;
				

				character.animation.onFrameChange.add(function(name:String, frame:Int, index:Int)
				{
					if (gf != null)
					{
						rim.updateFrameInfo(gf.frame);
					}
				});

			case CharacterType.DAD:
				rim.angle = 0;
				character.shader = rim;
					rim.color = 0xFF54071A;

				rim.altMaskImage = Paths.image('weeb/erect/masks/senpai_mask').bitmap;
				rim.maskThreshold = 1;
				rim.useAltMask = true;

				character.animation.onFrameChange.add(function(name:String, frame:Int, index:Int)
				{
					if (glow != null)
					{
						glow.frame = dad.frame;
						glow.blend = ADD;
						glow.alpha = 0.7;
						glow.scale.copyFrom(dad.scale);
						glow.updateHitbox();
						glow.offset.copyFrom(dad.offset);
						glow.origin.copyFrom(dad.origin);
						glow.setPosition(dad.x,dad.y);
					}
					if (dad != null)
					{
						rim.updateFrameInfo(dad.frame);
					}
				});

			default:
		}
	}

	var doof:DialogueBox = null;

	function initDoof()
	{
		var file:String = Paths.txt(songName + '/' + songName + 'Dialogue'); // Checks for vanilla/Senpai dialogue
		#if MODS_ALLOWED
		if (!FileSystem.exists(file))
		#else
		if (!OpenFlAssets.exists(file))
		#end
		{
			startCountdown();
			return;
		}

		doof = new DialogueBox(false, CoolUtil.coolTextFile(file));
		doof.cameras = [camHUD];
		doof.scrollFactor.set();
		doof.finishThing = startCountdown;
		doof.nextDialogueThing = PlayState.instance.startNextDialogue;
		doof.skipDialogueThing = PlayState.instance.skipDialogue;
	}

	function schoolIntro():Void
	{
		inCutscene = true;
		var red:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, 0xFFff1b31);
		red.scrollFactor.set();
		add(red);

		var senpaiEvil:FlxSprite = new FlxSprite();
		senpaiEvil.frames = Paths.getSparrowAtlas('weeb/senpaiCrazy');
		senpaiEvil.animation.addByPrefix('idle', 'Senpai Pre Explosion', 24, false);
		senpaiEvil.setGraphicSize(Std.int(senpaiEvil.width * 6));
		senpaiEvil.scrollFactor.set();
		senpaiEvil.updateHitbox();
		senpaiEvil.screenCenter();
		senpaiEvil.x += 300;
		camHUD.visible = false;

		new FlxTimer().start(2.1, function(tmr:FlxTimer)
		{
			if (doof != null)
			{
				add(senpaiEvil);
				senpaiEvil.alpha = 0;
				new FlxTimer().start(0.3, function(swagTimer:FlxTimer)
				{
					senpaiEvil.alpha += 0.15;
					if (senpaiEvil.alpha < 1)
					{
						swagTimer.reset();
					}
					else
					{
						senpaiEvil.animation.play('idle');
						FlxG.sound.play(Paths.sound('Senpai_Dies'), 1, false, null, true, function()
						{
							remove(senpaiEvil);
							senpaiEvil.destroy();
							remove(red);
							red.destroy();
							FlxG.camera.fade(FlxColor.RED, 0.01, true, function()
							{
								add(doof);
								camHUD.visible = true;
							}, true);
						});
						new FlxTimer().start(3.2, function(deadTime:FlxTimer)
						{
							FlxG.camera.fade(FlxColor.RED, 1.6, false);
						});
					}
				});
			}
		});
	}
}
