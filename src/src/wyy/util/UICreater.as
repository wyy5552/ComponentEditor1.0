package src.wyy.util
{
	import com.gamehero.sxd2.gui.core.label.ActiveLabel;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import mx.controls.Button;
	
	
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
					return new ActiveLabel;
			}
			return getSp();
		}
		
		private static function getSp():Sprite
		{
			var sp:Sprite = new Sprite();
			sp.graphics.beginFill(0x00ff00,1);
			sp.graphics.drawRect(0,0,50,50);
			sp.graphics.endFill();
			return sp;
		}
	}
}