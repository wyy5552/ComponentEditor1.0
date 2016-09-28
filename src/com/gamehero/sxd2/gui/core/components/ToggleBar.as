package com.gamehero.sxd2.gui.core.components
{
	import com.gamehero.sxd2.gui.core.group.ItemRender;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.greensock.TweenMax;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import alternativa.gui.event.ListEvent;
	
	/**
	 * 一排组件 可以使用左右按钮切换
	 * ListEvent.SELECT_ITEM 选中事件
	 * ListEvent.LIST_CHANGE 点击向左或向右按钮后，在缓动开始时抛出此事件
	 * ListEvent.CHANGE_POSITION 点击向左或向右按钮后，在缓动结束时抛出此事件
	 * @author cuixu
	 * @create：2015-12-30
	 **/
	public class ToggleBar extends Sprite
	{
		private var _render:Class;//render
		private var _leftBtnBDs:Array;//BitmapData:[btn_up,btn_down,btn_over]
		private var _colNum:int;//显示几列cell
		private var _padding:int;//cell间隔
		
		private var _leftBtn:Button;
		private var _rightBtn:Button;
		
		private var _renderW:Number;
		private var _renderH:Number;
		private var _items:Array = [];//注意，左右比实际传入数据各多了一个占位用数据
		private var _itemCells:Array = [];//注意，左右比实际看到的cells各多了一个cell用于动画显示
		private var _cellsContainer:Sprite;//存放cells的容器
		private var _selectedCell:ItemRender = null;//当前选中cell
		private var _leftShowItemIndex:int;//显示出的cells,最左侧的itemIndex，用于判断btn status
		private var _isTweening:Boolean = false;//判断缓动状态
		private var _beginIndex:int = -1;//设置数据源从总数据items的哪个位置开始显示,有效范围从0至_items.length-1
		private var _selectedIndex:int = -1;//设置选择哪个cell，有效范围从0至_colNum-1,注意不包括两侧占位数据
		private var _selectedItem:Object = null;//当前选择的数据
		private var _disableIsHide:Boolean = true;//移到两侧顶端时，相应的按钮是消失不见，还是不可用，默认是消失不见
		private var _moveDuration:Number = 0.7;//点击按钮移动的动画完成时间
		
		/**
		 * 右边按钮的偏移
		 */
		private var _rightBtnPadding:Number;
		/**
		 * 左边边按钮的偏移
		 */
		private var _leftBtnPadding:Number;
		/**
		 * 
		 * @param render 推荐继承ListItemObject类
		 * @param leftBtnBDs BitmapData:[btn_up,btn_down,btn_over]
		 * @param colNum 多少列
		 * @param padding cell的间隙
		 * 
		 */
		public function ToggleBar(render:Class,leftBtnBDs:Array,colNum:int,padding:int = 3,leftBtnPadding:Number = 0,rightBtnPadding:Number = 0)
		{
			super();
			_leftBtnBDs = leftBtnBDs;
			_render = render;
			_colNum = colNum;
			_padding = padding;
			
			_rightBtnPadding = rightBtnPadding;
			_leftBtnPadding = leftBtnPadding;
			initUI();
		}
		
		private function initUI():void{
			var bmpBtnUp:BitmapData = _leftBtnBDs[0];
			var bmpBtnDown:BitmapData = _leftBtnBDs[1];
			var bmpBtnOver:BitmapData = _leftBtnBDs[2];
			_leftBtn = new Button(bmpBtnUp, bmpBtnDown, bmpBtnOver,bmpBtnUp);
			_leftBtn.addEventListener(MouseEvent.CLICK , leftRightHandler);
			addChild(_leftBtn);
			_leftBtn.x = _leftBtnPadding;
			_rightBtn = new Button(bmpBtnUp, bmpBtnDown, bmpBtnOver,bmpBtnUp);
			_rightBtn.scaleX = -1;
			_rightBtn.addEventListener(MouseEvent.CLICK , leftRightHandler);
			addChild(_rightBtn);
			
			_cellsContainer = new Sprite();
			var render:DisplayObject = new _render() as DisplayObject;
			_renderW = render.width;
			_renderH = render.height;
			for(var i:int = 0; i < _colNum + 2; i ++){//头尾各存一个，供动画显示
				render = new _render();
				render.x = (i - 1) * (_renderW + _padding);//第一项的坐标是负的，因为容器的scrollRect是从0开始看的
				render.y = 0;
				render.name = i.toString();
				_cellsContainer.addChild(render);
				render.addEventListener(MouseEvent.CLICK , renderClickHandler);
				_itemCells.push(render);
			}
			addChild(_cellsContainer);
			
			var containerW:Number = _renderW * _colNum + _padding * (_colNum - 1);
			_cellsContainer.scrollRect = new Rectangle(0,0,containerW,_renderH);
			_cellsContainer.x = _leftBtn.width + _padding;//还要加上内容相对于左按钮的间距
			_cellsContainer.y = 0;
			
			_leftBtn.y = _rightBtn.y = (_renderH - _leftBtn.height) / 2;
			_rightBtn.x = _cellsContainer.x + containerW + _padding + _rightBtn.width + _rightBtnPadding;//还要加上内容相对于右按钮的间距
		}
		
		private function combineBitmap(big:BitmapData,small:BitmapData):BitmapData{
			var bmd:BitmapData = new BitmapData(big.width,big.height);
			bmd.draw(big);
			bmd.draw(small);
			return bmd;
		}
		
		private function renderClickHandler(e:MouseEvent):void
		{
			selectCell(e.currentTarget as ItemRender);
		}
		
		private function selectCell(value:ItemRender):void{
			if(_selectedCell != value){
				_selectedItem = value ? value.data : null;
				var itemCell:ItemRender;
				var cellsLength:int = _itemCells.length;
				for(var i:int = 0; i < cellsLength; i ++){
					itemCell = _itemCells[i] as ItemRender;
					if(itemCell.data == _selectedItem){//当前显示Cell中有此数据
						_selectedIndex = i - 1;//去除左侧占位数据
					}
					itemCell.selected = false;
				}
				
				_selectedCell = value;
				if(_selectedCell){
					_selectedCell.selected = true;
					dispatchEvent(new ListEvent(ListEvent.SELECT_ITEM, _selectedCell.data));
				}else{//相当于clear
					_selectedIndex = -1;
					_selectedItem = null;
				}
			}
		}
		
		private function leftRightHandler(e:MouseEvent):void{
			if(_isTweening){
				clearTweens();
			}
			if(e.target == _leftBtn){
				_leftShowItemIndex -- ;
				_beginIndex -- ;
				tweenCells(true);
			}else if(e.target == _rightBtn){
				_leftShowItemIndex ++ ;
				_beginIndex ++ ;
				tweenCells(false);
			}
			updateBtnStatus();//缓动开始前就更新按钮状态
			dispatchEvent(new ListEvent(ListEvent.LIST_CHANGE));
		}
		
		private function tweenCells(clickLeft:Boolean):void{
			var sign:String = clickLeft ? "+" : "-";//点右按钮列表向左走
			var remove:int = _renderW + _padding;
			TweenMax.staggerTo(_itemCells,_moveDuration,{x:sign + remove.toString()},0,tweenComp,[clickLeft]);
			_isTweening = true;
		}
		
		private function tweenComp(clickLeft:Boolean):void{
			_isTweening = false;
			reuseCells(clickLeft);
		}
		
		/**
		 * 每次动画结束后，重用cells
		 * @param clickLeft 是否是点击向左移动
		 * 
		 */
		private function reuseCells(clickLeft:Boolean):void{
			var cell:ItemRender;
			if(clickLeft){
				cell = _itemCells.pop();
				cell.itemIndex -= _colNum + 2;
				(cell as DisplayObject).x = - (_renderW + _padding);//放到0，0点的左边第一个位置
				_itemCells.unshift(cell);
			}else{
				//_itemCells最左侧的数据，重新设定后，移到最右侧
				cell = _itemCells.shift();
				cell.itemIndex += _colNum + 2;//等级增加到队尾等级
				(cell as DisplayObject).x = (_renderW + _padding) * _colNum;//放到可视范围的最右侧。第一项的坐标是负的，所以最后一项的坐标是ITEM_CELLS_NUM个
				_itemCells.push(cell);
			}
			var itemData:Object = getItemByIndex(cell.itemIndex);
			if(itemData.data){
				cell.data = itemData.data;
			}
			if(_itemCells[0].selected){//隐藏掉的是一个选中的项目
				selectCell(_itemCells[1] as ItemRender);//默认显示选中的第一个
			}else if(_itemCells[_colNum + 1].selected){//隐藏掉的是一个选中的项目
				selectCell(_itemCells[_colNum] as ItemRender);//默认显示选中的最后一个
			}
			dispatchEvent(new ListEvent(ListEvent.CHANGE_POSITION));
		}
		
		public function get items():Array{
			var result:Array = [];
			if(_items.length > 0){
				//最前和最后各增加一个占位数据 要去除
				for(var i:int = 1; i < _items.length - 1; i ++){
					result.push(_items[i].data);
				}
			}
			return result;
		}
		
		public function set items(value:Array):void{
			clearDatas();
			if(value.length > 0){
				//为了方便处理移动逻辑，在最前和最后各增加一个占位数据
				_items.push({itemIndex:-1,data:null});//占位数据
				var itemsLength:int = value.length;
				for(var i:int = 0; i < itemsLength; i ++){
					_items.push({itemIndex:i,data:value[i]});//为了避免更改传入的数据，将其包装成自增itemIndex的数组
				}
				if(itemsLength < _colNum){//数据不足时，填充null
					for(var j:int = itemsLength; j < _colNum; j ++){
						_items.push({itemIndex:j,data:null});
					}
				}
				_items.push({itemIndex:int(Math.max(itemsLength,_colNum)),data:null});//占位数据
				updateCells();
				_leftShowItemIndex = 0;
			}
			updateBtnStatus();
		}
		
		/**
		 * 移到两侧顶端时，相应的按钮是消失不见，还是不可用，默认是消失不见
		 * 
		 */
		public function set disableIsHide(value:Boolean):void{
			if(value != _disableIsHide){
				_disableIsHide = value;
				updateBtnStatus();
			}
		}
		
		public function get disableIsHide():Boolean{
			return _disableIsHide;
		}
		
		public function get beginIndex():int{
			return _beginIndex;
		}
		
		/**
		 * 设置数据源从总数据items的哪个位置开始显示
		 * @param value
		 * 
		 */
		public function set beginIndex(value:int):void{
			value = Math.max(0, Math.min(value,_items.length - 2 - _colNum));//减2是因为要去除左右两侧的占位数据
			_beginIndex = value;
			var item:Object = _items[value + 1];//由于最左侧插入了一个占位数据，因此要+1
			var leftItemIndex:int = Math.min(Math.max(item.itemIndex,0),_items[_items.length - 1].itemIndex - _colNum);
			updateCells(leftItemIndex);//从未显示的那一个开始更新
			_leftShowItemIndex = leftItemIndex;
			updateBtnStatus();
		}
		
		/**
		 * 从0列到显示的最大列，选择的哪一列
		 * @return 
		 * 
		 */
		public function get selectedIndex():int{
			return _selectedIndex;
		}
		
		/**
		 * 从0列到最大列，设置选择哪一列
		 * 注意如果所选数据不在当前显示的所有列中，则需要先调用beginIndex将数据显示出来
		 * @param value
		 * 
		 */
		public function set selectedIndex(value:int):void{
			value = Math.max(0, Math.min(value, _colNum - 1));
			if(_selectedIndex != value){
				_selectedIndex = value;
				selectCell(_itemCells[_selectedIndex + 1] as ItemRender);//由于最左侧插入了一个占位数据，因此要+1
			}
		}
		
		/**
		 * 在数据源_items中的索引位置
		 * @return 
		 * 
		 */
		public function get selectedItemIndex():int{
			return items.indexOf(_selectedItem);
		}
		
		public function get selectedItem():Object{
			return _selectedItem;
		}
		
		/**
		 * 从0列到最大列，设置选择哪一列
		 * 注意如果所选数据不在当前显示的所有列中，则需要先调用beginIndex将数据显示出来
		 * @param value
		 * 
		 */
		public function set selectedItem(value:Object):void{
			if(value){
				var itemCell:ItemRender;
				var cellsLength:int = _itemCells.length;
				for(var i:int = 0; i < cellsLength; i ++){
					itemCell = _itemCells[i] as ItemRender;
					if(itemCell.data == value){//当前显示Cell中有此数据
						if(_selectedItem != value){
							selectCell(itemCell);
							break;
						}
					}
				}
			}else{
				//selectCell(_itemCells[1] as IItemRenderer);//null时默认选中第一个
				selectCell(null);//null时不选
			}
		}
		
		public function get selectedCell():ItemRender{
			var itemCell:ItemRender;
			var cellsLength:int = _itemCells.length;
			for(var i:int = 0; i < cellsLength; i ++){
				itemCell = _itemCells[i] as ItemRender;
				if(itemCell.data == _selectedItem){//当前显示Cell中有此数据
					return itemCell;
				}
			}
			return null;
		}
		
		/**
		 * 更新_items中某个数据，如果此数据正在显示，则同时更新显示
		 * @param index 在数据源_items中的索引位置
		 * @param item 新的数据
		 * 
		 */
		public function updateItemByIndex(index:int,item:Object):void{
			if((index >= 0) && (index < items.length)){
				var oldItem:Object = items[index];//旧数据
				var itemCell:ItemRender;
				var cellsLength:int = _itemCells.length;
				for(var i:int = 0; i < cellsLength; i ++){
					itemCell = _itemCells[i] as ItemRender;
					if(itemCell.data == oldItem){//当前显示Cell中有此数据
						if(itemCell.data == _selectedItem){//如果恰好是当前选择的数据
							_selectedItem = item;
						}
						itemCell.data = item;
						break;
					}
				}
				var newItem:Object = {itemIndex:index,data:item};//新数据
				_items.splice(index + 1,1,newItem);//_items左侧有个占位数据，删除掉此数据后，插入新数据
			}
		}
		
		private function getItemByIndex(itemIndex:int):Object{
			for each(var item:Object in _items){
				if(item.itemIndex == itemIndex){
					return item;
				}
			}
			return null;
		}
		
		/**
		 * scrollRect默认只显示render宽高，本方法提供更改scrollRect的高度
		 * @param value
		 * 
		 */
		public function restScrollRectH(value:Number):void{
			var containerW:Number = _renderW * _colNum + _padding * (_colNum - 1);
			_cellsContainer.scrollRect = new Rectangle(0,0,containerW,value);
		}
		
		/**
		 * 
		 * @param leftItemIndex 所有的cells中，最左侧的cell对应的itemIndex
		 * 
		 */
		private function updateCells(leftItemIndex:int=0):void{
			var itemCell:ItemRender;
			var cellsLength:int = _itemCells.length;
			for(var i:int = 0; i < cellsLength; i ++){
				itemCell = _itemCells[i] as ItemRender;
				itemCell.itemIndex = _items[i + leftItemIndex].itemIndex;
				if(_items[i + leftItemIndex].data){
					itemCell.data = _items[i + leftItemIndex].data;
				}
			}
		}
		
		
		private function updateBtnStatus():void{
			if(_items.length > 0){
				if(disableIsHide){
					_leftBtn.visible = (_leftShowItemIndex != 0);
					_rightBtn.visible = ((_leftShowItemIndex + _colNum) != _items[_items.length - 1].itemIndex);
				}else{
					_leftBtn.locked = (_leftShowItemIndex == 0);
					_rightBtn.locked = ((_leftShowItemIndex + _colNum) == _items[_items.length - 1].itemIndex);
				}
			}else{
				if(disableIsHide){
					_leftBtn.visible = false;
					_rightBtn.visible = false;
				}else{
					_leftBtn.locked = true;
					_rightBtn.locked = true;
				}
			}
		}
		
		public function set moveDuration(value:Number):void{
			if(_moveDuration != value){
				_moveDuration = value;
			}
		}
		
		private function clearDatas():void{
			_items = [];
			_selectedItem = null;
			_selectedCell = null;
			_selectedIndex = -1;
			_leftShowItemIndex = 0;
			_beginIndex = -1;
		}
		
		private function clearTweens():void{
			TweenMax.killChildTweensOf(_cellsContainer,true);//不停点按钮时，动画未结束就要进行下一步。此时要结束动画并使用参数true来执行tweenComp
			_isTweening = false;
		}
		
		public function clear():void{
			clearTweens();
			var itemCell:ItemRender;
			var cellsLength:int = _itemCells.length;
			for(var i:int = 0; i < cellsLength; i ++){
				itemCell = _itemCells[i] as ItemRender;
				itemCell.clear();
			}
			clearDatas();
		}
	}
}