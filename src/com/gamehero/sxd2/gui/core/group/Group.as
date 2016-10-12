package com.gamehero.sxd2.gui.core.group
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import alternativa.gui.alternativagui;
	import alternativa.gui.base.GUIobject;
	import alternativa.gui.container.list.IItemContainer;
	import alternativa.gui.data.DataProvider;
	import alternativa.gui.event.DataChangeEvent;
	import alternativa.gui.event.ListEvent;
	import alternativa.gui.mouse.MouseManager;
	
	use namespace alternativagui;
	/**
	 * 通用Group组件，行列设置，宽高设置，显示列表、网格；
	 * @author weiyanyu
	 * 创建时间：2016-1-8 上午11:39:11
	 * 
	 */
	public class Group extends GUIobject implements IItemContainer 
	{
		/**
		 * 呈现项 
		 */		
		protected var ITEM_CLASS:Class;
		/**
		 * 间距 
		 */		
		protected var _gapX:int = 0;
		protected var _gapY:int = 0;
		protected var _col:int = 4;//列
		protected var _row:int = 2;//行
		
		protected var _selectedIndex:int = -1;
		/**
		 * 单击后需要延时处理的settimeout
		 */		
		protected var _clickTime:uint;
		protected var _data:Array;
		protected var _itemWidth:int = 1;
		protected var _itemHeight:int = 1;
		
		protected var _ent:Object;
		
		protected var _vertValue:int;
		/**		 * 数据字典		 */		
		protected var _dataProvider:DataProvider;
		/**
		 * 组件列表 
		 */		
		protected var _itemList:Vector.<ItemRender> = new Vector.<ItemRender>();
		/**
		 * 显示元素字典
		 */		
		protected var visibleElementsDictionary:Dictionary = new Dictionary();;
		/**
		 * 显示的行数
		 */		
		protected var _numVisibleRow:int = 0;
		/**
		 * 当前显示元素位置的行数
		 */		
		protected var curRow:int = 0;
		/**
		 * 是否可以点击 
		 */		
		public var mouseClickAble:Boolean = false;
		/**
		 * 是否有鼠标滑动的效果 
		 */		
		public var mouseOverAble:Boolean = false;
		
		public function Group()
		{
			super();
		}
		
		public function get itemHeight():int
		{
			return _itemHeight;
		}

		public function set itemHeight(value:int):void
		{
			_itemHeight = value;
		}

		/**
		 * 呈现项的宽高 
		 */
		public function get itemWidth():int
		{
			return _itemWidth;
		}

		/**
		 * @private
		 */
		public function set itemWidth(value:int):void
		{
			_itemWidth = value;
		}

		
		/**
		 * 数据源 
		 * @return 
		 * 
		 */		
		public function get data():Array
		{
			return _data;
		}
		
		public function set data(value:Array):void
		{
			_data = value;
		}
		/**
		 * 行数 
		 */
		public function get row():int
		{
			return _row;
		}
		
		/**
		 * @private
		 */
		public function set row(value:int):void
		{
			_row = value;
		}
		
		/**
		 * 列
		 * @param value
		 * 
		 */
		public function set col(value:int):void
		{
			_col = value;
		}
		/**
		 * @return 列数
		 * 
		 */
		public function get col():int
		{
			return _col;
		}
		
		public function get gapY():int
		{
			return _gapY;
		}
		
		public function set gapY(value:int):void
		{
			_gapY = value;
		}
		
		public function get gapX():int
		{
			return _gapX;
		}
		
		public function set gapX(value:int):void
		{
			_gapX = value;
		}
		
		public function set itemRenderer(object:Class):void
		{
			ITEM_CLASS = object;
		}
		
		public function get itemList():Vector.<ItemRender>{
			return _itemList;
		}
		/**
		 * 单击 
		 * @param e
		 * @return 是否
		 * 
		 */		
		protected function onClick(e:MouseEvent):void
		{
			if(isClick)
			{
				var item:ItemRender;
				item = e.currentTarget as ItemRender;
				selectedIndex = (item.itemIndex);
				item.onClick();
				dispatchEvent(new ListEvent(ListEvent.CLICK_ITEM,selectedIndex));
			}
		}
		
		protected function get isClick():Boolean
		{
			// 区分双击
			if(getTimer() - _clickTime <  40)
			{
				return false;
			}
			_clickTime = getTimer();
			return true;
		}
		protected function onDoubleClick(e:MouseEvent):void
		{
			(e.target as ItemRender).onDoubleClick();
		}
		protected function onMouseOut(e:MouseEvent):void
		{
			(e.currentTarget as ItemRender).onOut();
		}
		
		protected function onMouseOver(e:MouseEvent):void
		{
			(e.currentTarget as ItemRender).onOver();
		}
		public function get activate():Boolean
		{
			return true;
		}
		
		public function set activate(value:Boolean):void
		{
		}
		
		public function update():void
		{
			// TODO Auto Generated method stub
			draw();
		}
		
		public function get contentHeight():Number
		{
			// TODO Auto Generated method stub
			var h:int = 0;
			if (_dataProvider != null)
			{
				var row:int = Math.ceil(_dataProvider.length / col);
				h = (row * itemHeight) + ((row - 1) * gapY);
			}
			return h;
		}
		
		public function get dataProvider():DataProvider
		{
			return _dataProvider;
		}
		
		/**
		 * 填充内容为pro_item 
		 * @param value
		 * 
		 */		
		public function set dataProvider(value:DataProvider):void
		{
			var i:int = 0;
			var prop:*;
			//==================删除之前的数据==========
			if (_dataProvider) {
				_dataProvider.removeEventListener(DataChangeEvent.DATA_CHANGE, changeData);
				
				for (prop in visibleElementsDictionary) {//从显示对象字典移除
					(visibleElementsDictionary[prop]).data = null;
					delete visibleElementsDictionary[prop];
				}
				_vertValue = 0;
				
				//让_itemVec的长度与数据长度一致
				
				var dataLen:int = _dataProvider.length;
				
				if(_itemList.length < dataLen)//如果itemList长度少了，则添加几个
				{
					var addLen:int = dataLen - _itemList.length;
					for(i = 0; i < addLen; i++)
					{
						_itemList.push(new ITEM_CLASS());
					}
				}
				else if(_itemList.length > dataLen)//多出了一些，则移出掉多余的
				{
					var item:ItemRender;
					var delArr:Vector.<ItemRender> = _itemList.splice(dataLen,_itemList.length);
					for(i = 0; i < delArr.length ; i++)
					{
						item = delArr[i];
						if(item && contains(item))
						{
							removeChild(item);
							item.clear();
						}
					}
				}
			}
			//========================end=====================
			_dataProvider = value;
			if(_itemList.length == 0)//为0的时候表示还没有暂存呈现项
			{
				for(i = 0; i < _dataProvider.length; i++)
				{
					_itemList.push(new ITEM_CLASS());
				}
			}
			
			if (_dataProvider != null) {
				
				_height = calculateHeight(_height);
			}
			draw();
			if (_dataProvider != null) {
				_dataProvider.addEventListener(DataChangeEvent.DATA_CHANGE, changeData);
			}	
			
			dispatchEvent(new Event(ListEvent.REDRAW));
		}
		
		/**
		 * Вызывается при изменении поставщика данных.数据发生变化
		 * 
		 */		
		protected function changeData(e:Event):void {
			var dataProviderLength:int = _dataProvider.length; 
			if (dataProviderLength == 0) {
				for (var prop:* in visibleElementsDictionary) {
					delete visibleElementsDictionary[prop];
				}
				dispatchEvent(new Event(ListEvent.REMOVE_DATA));
				_vertValue = 0;
			} else {
				update();
				dispatchEvent(new Event(ListEvent.REDRAW));
			}
			_height = calculateHeight(_height);
			draw();
		}
		
		private var _needRenderEvent:Boolean = false;
		
		public function set needRenderEvent(value:Boolean):void
		{
			_needRenderEvent = value
			if(value)
			{
				addEventListener(Event.RENDER, render);
			}
			else
			{
				removeEventListener(Event.RENDER,render);
			}
		}
		
		
		private var changed:Boolean;
		
		private function render(e:Event):void {
			if(changed) {
				changed = false;
				finalDraw();
			}
		}
		/**
		 * @inheritDoc 
		 * 
		 */		
		override protected function draw():void {
			super.draw();
			if(_needRenderEvent)
			{
				changed = true;
				if(stage)
				{
					stage.invalidate();
				}
			}
			else
			{
				finalDraw();
			}
		}
		private function finalDraw():void
		{
			var top:int = _vertValue;
			var prop:*;
			if (_dataProvider != null && _dataProvider.length > 0)
			{
				_numVisibleRow = Math.floor(_height / (itemHeight + gapY));
				
				if (_dataProvider.length / col <= _numVisibleRow) {
					_vertValue = 0;
				}
				
				if (_dataProvider != null && _dataProvider.length > 0 ) {
					
					curRow = Math.abs(top) / (itemHeight + gapY);
					var item:ItemRender;
					var i:int = 0;//格子索引
					
					var beginIndex:int = curRow * col - 1;//显示的格子的初始索引
					beginIndex = beginIndex < 0 ? 0 : beginIndex;
					
					var endIndex:int = (curRow + _numVisibleRow + 2) * col - 1;//显示的格子的初始索引
					endIndex = endIndex < 0 ? 0 : endIndex;
					
					for (i = 0; i < _itemList.length; i++) {
						item = _itemList[i];
						if(i >= beginIndex && i <= endIndex)
						{
							if(item == null)
							{
								item = new ITEM_CLASS();
								_itemList[i] = item;
							}
							setPropItem(item);
							if (i <= (_dataProvider.length - 1)) 
							{		//第j条数据存在
								(item).data = _dataProvider.getItemAt(i);
								visibleElementsDictionary[i] = item;
							}
							else
							{
								(item).data = null;
							}
						}
						else if(item != null)
						{
							(item).data = null;
						}
					}
					
					
					var itemRow:int;
					var itemCol:int;
					for (prop in visibleElementsDictionary)
					{
						itemRow = int(prop / col);
						itemCol = (prop % col);
						item = visibleElementsDictionary[prop];
						item.x = (itemWidth + gapX) * itemCol;
						item.y = (itemHeight + gapY) * itemRow;
						item.itemIndex = prop;
						setPropItem(item);
						addChild(item);
						if(mouseClickAble)
						{
							item.addEventListener(MouseEvent.MOUSE_UP,onClick);
							item.addEventListener(MouseEvent.DOUBLE_CLICK,onDoubleClick);
							(item).doubleClickEnabled = true;
						}
						else
						{
							item.removeEventListener(MouseEvent.MOUSE_UP,onClick);
							item.removeEventListener(MouseEvent.DOUBLE_CLICK,onDoubleClick);
							(item).doubleClickEnabled = false;
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
					}
					
					this.scrollRect = new Rectangle(0, top, _width, _height);
				}
			}
			
		}
		/**
		 * 设置item的一些属性 
		 * 
		 */		
		protected function setPropItem(item:ItemRender):void
		{
			item.ent = ent;
		}
		
		
		
		public function get vertValue():int
		{
			// TODO Auto Generated method stub
			return _vertValue;
		}
		
		public function set vertValue(value:int):void
		{
			// TODO Auto Generated method stub
			_vertValue = value;
			draw();
			MouseManager.update();
		}
		
		public function get mouseDelta():Number
		{
			// TODO Auto Generated method stub
			return (itemHeight + gapY);
		}
		
		public function get selectedIndex():int
		{
			// TODO Auto Generated method stub
			return _selectedIndex;
		}
		
		public function set selectedIndex(value:int):void
		{
			// TODO Auto Generated method stub
			_selectedIndex = value;;
		}
		
		public function get selectedItem():Object
		{
			// TODO Auto Generated method stub
			return itemList[selectedIndex].data;
		}
		
		public function get showScrollBar():Boolean
		{
			if (_dataProvider && _dataProvider.length > 0) {
				var row:int = Math.ceil(_dataProvider.length / col);
				var visibleItems:int = Math.floor(_height / (itemHeight + gapY));
				if (row > visibleItems) {
					return true;
				} else {
					return false;
				}
			} else {
				return false;
			}
		}
		
		public function get stepScroll():Number
		{
			return (itemHeight + gapY);
		}
		
		/**
		 * 清除数据相关 
		 * 
		 */		
		public function clear():void
		{
			if(_itemList)
			{
				var item:ItemRender;
				for(var i:int = 0; i < _itemList.length; i++)
				{
					item = _itemList[i];
					if(item == null)
						continue;
					if(item.parent)
						item.parent.removeChild(item);
					item.clear();
					item.removeEventListener(MouseEvent.ROLL_OVER,onMouseOver);
					item.removeEventListener(MouseEvent.ROLL_OUT,onMouseOut);
					item.removeEventListener(MouseEvent.CLICK,onClick);
					item.removeEventListener(MouseEvent.DOUBLE_CLICK,onDoubleClick);
					item.doubleClickEnabled = false;
				}
				_itemList.length = 0;
			}
		}

		public function get ent():Object
		{
			return _ent;
		}

		public function set ent(value:Object):void
		{
			_ent = value;
		}

		
	}
}