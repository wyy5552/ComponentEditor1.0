package com.gamehero.sxd2.gui.core.money
{
	import com.gamehero.sxd2.gui.bag.events.BagEvent;
	import com.gamehero.sxd2.gui.bag.model.BagModel;
	import com.gamehero.sxd2.gui.bag.model.vo.ItemCellData;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.core.interFace.ICellData;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.PRO_Item;
	import com.gamehero.sxd2.services.GameService;
	
	import flash.events.Event;
	
	import alternativa.gui.base.ActiveObject;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2016-5-25 下午2:28:10
	 * 
	 */
	public class MoneyBaseLabel extends ActiveObject implements ICellData
	{
		public function MoneyBaseLabel()
		{
			super();
		}
		/**
		 * 物品id 
		 */		
		protected var _iconId:int;
		
		protected var _num:Number = 0;
		
		
		protected var _activeFresh:Boolean = false;
		/**
		 * 物品数量改变后需要回调的函数 
		 */		
		public var callBack:Function;
		
		protected var _itemCellData:ItemCellData = new ItemCellData();
		public function get itemCellData():ItemCellData
		{
			var prop:PropBaseVo = ItemManager.instance.getPropById(_iconId);
			_itemCellData.propVo = prop;
			var pro:PRO_Item = new PRO_Item();
			if(prop != null)
			{
				pro.itemId = int(prop.id);
			}
			pro.num = _num;
			_itemCellData.data = pro;
			return _itemCellData;
		}
		
		
		public function set iconId(value:int):void
		{
			_iconId = value;
			this.hint = _iconId.toString();
		}
		
		public function set num(value:Number):void
		{
			_num = value;
		}
		public function get num():Number
		{
			return _num;
		}
		
		
		/**
		 *  需要实时更新物品数量
		 */		
		public function set activeFresh(value:Boolean):void
		{
			if(value)
			{
				GameService.instance.addEventListener(MSGID.MSGID_UPDATE_PLAYER.toString(),updataPlayerHandle);
				BagModel.inst.addEventListener(BagEvent.ITEM_UPDATA,updataPlayerHandle);
			}
			else
			{
				GameService.instance.removeEventListener(MSGID.MSGID_UPDATE_PLAYER.toString(),updataPlayerHandle);
				BagModel.inst.removeEventListener(BagEvent.ITEM_UPDATA,updataPlayerHandle);
				callBack = null;
			}
		}
		
		protected function updataPlayerHandle(event:Event):void
		{
			if(callBack)
				callBack();
		}
	}
}