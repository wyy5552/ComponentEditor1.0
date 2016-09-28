package com.gamehero.sxd2.gui.core.money
{
	import com.gamehero.sxd2.gui.bag.model.BagModel;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.manager.DialogManager;
	import com.gamehero.sxd2.manager.ItemManager;

	/**
	 * 物品消耗的时候进行判断
	 * @author weiyanyu
	 * 创建时间：2015-10-12 下午5:40:12
	 * 
	 */
	public class ItemCost
	{
		public function ItemCost()
		{
		}
		/**
		 *  判断多种物品消耗是否足够,弹出提示窗口(errorCode类似的)
		 * @param costItems itemCostVo数组
		 * @return 物品是否足够
		 * 
		 */		
		public static function canUseMulCost(costItems:Array):Boolean
		{
			var vo:ItemCostVo;
			for(var i:int = 0; i < costItems.length; i++)
			{
				if(!canUseSingCost(costItems[i]))
					return false;
			}
			return true;
		}
		/**
		 *  判断单个消耗是否足够,弹出提示窗口(errorCode类似的)
		 * @param vo
		 * @return 
		 * 
		 */		
		public static function canUseSingCost(vo:ItemCostVo):Boolean
		{
			return canUse(vo.itemId,vo.itemCostNum);
		}
		/**
		 *   判断多种物品消耗是否足够,弹出提示窗口(errorCode类似的)
		 * @param costItems 物品[[物品id，物品数量],...]
		 * @return 
		 * 
		 */		
		public static function canUseMulItem(costItems:Array):Boolean
		{
			var canUse:Boolean;
			for(var i:int = 0; i < costItems.length; i++)
			{
				canUse = canUseSingItem(costItems[i]);
				if(!canUse)
				{
					return false;
				}
			}
			return true;
		}
		/**
		 *  判断单个消耗是否足够,弹出提示窗口(errorCode类似的)
		 * @param costItem 物品[物品id，物品数量]
		 * @return 
		 * 
		 */		
		public static function canUseSingItem(costItem:Array,showAlert:Boolean = true):Boolean
		{
			return canUse(costItem[0],costItem[1],showAlert);
		}
		
		public static function canUse(itemId:int,itemNum:int = 1,showAlert:Boolean = true):Boolean
		{
			var costNum:int;
			if(itemId == MoneyDict.YUANBAO)//使用元宝的时候，应该是  绑定元宝 + 银票
			{
				costNum = BagModel.inst.getNumByItemId(MoneyDict.YUANBAO) + BagModel.inst.getNumByItemId(MoneyDict.YIN_PIAO);
			}
			else
			{
				costNum = BagModel.inst.getNumByItemId(itemId);
			}
			if(costNum < itemNum)
			{
				if(showAlert){
					var propBase:PropBaseVo = ItemManager.instance.getPropById(itemId);
					DialogManager.inst.showPrompt(propBase.name + "不足");
				}
				return false;
			}
			return true;
		}
		
	}
}
