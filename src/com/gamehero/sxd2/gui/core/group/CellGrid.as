package com.gamehero.sxd2.gui.core.group
{
	import com.gamehero.sxd2.gui.bag.component.ItemCell;
	import com.gamehero.sxd2.gui.bag.model.BagModel;
	import com.gamehero.sxd2.gui.bag.model.ItemSrcTypeDict;
	import com.gamehero.sxd2.gui.core.event.DataGroupEvent;
	import com.gamehero.sxd2.gui.menu.MenuPanel;
	import com.gamehero.sxd2.pro.PRO_Item;
	
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	
	/**
	 * 物品格子
	 * @author weiyanyu
	 * 创建时间：2016-1-4 下午5:40:50
	 * 
	 */
	public class CellGrid extends Group
	{
		
		protected var _itemSize:int = 46;
		/**
		 * 注： 当前移入的物品与当前鼠标的物品可能不是一个，具体原因待验证； 
		 */		
		protected var _curOverItem:Cell;
		
		
		protected var _itemSrcType:int;
		
		private var _itemBg:BitmapData;
		
		
		public function CellGrid(cellClass:Class,size:int = 46,src:int = 0,canOver:Boolean = false,canClick:Boolean = false)
		{
			super();
			ITEM_CLASS = cellClass;
			itemSize = size;
			_itemSrcType = src;
			mouseOverAble = canOver;
			mouseClickAble = canClick;
		}
		/**
		 * 格子大小 <br>
		 * 容器也需要知道格子大小，如果格子空，则宽高会变为0，对位就会出现问题。
		 * @return 
		 */
		public function get itemSize():int
		{
			return _itemSize;
		}
		
		public function set itemSize(value:int):void
		{
			_itemSize = value;
			itemWidth = itemHeight = value;
		}
		
		/**
		 * 没有数据也可以创建一组格子 
		 * @param col 列
		 * @param row 行
		 * @param gapX x间隙
		 * @param gapY y间隙
		 * @param isHorizontal 索引从横向开始还是竖向开始
		 */		
		public function initGrid(col:int,row:int,gapX:int = 5,gapY:int = 5,isHorizontal:Boolean = true):void
		{
			clear();
			this.col = col;
			this.row = row;
			this.gapX = gapX;
			this.gapY = gapY;
			var item:Cell;
			var i:int;
			var j:int;
			if(isHorizontal)//
			{
				for(i = 0; i < row; i++)
				{
					for(j = 0; j < col; j++)
					{
						item = addItem((itemSize + gapX) *  j,(itemSize + gapY) * i, (i * col + j));
					}
				}
			}
			else
			{
				for(j = 0; j < col; j++)
				{
					for(i = 0; i < row; i++)
					{
						item = addItem((itemSize + gapX) *  j,(itemSize + gapY) * i, (j * row + i));
					}
				}
			}
		}
		
		/**
		 * 在原来格子基础上，按行增加格子
		 * @param value 需要增加几行
		 * 
		 */
		public function addRowItem(value:int):void{
			for(var i:int = 0; i < value; i ++){
				for(var j:int = 0; j < col; j ++){
					addItem((itemSize + gapX) *  j,(itemSize + gapY) * (row + i), ((row + i) * col + j));
				}
			}
		}
		
		/**
		 * 刷新数据，不会移出格子 <br>
		 * @param arr  物品唯一id的数组
		 * 
		 */		
		public function setData(arr:Array):void
		{
			for(var i:int = 0; i < _itemList.length; i++)
			{
				if(i < arr.length)
				{
					var cel:Cell = _itemList[i] as Cell;
					if(cel.itemSrcType == ItemSrcTypeDict.OTHRE_PLAYER_WINDOW)
					{
						cel.data = BagModel.inst.getOtherItem(arr[i]);
					}
					else
					{
						cel.data = BagModel.inst.getItemById(arr[i]);
					}
				}
				else
				{
					_itemList[i].data = null;//clear
				}
			}
		}
		
		
		/**
		 * 设置数据源
		 * 给予的是pro_item的数组
		 */
		override public function set data(value:Array):void
		{
			clear();
			_data = value;
			var item:ItemCell;
			var itemRow:int;
			var itemCol:int;
			var proItem:PRO_Item;
			for(var i:int = 0; i < value.length; i++)
			{
				proItem = value[i];
				
				itemRow = int(i / col);
				itemCol = (i % col);
				item = addItem((itemSize + gapX) * itemCol,(itemSize + gapY) * itemRow,i) as ItemCell;
				item.data = proItem;
			}
			
			var count:int = Math.min(_col,_data.length);//列宽
			this.width = itemWidth * count + gapX * (Math.max(0,count - 1));
		}
		/**
		 * 给grid添加格子 
		 * @param lx 坐标
		 * @param ly 
		 * @param index 物品索引
		 * @param isPushVec 是否要推入的数组里面，有些格子不一定要加入到_itemVec，比如会有些动态变化，EXAMP：@see FateCellBagGrid
		 * @return 
		 * 
		 */
		public function addItem(lx:int,ly:int,index:int,isPushVec:Boolean = true):Cell
		{
			var item:Cell = new ITEM_CLASS();
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
			addChild(item);
			item.x = lx;
			item.y = ly;
			item.itemIndex = index;
			item.size = itemSize;
			if(isPushVec)
				_itemList.push(item);
			setPropItem(item);
			return item;
		}
		/**
		 * 设置item的一些属性 
		 * 
		 */		
		override protected function setPropItem(item:ItemRender):void
		{
			super.setPropItem(item);
			Cell(item).itemSrcType = _itemSrcType;
			Cell(item).setBackGroud(itemBg);
		}
		/**
		 * 设置格子背景 
		 * @return 
		 * 
		 */		
		public function get itemBg():BitmapData
		{
			return _itemBg;
		}
		
		public function set itemBg(value:BitmapData):void
		{
			_itemBg = value;
		}
		
		override protected function onDoubleClick(e:MouseEvent):void
		{
			MenuPanel.instance.hide();
			var item:Cell = (e.currentTarget as Cell);
			if(item)
			{
				item.onDoubleClick();
				dispatchEvent(new DataGroupEvent(DataGroupEvent.DOUBLE_CLICK,item));
			}
		}
		
		override protected function onClick(e:MouseEvent):void
		{
			if(isClick)
			{
				var item:Cell = (e.currentTarget as Cell);
				if(_curOverItem != item) return;
				if(item && item.data)
				{
					item.onClick();
				}
				dispatchEvent(new DataGroupEvent(DataGroupEvent.CLICK,item));
			}
	
		}
		
		
		override protected function onMouseOut(e:MouseEvent):void
		{
			super.onMouseOut(e);
			_curOverItem = null;
		}
		
		override protected function onMouseOver(e:MouseEvent):void
		{
			_curOverItem = (e.currentTarget as Cell);
			super.onMouseOver(e);
		}

		
		/**
		 * 格子来源 
		 */
		public function get itemSrcType():int
		{
			return _itemSrcType;
		}
		public function set itemSrcType(value:int):void
		{
			_itemSrcType = value;
			if(_itemList && _itemList.length > 0)
			{
				for each(var item:ItemRender in _itemList)
				{
					Cell(item).itemSrcType = _itemSrcType;
				}
			}
		}
		
		
		/**
		 * 清除数据相关 
		 * 
		 */		
		override public function clear():void
		{
			super.clear();
			MenuPanel.instance.hide();
			_curOverItem = null;
			_data = null;
		}
		
	}
}