package com.gamehero.sxd2.gui.theme.ifstheme.skin
{
	import com.gamehero.sxd2.core.Global;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.system.ApplicationDomain;

	/**
	 * @author Wbin
	 * 创建时间：2016-4-29 下午6:24:46
	 * 
	 */
	public class BuffSkin
	{
		/**
		 * 体力buff
		 * */
		public static var BUFF_1:BitmapData;
		
		/**永久卡 大*/
		public static var FOREVER_CARD_B_BD:BitmapData;
		/**月卡    大*/
		public static var MONTH_CARD_B_BD:BitmapData;
		
		public function BuffSkin()
		{
			
		}
		
		public static function init(res:MovieClip):void
		{
			var domain:ApplicationDomain = res.loaderInfo.applicationDomain;
			var global:Global = Global.instance;
			
			BUFF_1 = global.getBD(domain,"B_1");
			
			FOREVER_CARD_B_BD = global.getBD(domain,"FOREVER_CARD_B_BD");
			MONTH_CARD_B_BD = global.getBD(domain,"MONTH_CARD_B_BD");
		}
		
	}
}