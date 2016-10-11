package src.wyy.port
{
	import flash.display.BitmapData;

	public interface IButton
	{
		function set upSkin(value:BitmapData):void;
		function set downSkin(value:BitmapData):void;
		function set overSkin(value:BitmapData):void;
		function set label(value:String):void;
	}
}