package com.gamehero.sxd2.gui.theme.ifstheme.skin
{
	import com.gamehero.sxd2.core.Global;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.system.ApplicationDomain;

	/**
	 * @author Wbin
	 * 创建时间：2016-9-23 下午4:50:59
	 * 主角相关资源
	 */
	public class PlayerSkin
	{
		private static var RESOURCE:MovieClip;
		
		/**
		 * 头像资源
		 * */
		public static var HEAD_54_M:BitmapData;
		public static var HEAD_54_W:BitmapData;
		
		public static var HEAD_60_M:BitmapData;
		public static var HEAD_60_W:BitmapData;
		
		public static var HEAD_80_M:BitmapData;
		public static var HEAD_80_W:BitmapData;
		
		public function PlayerSkin()
		{
		}
		
		// 初始化
		public static function init(res:MovieClip):void
		{
			RESOURCE = res;
			
			var domain:ApplicationDomain = res.loaderInfo.applicationDomain;
			var global:Global = Global.instance;
			
			HEAD_54_M = global.getBD(domain , "m_54");
			HEAD_54_W = global.getBD(domain , "w_54");
			
			HEAD_60_M = global.getBD(domain , "m_60");
			HEAD_60_W = global.getBD(domain , "w_60");
			
			HEAD_80_M = global.getBD(domain , "m_80");
			HEAD_80_W = global.getBD(domain , "w_80");
		}
	}
}