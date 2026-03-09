package;

using StringTools;

class TextManager
{
    public static var currentList:Array<String>;

    public static function init()
    {
        currentList = CoolUtil.coolTextFile("assets/data/game/config.txt");
    }

    public static function getTextString(stringName:String):String
	{
		var returnedString:String = '';
		for (i in 0...currentList.length)
		{
			var currentValue = currentList[i].trim().split(' = ');
			if (currentValue[0] != stringName)
			{
				continue;
			}
			else
			{
				returnedString = currentValue[1];
			}
		}
		if (returnedString == '')
		{
			return stringName;
		}
		else
		{
			returnedString = returnedString.replace(':linebreak:', '\n');
			returnedString = returnedString.replace(':addquote:', '\"');
			return returnedString;
		}
	}
}