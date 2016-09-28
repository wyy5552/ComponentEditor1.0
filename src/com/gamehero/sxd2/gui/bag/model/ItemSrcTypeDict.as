package com.gamehero.sxd2.gui.bag.model
{
	/**
	 * 用来描述格子来源
	 * @author weiyanyu
	 * 创建时间：2015-8-21 下午8:26:03
	 * 
	 */
	public class ItemSrcTypeDict
	{
		/**
		 * 背包格子 
		 */		
		public static var BAG:int = 1;
		/**
		 * 伙伴面板格子 
		 */		
		public static var HERO_EQUIP:int = 2;
		/**
		 * 回购面板 
		 */		
		public static var BUY_BACK:int = 3;
		/**
		 * 装备界面 
		 */		
		public static var EQUIP_WINDOW:int = 4;
		/**
		 * 装备锻造面板 
		 */		
		public static var EQUIP_MAKE:int = 5;
		/**
		 * 器灵界面
		 */	
		public static var OWNER_ALL_EQUIP:int = 6;
		/**
		 * 命格背包  （跟背包类型一致）
		 */		
		public static var FATE_CELL_BAG:int = 7;
		/**
		 * 命格仓库  （跟背包类型一致）
		 */		
		public static var FATE_CELL_STORE:int = 8;
		/**
		 * 暗命格背包  （跟背包类型一致）
		 */		
		public static var FATE_CELL_DARK_BAG:int = 9;
		/**
		 * 暗命格仓库  （跟背包类型一致）
		 */		
		public static var FATE_CELL_DARK_STORE:int = 10;
		/**
		 * 人物身上的命格 （跟背包类型不一致）
		 */		
		public static var FATE_CELL_HERO:int = 12;
		/**
		 * 人物身上的暗命格（跟背包类型不一致）
		 */		
		public static var FATE_CELL_DARK_HERO:int = 13;
		/**
		 * 查看其他玩家面板
		 * */
		public static var OTHRE_PLAYER_WINDOW:int = 14;
		/**
		 * 封灵/洗练面板,武器身上
		 * */
		public static var WASHEQUIP_WINDOW_WEAPON:int = 15;
		/**
		 *  封灵/洗练面板,背包
		 */		
		public static var WASHEQUIP_WINDOW_BAG:int = 16;
		
		
		
		public function ItemSrcTypeDict()
		{
		}
	}
}