package com.gamehero.sxd2.gui.core.list
{
	import com.gamehero.sxd2.gui.core.group.ItemRender;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.scrollBar.ScrollBar;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import alternativa.gui.alternativagui;
	import alternativa.gui.base.GUIobject;
	import alternativa.gui.event.ScrollBarEvent;
	
	import bowser.logging.Logger;
	
	use namespace alternativagui;

	/**
	 * @author shenliangliang
	 * @E-mail: 971935832@qq.com
	 * 创建时间：2016-7-4 下午4:41:22
	 * 
	 */
	public class ListGroup extends GUIobject
	{
		private var _content:GUIobject;
		
		private var _scrollBar:ScrollBar;
		
		private var _data:Array;
		
		private var _itemRender:Class;
		
		private var _itemWidth:Number;//宽
		
		private var _itemHeight:Number;//高
		/**
		 * 列
		 */
		private var colNum:int;//列
		/**
		 * 行
		 */
		private var rowNum:int;//行
		
		private var maxRow:int;
		
		private var _tempItem:ItemRender;
		
		private var itemArray:Vector.<ItemRender> = new Vector.<ItemRender>();
		private var itemDictory:Dictionary = new Dictionary();
		//首位置
		private var firstIndex:int;
		//莫位置
		private var endIndex:int;
		
		private var graY:int = 5;
		private var graX:int = 5;
		
		//顶部
		private var topIndex:int;
		//底部
		private var bottomIndex:int;
		
		public function ListGroup()
		{
			super();
			
			mouseChildren = true;
			mouseEnabled = true;
			
			_content = new GUIobject();
			addChild(_content);
			_content.x = graX;
			_content.y = graY;
			
			_scrollBar = new ScrollBar();
			_scrollBar.mouseDelta = 50;
			_scrollBar.stepScroll = 20;
			this.scrollBar = _scrollBar;
		}
		
		/**
		 * 
		 * @param col 
		 * @param row 
		 * @param itemWidth 
		 * @param itemHeight 
		 * 
		 */		
		public function init(col:int,row:int,itemWidth:Number,itemHeight:Number):void
		{
			_itemHeight = itemHeight;
			_itemWidth = itemWidth;
			
			colNum = col;
			rowNum = row;
			
			initUI();
		}
		
		/**
		 * 初始化
		 * 
		 */		
		private function initUI():void
		{
			// TODO Auto Generated method stub
			for (var j:int = 0; j < (rowNum + 1) * colNum; j++) 
			{
				var item:ItemRender;
				if(itemArray.length <= j)
				{
					item = createItem();
				}
				else
				{
					item = itemArray[j];
				}
				itemDictory[j] = item;
				item.x = (j % colNum) * _itemWidth;
				item.y = int(j / colNum) * _itemHeight;
				_content.addChild(item);
			}
			
			_content.width = _itemWidth * (rowNum);
			
			resize(_itemWidth * (rowNum),_itemHeight * colNum);
		}
		
		public function set data(value:Array):void
		{
			_data = value;
			
			_scrollBar.scrollPosition = 0;
			topIndex = 0;
			maxRow = Math.max(Math.ceil(_data.length / colNum),rowNum);
			//
			for (var i:int = 0; i < itemArray.length; i++) 
			{
				itemArray[i].data = i < _data.length ? _data[i]:null;
			}
			_scrollBar.x = _itemWidth * colNum;
			_scrollBar.y = 0;
			_scrollBar.height = _itemHeight * rowNum;
			_scrollBar.visible = maxRow > rowNum;
			bottomIndex = rowNum + 1;
			_scrollBar.maxScrollPosition = (maxRow - rowNum) * _itemHeight;
			//
			_content.resize(_itemWidth * colNum,_itemHeight * maxRow);
			//位置
			changeScrollPosition();
		}
		
		/**
		 * 
		 */
		private function createItem():ItemRender
		{
			var item:ItemRender = new _itemRender();
			
			itemArray.push(item);
			return item;
		}
		
		/**
		 * Скроллбар.
		 * 
		 */		
		public function get scrollBar():ScrollBar {
			return _scrollBar;
		}
		public function set scrollBar(value:ScrollBar):void {
			_scrollBar = value;
			addChild(_scrollBar);
			_scrollBar.addEventListener(ScrollBarEvent.SCROLL_CHANGE, changeScrollPosition);
			addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
			//draw();
		}
		
		/**
		 * 
		 */
		protected function changeScrollPosition(event:Event = null):void
		{
			// TODO Auto-generated method stub
			super.draw();
			drawGraphics();
			var row:int = int(_scrollBar.scrollPosition / _itemHeight);
			var i:int = 0;
			var index:int = 0;
			var list:Vector.<ItemRender> = new Vector.<ItemRender>();
			if(row >= bottomIndex - rowNum)
			{
				topIndex = row;
				
				for (i = 0; i < colNum; i++) 
				{
					list.push(itemArray[i]);
				}
				//数组重组
				itemArray.splice(0,colNum);
				itemArray = itemArray.concat(list);
				//设置数据
				for (i = 0; i < itemArray.length; i++) 
				{
					index = topIndex * colNum + i;
					itemArray[i].y = Math.floor((index) / colNum) * _itemHeight;
					if(index < _data.length)
					{
						if(_data[index] != itemArray[i].data)
						{
							itemArray[i].data = _data[index];
						}
					}
					else
					{
						itemArray[i].data = null;
					}
				}
				
				bottomIndex = rowNum + row + 1;
			}
			else if(row < topIndex)
			{
				topIndex = row;
				bottomIndex = row + rowNum + 1;
				//去最上一格数组
				for (i = 0; i < colNum; i++) 
				{
					list.push(itemArray[colNum * rowNum + i]);
				}
				//数组重组
				itemArray.splice(colNum * rowNum,colNum);
				itemArray = list.concat(itemArray);
				//设置数据
				for (i = 0; i < itemArray.length; i++) 
				{
					index = topIndex * colNum + i;
					itemArray[i].y = Math.floor((index) / colNum) * _itemHeight;
					if(index < _data.length)
					{
						if(_data[index] != itemArray[i].data)
						{
							itemArray[i].data = _data[index];
						}
					}
					else
					{
						itemArray[i].data = null;
					}
				}
			}
			_content.scrollRect = new Rectangle(-graX,_scrollBar.scrollPosition - graY,_itemWidth * colNum,_itemHeight * rowNum);
		}
		
		override public function drawGraphics():void
		{
			// TODO Auto Generated method stub
			super.drawGraphics();
			
			
		}
		
		override public function resize(width:int, height:int):void
		{
			// TODO Auto Generated method stub
			super.resize(width, height);
			
			graphics.clear();
			graphics.beginFill(0, 0);
			graphics.drawRect(0, 0, this._width, _height);
			graphics.endFill();
		}
		
		
		protected function mouseWheelHandler(e:MouseEvent):void {
			if (_scrollBar!=null) {
				_scrollBar.onMouseWheel(e);
			}
		}

		public function set itemRender(value:Class):void
		{
			_itemRender = value;
		}
		
		public function get itemRender():Class
		{
			return _itemRender;
		}

	}
}