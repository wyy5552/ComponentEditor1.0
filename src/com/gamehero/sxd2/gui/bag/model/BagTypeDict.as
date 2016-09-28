package com.gamehero.sxd2.gui.bag.model
{
	
	/**
	 * 背包类型
	 * @author weiyanyu
	 * 创建时间：2015-11-25 下午12:06:26
	 * 
	 */
	public class BagTypeDict
	{
		public function BagTypeDict()
		{
		}
		/**
		 * 主包裹 
		 */
		public static var MAIN_BAG:int = 1;
		/**
		 * 穿身上的装备包裹 
		 */
		public static var EQUIP_WEAPON:int = 2;
		/**
		 * 回购 
		 */
		public static var BUY_BACK:int = 3;
		/**
		 * 碎片（残灵） 
		 */
		public static var CHIPS:int = 4;
		/**
		 * 杂项背包 独立模块材料类
		 */
		public static var SUNDRY:int = 5;
		/**
		* 主角装备包裹 即器灵背包
		*/
		public static var OWNER_ALL_EQUIP:int = 6;
//		/**
//		* 主角身上装备 即器灵身上格子
//		*/
//		public static var OWNER_EQUIP:int = 7;
		
		/**
		 * 命格背包 
		 */		
		public static var FATE_CELL_BAG:int = 7;
		/**
		 * 命格仓库 
		 */		
		public static var FATE_CELL_STORE:int = 8;
		/**
		 * 暗命格背包 
		 */		
		public static var FATE_CELL_DARK_BAG:int = 9;
		/**
		 * 暗命格仓库 
		 */		
		public static var FATE_CELL_DARK_STORE:int = 10;
//		/**
//		 * 人物身上的命格或者暗命格 
//		 */		
//		public static var FATE_CELL_HERO:int = 12;
		/**
		 * 封灵
		 */		
		public static var WASH_WEAPEN:int = 11;
		/**
		 * 技能残页
		 */		
		public static var PASSIVE_SKILL:int = 12;
	}
}