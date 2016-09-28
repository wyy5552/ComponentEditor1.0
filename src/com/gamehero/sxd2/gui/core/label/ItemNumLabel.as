package com.gamehero.sxd2.gui.core.label
{
	
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.manager.ItemManager;
	
	import alternativa.gui.base.ActiveObject;
	
	/**
	 * 物品名字：物品数量
	 * @author weiyanyu
	 * 创建时间：2016-8-24 下午8:51:24
	 */
	public class ItemNumLabel extends ActiveObject
	{
		private var itemLb:Label;
		public function ItemNumLabel()
		{
			super();
			itemLb = new Label();
			addChild(itemLb);
		}
		
		
		public function setItemNum(itemId:int,num:int):void
		{
			var prop:PropBaseVo = ItemManager.instance.getPropById(itemId);
			itemLb.text = prop.name + "：" + GameDictionary.createCommonText(num + "",GameDictionary.WHITE);
		}
	}
}