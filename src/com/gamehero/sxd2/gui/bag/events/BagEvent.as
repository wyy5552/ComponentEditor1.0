package com.gamehero.sxd2.gui.bag.events
{
	import flash.events.Event;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2015-8-11 下午2:19:00
	 * 
	 */
	public class BagEvent extends Event
	{
		/**
		 * 道具更新 
		 */		
		public static var ITEM_UPDATA:String = "item_updata";
		/**
		 * 主背包更新 
		 */		
		public static var MAIN_ITEM_UPDATA:String = "main_item_updata";
		/**
		 * 主背包 物品数量改变 
		 */		
		public static var MAIN_ITEM_CHANGE:String = "main_item_change";
		/**
		 * 主背包物品删除道具 
		 */		
		public static var MAIN_ITEM_DELETE:String = "main_item_delete";
		/**
		 * 主背包增加道具 
		 */		
		public static var MAIN_ITEM_ADD:String = "main_item_add";
		/**
		 * 特殊道具更新 
		 */		
		public static var SPECIALITEM:String = "specialItem_";
		
		
		public var data:Object;
		
		public function BagEvent(type:String, data:Object = null)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
	}
}