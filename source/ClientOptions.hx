package;

import flixel.FlxG;
import flixel.util.FlxSave;
import flixel.input.keyboard.FlxKey;
import Controls.Control;

class ClientOptions
{
	public static var framerate:Int = 60;
	public static var ghostTapping:Bool = true;

	public static var defaultKeys:Array<FlxKey> = [
		A, LEFT,
		S, DOWN,
		W, UP,
		D, RIGHT,

		R, NONE,
		SPACE, ENTER,
		BACKSPACE, ESCAPE,
		ENTER, ESCAPE
	];

	public static var keyBinds:Array<Dynamic> = [
		[Control.LEFT, 'Left'],
		[Control.DOWN, 'Down'],
		[Control.UP, 'Up'],
		[Control.RIGHT, 'Right'],

		[Control.RESET, 'Reset'],
		[Control.ACCEPT, 'Accept'],
		[Control.BACK, 'Back'],
		[Control.PAUSE, 'Pause']
	];

	public static var lastControls:Array<FlxKey> = defaultKeys.copy();

	public static function saveSettings()
	{
		FlxG.save.data.framerate = framerate;
		FlxG.save.data.ghostTapping = ghostTapping;
		FlxG.save.flush();

		var save:FlxSave = new FlxSave();
		save.bind('controls', 'ninjamuffin99');
		save.data.customControls = lastControls;
		save.flush();
	}

	public static function loadPrefs()
	{
		if(FlxG.save.data.framerate != null)
		{
			framerate = FlxG.save.data.framerate;
			FlxG.updateFramerate = framerate;
			FlxG.drawFramerate = framerate;
		}

		if(FlxG.save.data.ghostTapping != null)
		{
			ghostTapping = FlxG.save.data.ghostTapping;
		}

		var save:FlxSave = new FlxSave();
		save.bind('controls', 'ninjamuffin99');

		if(save != null && save.data.customControls != null)
		{
			reloadControls(save.data.customControls);
		}
	}

	public static function reloadControls(newKeys:Array<FlxKey>)
	{
		removeControls(lastControls);
		lastControls = newKeys.copy();
		loadControls(lastControls);
	}

	private static function removeControls(controlArray:Array<FlxKey>)
	{
		for (i in 0...keyBinds.length)
		{
			var controlValue:Int = i * 2;
			var controlsToRemove:Array<FlxKey> = [];

			for (j in 0...2)
			{
				if(controlArray[controlValue + j] != NONE)
					controlsToRemove.push(controlArray[controlValue + j]);
			}

			if(controlsToRemove.length > 0)
			{
				PlayerSettings.player1.controls.unbindKeys(keyBinds[i][0], controlsToRemove);
			}
		}
	}

	private static function loadControls(controlArray:Array<FlxKey>)
	{
		for (i in 0...keyBinds.length)
		{
			var controlValue:Int = i * 2;
			var controlsToAdd:Array<FlxKey> = [];

			for (j in 0...2)
			{
				if(controlArray[controlValue + j] != NONE)
					controlsToAdd.push(controlArray[controlValue + j]);
			}

			if(controlsToAdd.length > 0)
			{
				PlayerSettings.player1.controls.bindKeys(keyBinds[i][0], controlsToAdd);
			}
		}
	}
}