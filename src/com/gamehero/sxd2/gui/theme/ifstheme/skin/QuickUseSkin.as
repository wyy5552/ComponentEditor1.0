package com.gamehero.sxd2.gui.theme.ifstheme.skin
{
	import com.gamehero.sxd2.core.Global;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.system.ApplicationDomain;

	/**
	 * 快速穿戴
	 * @author weiyanyu
	 * 创建时间：2015-11-13 下午8:06:53
	 * 
	 */
	public class QuickUseSkin
	{
		
		public static var TITLE:BitmapData;
		
		public static var BG:BitmapData;
		
		public static var BG2INNER:BitmapData;
		
		public static var QUICKUSE_BTNFLASH:Class;
		
		public static var CLOSE_OVER:BitmapData;
		public static var CLOSE_UP:BitmapData;
		public static var CLOSE_DOWN:BitmapData;
		
		public static function init(res:MovieClip):void
		{
			var domain:ApplicationDomain = res.loaderInfo.applicationDomain;
			var global:Global = Global.instance;
			
			TITLE = global.getBD(domain,"quickUseTitle");
			BG = global.getBD(domain,"quickUseBg");
			BG2INNER = global.getBD(domain,"quickUseBg2Inner");
			CLOSE_OVER = global.getBD(domain,"quickUseOver");
			CLOSE_UP = global.getBD(domain,"quickUseUp");
			CLOSE_DOWN = global.getBD(domain,"quickUseDown");
			QUICKUSE_BTNFLASH = global.getClass(domain,"quickUseBtnFlash");
		}
		public function QuickUseSkin()
		{
		}
	}
}