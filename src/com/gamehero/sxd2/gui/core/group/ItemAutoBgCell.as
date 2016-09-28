package com.gamehero.sxd2.gui.core.group
{
	
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.gui.bag.component.ItemCell;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ItemSkin;
	
	import flash.events.MouseEvent;
	
	/**
	 * 自动设置背景的itemcell<br>
	 * 	 * 格子相当于兼容所有道具类型，适应背景、鼠标等状态
	 * @author weiyanyu
	 * 创建时间：2016-8-29 下午3:24:16
	 */
	public class ItemAutoBgCell extends ItemCell
	{
		public function ItemAutoBgCell(itemSize:int=0)
		{
			super(itemSize);
		}
		
		override public function set propVo(value:PropBaseVo):void
		{
			_propVo = value;
			
			url = GameConfig.ITEM_ICON_URL + value.ico + ".swf";
			
			if(isItemTypeSpecial(propVo.type))
			{
				_qualityBg.visible = false;
				ent = CIRCLE;
				_backGroud.bitmapData = ItemSkin.Bag_Circle_up;
			}
			else
			{
				_qualityBg.quality = _propVo.quality;//设置品质
				_qualityBg.visible = true;
				ent = RECT;
				_backGroud.bitmapData = ItemSkin.BAG_ITEM_NORMAL_BG;
			}
			initLoc();
		}
		
		override public function onOver(e:MouseEvent = null):void
		{
			super.onOver(null);
			if(int(ent) == CIRCLE) 
			{
				_backGroud.bitmapData = ItemSkin.Bag_Circle_over;
			}
		}
		override public function onOut(e:MouseEvent=null):void
		{
			super.onOut(null);
			if(int(ent) == CIRCLE) 
			{
				_backGroud.bitmapData = ItemSkin.Bag_Circle_up;
			}
			else
			{
				_backGroud.bitmapData = ItemSkin.BAG_ITEM_NORMAL_BG;
			}
		}
		
		override public function set ent(value:Object):void
		{
			super.ent = value;
			var type:int = int(value);
			if(type == CIRCLE)
			{
				_maskedContaner.addChild(_backGroud);
			}
			else
			{
				_maskedContaner.addChildAt(_backGroud,0);
			}
		}
		
	}
}