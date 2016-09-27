package src.wyy.util
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import mx.controls.Button;
	
	import alternativa.gui.controls.text.Label;
	
	/**
	 * 
	 * @author weiyanyu
	 * 创建时间：2016-9-26 下午4:22:43
	 */
	public class UICreater
	{
		public function UICreater()
		{
		}
		
		/**
		 *  
		 * @param value new button()形式的字符串
		 * @return 
		 * 
		 */		
		public static function getUIbyName(value:String):DisplayObject
		{
			//new button()
			switch(value)
			{
				case "Button":
					return new Button;		
				case "Label":
					return new Label();
				default:
					return new Button;		
			}
			return new Sprite;
		}
	}
}