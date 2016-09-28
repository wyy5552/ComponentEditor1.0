package com.gamehero.sxd2.gui.core.tab
{
	import com.gamehero.sxd2.core.SoundConfig;
	import com.gamehero.sxd2.gui.core.group.ItemRender;
	import com.gamehero.sxd2.manager.SoundManager;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * 页签
	 * @author weiyanyu
	 * 创建时间：2015-9-29 下午4:52:46
	 * 
	 */
	public class TabBar extends Sprite
	{
		
		/**
		 *  横向
		 */		
		public static var HORIZEN:int = 0;
		/**
		 * 纵向 
		 */		
		public static var VERTICAL:int = 1;
		
		
		protected var _type:int = 0;
		
		/**
		 * 当前选择的页签索引 
		 */		
		protected var _index:int = -1;
		/**
		 *  当前选中的按钮 
		 */		
		protected var _curBtn:ItemRender;
		/**
		 * 首次打开页签后，记录页签顺序 
		 */		
		protected var itemList:Vector.<ItemRender> = new Vector.<ItemRender>();
		/**
		 * 间距 
		 */		
		public var gap:int;
		
		public function TabBar()
		{
			super();
		}

		public function set type(value:int):void
		{
			_type = value;
		}
		/**
		 * 添加页签，设置索引 
		 * @param btn
		 * @param i
		 * 
		 */		
		public function addBtn(btn:ItemRender,i:int = -1):void
		{
			
			if(i == -1)
			{//直接添加，则加在后面
				btn.itemIndex = itemList.length;
				itemList.push(btn);
			}
			else
			{
				btn.itemIndex = i;
				itemList.splice(i,0,btn);
			}
			addChild(btn);
			
			if(_type == HORIZEN)
			{
				btn.x = btn.itemIndex * (btn.width + gap);
			}
			else if(_type == VERTICAL)
			{
				btn.y = btn.itemIndex * (btn.height + gap);
			}
			btn.addEventListener(MouseEvent.MOUSE_UP,onClick);
		}
		
		public function removeBtn():void
		{
			
		}
		
		/**
		 * 点击 
		 * @param event
		 */		
		protected function onClick(event:MouseEvent):void
		{
			var btn:ItemRender;
			btn = event.currentTarget as ItemRender;
			if(btn.itemIndex == selectedIndex) return;
			selectedIndex = (btn.itemIndex);
			if(_curBtn)
				dispatchEvent(new TabEvent(TabEvent.SELECTED,_curBtn.itemIndex));
			// 切页音效
			SoundManager.inst.play(SoundConfig.TOOGLE_CLICK);
		}
		
		/**
		 * 当前选择的页签 
		 */
		public function get selectedIndex():int
		{
			return _index;
		}
		
		/**
		 * 设置当前页签
		 * @private
		 */
		public function set selectedIndex(value:int):void
		{
			_index = value;
			for each(var tab:ItemRender in itemList)
			{
				if(tab.itemIndex != value)
				{
					tab.selected = false;
				}
				else
				{
					tab.selected = true;
					_curBtn = tab;
				}
			}
		}
		/**
		 * 根据索引得到页签 
		 * @param value
		 * @return 
		 * 
		 */		
		public function getBtnByIndex(value:int):ItemRender
		{
			return value >= itemList.length ? null:itemList[value];
		}
		
		/**
		 * 当前选中的按钮 
		 * @return 
		 * 
		 */		
		public function get curBtn():ItemRender
		{
			return _curBtn;
		}
		
		public function set curBtn(value:ItemRender):void
		{
			_curBtn = value;
			selectedIndex = _curBtn.itemIndex;
			dispatchEvent(new TabEvent(TabEvent.SELECTED,_curBtn.itemIndex));
		}
		/**
		 * 页签数量 
		 * @return 
		 * 
		 */		
		public function get length():int
		{
			return itemList.length;
		}
		
		public function clear():void
		{
			for each(var tab:ItemRender in itemList)
			{
				removeChild(tab);
				tab.clear();
				tab.removeEventListener(MouseEvent.MOUSE_UP,onClick);
				tab = null;
			}
			itemList.length = 0;
			this.graphics.clear();
		}

	}
}