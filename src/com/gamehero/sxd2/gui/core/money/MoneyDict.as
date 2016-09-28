package com.gamehero.sxd2.gui.core.money
{
	import com.gamehero.sxd2.gui.bag.model.ItemTypeDict;
	import com.gamehero.sxd2.manager.ItemManager;

	/**
	 * @author weiyanyu
	 * 创建时间：2015-9-21 上午11:59:52
	 * 
	 */
	public class MoneyDict
	{
		
		public function MoneyDict()
		{
		}
		public static var YB_CN:String = "元宝";
		/**
		 * 绑定元宝
		 */		
		public static var YUANBAO:int = 10010009;
		/**
		 * 银票
		 */		
		public static var YIN_PIAO:int = 10010002;
		
		public static var TONG_QIAN:int = 10010001;
		/**
		 * 灵蕴 物品id 
		 */
		public static var LING_YUN:int = 10010006;
		/**
		 * 经验物品id 
		 */
		public static var JING_YAN:int = 10010003;
		/**
		 * 寻仙残页 
		 */
		public static var CAN_YE:int = 15010002;
		/**
		 * 命魂
		 */		
		public static var MING_HUN:int = 10010007;
		/**
		 * 阅历 
		 */		
		public static var YUE_LI:int = 10010008;
		/**
		 * 声望
		 */	
		public static var PRESTIGE:int = 10010005;
		/**
		 * 帮贡
		 */	
		public static var BANG_GONG:int = 10010012;
		/**
		 * 灵石 
		 */		
		public static var LING_SHI:int = 10010013;
		/**
		 * 灵魄 
		 */		
		public static var LING_PO:int = 10010011;
		/**
		 * 悟性
		 */		
		public static var WU_XING:int = 10010015;
		/**
		 * 判断一个物品是否是消耗类物品<br>
		 * ps: 10 开头的是， 也存在非10开头的道具，如寻仙残页
		 * @param id
		 * @return 
		 * 
		 */		
		public static function isMoney(id:int):Boolean
		{
			if(id == CAN_YE)
			{
				return true;
			}
			else
			{
				return ItemManager.instance.getPropById(id).type == ItemTypeDict.MONEY;
			}
		}
	}
}