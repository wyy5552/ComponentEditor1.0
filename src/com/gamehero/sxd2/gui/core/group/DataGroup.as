package com.gamehero.sxd2.gui.core.group
{
	import com.gamehero.sxd2.gui.core.event.DataGroupEvent;
	import flash.events.MouseEvent;
	
	/**
	 * 模仿flex datagroup<br>
	 * (增加，可以设置 呈现项 的选中，划入状态)<br>
	 * 默认选中第一个；
	 * @author weiyanyu
	 * 创建时间：2015-9-10 下午3:59:15
	 * 
	 */
	public class DataGroup extends Group
	{
		
		/**
		 * 当前选中de
		 */		
		protected var _curSelectedItem:ItemRender;
		
		public function DataGroup()
		{
			super();
		}
		
		//默认选择第一个选项
		override public function set selectedIndex(value:int):void
		{
			_selectedIndex = value;
			
			for(var i:int = 0; i < _itemList.length; i++)
			{
				if(i == value)
				{
					_curSelectedItem = _itemList[i];
					_curSelectedItem.selected = true;
					dispatchEvent(new DataGroupEvent(DataGroupEvent.SELECTED,i));
				}
				else
				{
					_itemList[i].selected = false;
					
				}
			}

		}
		/**
		 * 当前选中的itemrender 
		 * @return 
		 * 
		 */		
		public function get curSelectedItem():ItemRender
		{
			return _curSelectedItem;
		}
		
		override public function set data(value:Array):void
		{
			_data = value;
			
			if(!value || value.length <= 0)
			{
				this.clear();
				return;
			}
			var item:ItemRender;
			var itemRow:int;
			var itemCol:int;
			for(var i:int = 0; i < value.length; i++)
			{
				
				itemRow = int(i / col);
				itemCol = (i % col);
				if(_itemList.length > i)
				{
					item = _itemList[i];
				}
				else
				{
					item = getMouseItem();
					addChild(item);
					_itemList.push(item);
				}
				item.itemIndex = i;//先设置索引，设置数据的时候可能会用到；（放在设置 data之前）
				item.data = value[i];
				item.y = itemRow * (item.height + _gapY);
				item.x = itemCol * (item.width + _gapX);
			}
			width = itemCol * (item.width  + gapX) - gapX;
			height = (itemRow + 1) * (item.height + gapY) - gapY;
			if(selectedIndex == -1)
			{
				selectedIndex =  0;
			}
			else
			{
				selectedIndex = selectedIndex;
			}
		}
		
		public function getChildByIndex(index:int):ItemRender
		{
			if(index >= _itemList.length || index < 0)
				return null;
			else
			{
				return _itemList[index];
			}
		}
		//添加格子
		protected function getMouseItem():ItemRender
		{
			var item:ItemRender = new ITEM_CLASS();
			if(mouseClickAble)
			{
				item.addEventListener(MouseEvent.MOUSE_UP,onClick);
				item.addEventListener(MouseEvent.DOUBLE_CLICK,onDoubleClick);
				item.doubleClickEnabled = true;
			}
			else
			{
				item.removeEventListener(MouseEvent.MOUSE_UP,onClick);
				item.removeEventListener(MouseEvent.DOUBLE_CLICK,onDoubleClick);
				item.doubleClickEnabled = false;
			}
			if(mouseOverAble)
			{
				item.addEventListener(MouseEvent.ROLL_OVER,onMouseOver);
				item.addEventListener(MouseEvent.ROLL_OUT,onMouseOut);
			}
			else
			{
				item.removeEventListener(MouseEvent.ROLL_OVER,onMouseOver);
				item.removeEventListener(MouseEvent.ROLL_OUT,onMouseOut);
			}
			return item;
		}
		
		
		override public function clear():void
		{
			super.clear();
			width = 0;
			height = 0;
		}
		
	}
}