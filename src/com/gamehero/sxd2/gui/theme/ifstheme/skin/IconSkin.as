package com.gamehero.sxd2.gui.theme.ifstheme.skin
{
	import com.gamehero.sxd2.core.Global;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.system.ApplicationDomain;

	public class IconSkin
	{
		/**
		 *活动图标 
		 */		
		public static var FUNID_20050:BitmapData;
		/**
		 * 世界Boss图标
		 */		
		public static var My_ICON:BitmapData;
		/**
		 *消费元宝 
		 */		
		public static var PAYICON:BitmapData;
		/**
		 * 元宝 
		 */		
		public static var YUANBAO:BitmapData;
		/**
		 * 银票 
		 */		
		public static var YIN_PIAO:BitmapData;
		/**
		 * 铜钱 
		 */		
		public static var TONGQIAN:BitmapData;
		/**
		 * 没有透明像素的铜钱 
		 */		
		public static var TONGQIAN_S:BitmapData;
		/**
		 * 灵蕴 
		 */		
		public static var LINGYUN:BitmapData;
		/**
		 * 残页
		 * */
		public static var CANYE:BitmapData;
		/**
		 * 碎片
		 * */
		public static var SUIPIAN:BitmapData;
		/**
		 * 经验
		 * */
		public static var JINGYAN:BitmapData;
		/**
		 * 命魂
		 * */
		public static var MINGHUN:BitmapData;
		/**
		 * 阅历
		 * */
		public static var YUELI:BitmapData;
		/**
		 * 声望
		 * */
		public static var SHENGWANG:BitmapData;
		/**
		 * 灵石
		 * */
		public static var LINGSHI:BitmapData;
		/**
		 * 灵魄 
		 */		
		public static var LINGPO:BitmapData;
		/**
		 *帮贡
		 * */
		public static var BANGGONG:BitmapData;
		/**
		 * 规则
		 */		
		public static var REPORTICON:BitmapData;
		/**
		 *退出 
		 */		
		public static var EXITICON:BitmapData;
		/**
		 * 悟性
		 */		
		public static var WUXING:BitmapData;
		
		public function IconSkin()
		{
		}
		
		public static function init(res:MovieClip):void
		{
			var domain:ApplicationDomain = res.loaderInfo.applicationDomain;
			var global:Global = Global.instance;
			
			TONGQIAN = global.getBD(domain,"TONGQIAN");
			TONGQIAN_S = global.getBD(domain,"TONGQIAN_S");
			
			YUANBAO = global.getBD(domain,"YUANBAO");
			YIN_PIAO = global.getBD(domain,"YIN_PIAO");
			LINGYUN = global.getBD(domain,"LINGYUN");
			JINGYAN = global.getBD(domain,"JINGYAN");
			SUIPIAN = global.getBD(domain,"SUIPIAN");
			CANYE = global.getBD(domain,"CANYE");
			MINGHUN = global.getBD(domain,"MINGHUN");
			YUELI = global.getBD(domain,"YUELI");
			SHENGWANG = global.getBD(domain,"SHENGWANG");
			LINGSHI = global.getBD(domain,"LINGSHI");
			BANGGONG = global.getBD(domain,"BANGGONG");
			FUNID_20050 = global.getBD(domain,"funId_20050");
			PAYICON = global.getBD(domain,"payIcon");
			REPORTICON = global.getBD(domain,"ReportIcon");
			EXITICON = global.getBD(domain,"ExitIcon");
			My_ICON = global.getBD(domain,"My_ICON");
			LINGPO = global.getBD(domain,"LINGPO");
			WUXING = global.getBD(domain,"WUXING");
		}
	}
}