package;

import flixel.FlxG;
import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;
import DiscordClient;
import TextManager;

#if windows
import sys.io.File;
import sys.io.Process;
import lime.app.Application;
#end

class Main extends Sprite
{
	var gameWidth:Int = 1280; // Width of the game in pixels (might be less / more in actual pixels).
	var gameHeight:Int = 720; // Height of the game in pixels (might be less / more in actual pixels).
	var framerate:Int = 60;
	var skipSplash:Bool = true; // Whether to skip the flixel splash screen that appears in release mode.
	var startFullscreen:Bool = false; // Whether to start the game in fullscreen on desktop targets

	public function new()
	{
		super();
		DiscordClient.initialize();
		TextManager.init();
		addChild(new FlxGame(gameWidth, gameHeight, TitleState, framerate, framerate, skipSplash, startFullscreen));
		Application.current.window.title = TextManager.getTextString('windowName');

		#if !mobile
		addChild(new FPS(10, 3, 0xFFFFFF));
		#end
	}
}
