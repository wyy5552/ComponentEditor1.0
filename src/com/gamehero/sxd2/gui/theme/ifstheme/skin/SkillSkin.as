package com.gamehero.sxd2.gui.theme.ifstheme.skin
{
	import com.gamehero.sxd2.core.Global;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.system.ApplicationDomain;

	/**
	 * @author shenliangliang
	 * @E-mail: 971935832@qq.com
	 * 创建时间：2016-4-6 下午7:11:07
	 * 
	 */
	public class SkillSkin
	{
		private static var RESOURCE:MovieClip;
		
		public static var SKILLADDOVER:BitmapData;
		public function SkillSkin()
		{
		}
		
		// 初始化
		public static function init(res:MovieClip):void
		{
			RESOURCE = res;
			
			var domain:ApplicationDomain = res.loaderInfo.applicationDomain;
			var global:Global = Global.instance;
			
			SKILLADDOVER = global.getBD(domain , "skillover");
		}
	}
}