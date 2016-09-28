package com.gamehero.sxd2.gui.bag.model.vo
{
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.pro.PRO_Item;
	
	/**
	 * 格子信息
	 * 包括物品来源；物品服务器数据；物品基础数据
	 * @author weiyanyu
	 * 创建时间：2015-9-23 下午10:00:06
	 * 
	 */
	public class ItemCellData
	{
		/**
		 *  物品来源
		 */		
		public var itemSrcType:int;
		
		private var _data:PRO_Item;
		/**
		 * 物品基础数据 
		 */		
		public var propVo:PropBaseVo;
		/**
		 * 额外参数 
		 */		
		public var ent:Object;
		/**
		 * 额外参数2，2016年7月29日10:55:17<br>
		 */		
		public var ent2:Object;
		
		public function ItemCellData()
		{
		}
		
		/**
		 *  物品服务器数据<br>
		 *  ps：设置data后就不用设置 propVo了。
		 */
		public function get data():PRO_Item
		{
			return _data;
		}
		
		/**
		 * 保证propVo存在
		 */
		public function set data(value:PRO_Item):void
		{
			_data = value;
			if(value)
			{
				propVo = ItemManager.instance.getPropById(value.itemId);
			}
		}
		
	}
}