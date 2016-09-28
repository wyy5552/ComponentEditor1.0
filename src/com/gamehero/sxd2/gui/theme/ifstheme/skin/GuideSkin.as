package com.gamehero.sxd2.gui.theme.ifstheme.skin
{
	import com.gamehero.sxd2.core.Global;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.system.ApplicationDomain;
	
	/**
	 * 剧情和新手引导皮肤
	 * @author xuwenyi
	 * @create 2015-11-05
	 **/
	public class GuideSkin
	{
		// 剧情压屏黑幕
		public static var DRAMA_BLACK_SCREEN:BitmapData;
		// 剧情冒泡对话(带头像的)
		public static var DRAMA_GOSSIP_BG:Class;
		// 剧情人物思考
		public static var DRAMA_THINK_BG:Class;
		
		// 功能开放
		public static var FUNCTION_OPEN_MOUSE_EF:Class;
		public static var FUNCTION_OPEN_BTN_EF:Class;
		public static var FUNCTION_OPEN_LIGHT:Class;
		
		// 功能提示小红点
		public static var FUNCTION_HINT:BitmapData;
		public static var FUNCTION_HINT_BG:BitmapData;
		public static var FUNCTION_HINT_FULL:BitmapData;
		
		// 功能展开收起
		public static var FUNCTION_SPREAD_UP:BitmapData;
		public static var FUNCTION_SPREAD_OVER:BitmapData;
		public static var FUNCTION_SPREAD_DOWN:BitmapData;
		public static var FUNCTION_CLOSE_UP:BitmapData;
		public static var FUNCTION_CLOSE_OVER:BitmapData;
		public static var FUNCTION_CLOSE_DOWN:BitmapData;
		
		
		
		public function GuideSkin()
		{
		}
		
		
		
		public static function init(res:MovieClip):void
		{
			var domain:ApplicationDomain = res.loaderInfo.applicationDomain;
			var global:Global = Global.instance;
			
			// 剧情相关
			DRAMA_BLACK_SCREEN = global.getBD(domain , "DRAMA_BLACK_SCREEN");
			DRAMA_GOSSIP_BG = global.getClass(domain , "DRAMA_GOSSIP_BG");
			DRAMA_THINK_BG = global.getClass(domain , "DRAMA_THINK_BG");
			
			// 功能开放相关
			FUNCTION_OPEN_MOUSE_EF = global.getClass(domain , "FUNCTION_OPEN_MOUSE_EF");
			FUNCTION_OPEN_BTN_EF = global.getClass(domain , "FUNCTION_OPEN_BTN_EF");
			FUNCTION_OPEN_LIGHT = global.getClass(domain , "FUNCTION_OPEN_LIGHT");
			
			// 功能提示小紅點
			FUNCTION_HINT = global.getBD(domain , "FUNCTION_HINT");
			FUNCTION_HINT_BG = global.getBD(domain , "FUNCTION_HINT_BG");
			FUNCTION_HINT_FULL = global.getBD(domain , "FUNCTION_HINT_FULL");
			
			// 功能展开
			FUNCTION_SPREAD_UP = global.getBD(domain , "FUNCTION_SPREAD_UP");
			FUNCTION_SPREAD_OVER = global.getBD(domain , "FUNCTION_SPREAD_OVER");
			FUNCTION_SPREAD_DOWN = global.getBD(domain , "FUNCTION_SPREAD_DOWN");
			
			// 功能收起
			FUNCTION_CLOSE_UP = global.getBD(domain , "FUNCTION_CLOSE_UP");
			FUNCTION_CLOSE_OVER = global.getBD(domain , "FUNCTION_CLOSE_OVER");
			FUNCTION_CLOSE_DOWN = global.getBD(domain , "FUNCTION_CLOSE_DOWN");
		}
	}
}