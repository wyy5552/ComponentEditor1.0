package com.gamehero.sxd2.gui.theme.ifstheme.skin
{
	import com.gamehero.sxd2.core.Global;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.system.ApplicationDomain;
	/**
	 * 物品的一些通用资源
	 * @author weiyanyu
	 * 创建时间：2015-8-31 13:44:41
	 * 
	 */
	public class ItemSkin
	{
		public function ItemSkin()
		{
		}
		
		/**
		 * 获取道具动画 
		 */		
		public static var ITEM_GET_EFFECT:Class;
		/**
		 * 元宝金币的闪烁动画 
		 */		
		public static var GOLD_FLASH:Class;
		/**
		 * 与元宝金币的闪烁动画相同的纯文本闪烁动画 
		 */		
		public static var LABEL_FLASH:Class;
		/**
		 * 碎片标志 
		 */		
		public static var ChipBigMask:BitmapData;
		public static var ChipSmallMask:BitmapData;
		
		/**
		 * 默认道具背景 
		 */		
		public static var BAG_ITEM_NORMAL_BG:BitmapData;
		public static var Bag_Circle_up:BitmapData;
		public static var Bag_Circle_over:BitmapData;
		public static var BagBg_0:BitmapData;//被
		public static var BagBg_1:BitmapData;//绿
		public static var BagBg_2:BitmapData;//蓝
		public static var BagBg_3:BitmapData;//紫
		public static var BagBg_4:BitmapData;//橙
		public static var BagBg_5:BitmapData;//红
		
		public static var BagTime_canuse:BitmapData;//时限内可用
		public static var BagTime_notuse:BitmapData;//时限内不可用
		public static var BagTime_flash:BitmapData;//时限内可用闪动
		
		public static var BagBgArr:Vector.<BitmapData>;
		
		/**
		 * 64*64图标底图
		 * */
		public static var ITEM_BIG_BG:BitmapData;
		public static var Quality64_0:BitmapData;//被
		public static var Quality64_1:BitmapData;//绿
		public static var Quality64_2:BitmapData;//蓝
		public static var Quality64_3:BitmapData;//紫
		public static var Quality64_4:BitmapData;//橙
		public static var Quality64_5:BitmapData;//红
		
		public static var Quality64BgArr:Vector.<BitmapData>;
		/**
		 * 镀金框 
		 */		
		public static var ItemGoldBg:BitmapData;
		
		public static function init(res:MovieClip):void
		{
			var domain:ApplicationDomain = res.loaderInfo.applicationDomain;
			var global:Global = Global.instance;
			
			
			ITEM_GET_EFFECT = global.getClass(domain,"ITEM_GET_EFFECT");
			GOLD_FLASH = global.getClass(domain,"GOLD_FLASH");
			LABEL_FLASH = global.getClass(domain,"LABEL_FLASH");
			
			ChipBigMask = global.getBD(domain,"ChipBigMask");
			ChipSmallMask = global.getBD(domain,"ChipSmallMask");
			
			ITEM_BIG_BG = global.getBD(domain,"ITEM_BG_64");  
			
			BAG_ITEM_NORMAL_BG = global.getBD(domain,"BagDefaultBg");
			Bag_Circle_up = global.getBD(domain,"Bag_Circle_up");
			Bag_Circle_over = global.getBD(domain,"Bag_Circle_over");
			
			BagBg_0 = global.getBD(domain,"BagBg_0");
			BagBg_1 = global.getBD(domain,"BagBg_1");
			BagBg_2 = global.getBD(domain,"BagBg_2");
			BagBg_3 = global.getBD(domain,"BagBg_3");
			BagBg_4 = global.getBD(domain,"BagBg_4");
			BagBg_5 = global.getBD(domain,"BagBg_5");
			
			BagTime_canuse = global.getBD(domain,"BagTime_canuse");
			BagTime_notuse = global.getBD(domain,"BagTime_notuse");
			BagTime_flash = global.getBD(domain,"BagTime_flash");
			
			BagBgArr = new <BitmapData>[BagBg_0,BagBg_1,BagBg_2,BagBg_3,BagBg_4,BagBg_5];
			
			Quality64_0 = global.getBD(domain,"Quality64_0");
			Quality64_1 = global.getBD(domain,"Quality64_1");
			Quality64_2 = global.getBD(domain,"Quality64_2");
			Quality64_3 = global.getBD(domain,"Quality64_3");
			Quality64_4 = global.getBD(domain,"Quality64_4");
			Quality64_5 = global.getBD(domain,"Quality64_5");
			
			Quality64BgArr = new <BitmapData>[Quality64_0,Quality64_1,Quality64_2,Quality64_3,Quality64_4,Quality64_5];
			
			ItemGoldBg = global.getBD(domain,"ItemGoldBg");
		}
	}
}