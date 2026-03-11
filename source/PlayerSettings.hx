package;

class PlayerSettings
{
	public static var player1:PlayerSettings;

	public var controls:Controls;

	public function new(id:String)
	{
		controls = new Controls(id, Solo);
	}

	public static function init():Void
	{
		if(player1 == null)
		{
			player1 = new PlayerSettings("player1");
		}
	}
}