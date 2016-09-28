package com.gamehero.sxd2.gui.core.tab
{
	import com.gamehero.sxd2.gui.core.group.ItemRender;
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	/**
	 * 带游标的tab （见福利大厅，装备 等界面）
	 * @author weiyanyu
	 * 创建时间：2016-2-15 上午11:19:24
	 * 
	 */
	public class CursorTabBar extends TabBar
	{
		/**
		 *指向箭头
		 * */
		private var arrow:Bitmap;
		
		private var _tween:TweenMax;
		
		private var _itemW:int;
		
		private var _itemH:int;
		
		public function CursorTabBar(bd:BitmapData)
		{
			super();
			arrow = new Bitmap(bd);
			addChild(arrow);
		}
		
		override public function addBtn(btn:ItemRender,i:int = -1):void
		{
			super.addBtn(btn,i);
			setChildIndex(arrow,numChildren - 1);
		}
		
		public function setItemSize(w:int,h:int):void
		{
			_itemW = w;
			_itemH = h;
			if(_type == TabBar.HORIZEN)
			{
				arrow.y = h - arrow.height;
			}
			else
			{
				arrow.x = w - arrow.width;
			}
		}
		
		//默认选择第一个选项
		override public function set selectedIndex(value:int):void
		{
			if(selectedIndex != value)
			{
				if(_type == TabBar.HORIZEN)
				{
					_tween = TweenMax.to(arrow,0.5,{x:(value * (_itemW + gap))});
				}
				else
				{
					_tween = TweenMax.to(arrow,0.5,{y:(value * (_itemH + gap))});
				}
			}
			else
			{
				if(_type == TabBar.HORIZEN)
				{
					arrow.x = value * (_itemW + gap);
				}
				else
				{
					arrow.y = value * (_itemH + gap);
				}
			}
			super.selectedIndex = value;
		}
		
		
		override public function clear():void
		{
			super.clear();
			if(_tween)
			{
				_tween.kill();
			}
		}
	}
}