package com.gamehero.sxd2.gui.bag
{
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.SButton;
	import com.gamehero.sxd2.gui.bag.component.BagItemCell;
	import com.gamehero.sxd2.gui.bag.events.BagEvent;
	import com.gamehero.sxd2.gui.bag.model.BagModel;
	import com.gamehero.sxd2.gui.bag.model.ItemSizeDict;
	import com.gamehero.sxd2.gui.bag.model.ItemSrcTypeDict;
	import com.gamehero.sxd2.gui.buyback.BuybackWindow;
	import com.gamehero.sxd2.gui.core.GeneralWindow;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.core.group.CellGrid;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.scrollBar.ScrollBar;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ItemSkin;
	import com.gamehero.sxd2.pro.PRO_Item;
	
	import flash.display.Bitmap;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import alternativa.gui.container.list.List;
	import alternativa.gui.data.DataProvider;
	
	/**
	 * 
	 * 背包界面
	 * @author weiyanyu
	 * 创建时间：2015-8-5 下午7:55:56
	 * 
	 */
	public class BagWindow extends GeneralWindow
	{
		/**
		 * 格子框框 
		 */		
		private var _itemGrid:CellGrid;
		
		private var itemList:alternativa.gui.container.list.List;
		private var dataPro:DataProvider;
		
		/**
		 * 当前列数 
		 */		
		private const COL:int = 7;
		/**
		 * 显示的行数 
		 */		
		private const ROW:int = 9;
		
		private var _model:BagModel;
		
		
		/**
		 * 背包界面需要用到的数据<br>
		 * 背包界面打开后不需要自动排序,数据只是保留了打开背包界面时候的。 
		 */		
		private var viewUseBagArr:Array;
		
		private var _pawnshopBtn:SButton;
		
		
		public function BagWindow(position:int, resourceURL:String="BagWindow.swf", width:Number=0, height:Number=0)
		{
			super(position, resourceURL, 385, 550);
		}
		
		override protected function initWindow():void
		{
			super.initWindow();
			_model = BagModel.inst;
			BagModel.inst.domain = this.uiResDomain;
			
			initBackground();
		}
		
		private function initBackground():void{
			
	
			_itemGrid = new CellGrid(BagItemCell,ItemSizeDict.bag,ItemSrcTypeDict.BAG,true,true);
			_itemGrid.col = COL;
			_itemGrid.gapX = 4;
			_itemGrid.gapY = 4;
			_itemGrid.itemBg = ItemSkin.BAG_ITEM_NORMAL_BG;
			
			dataPro = new DataProvider();
			
			itemList = new List();
			addChild(itemList);
			itemList.container = _itemGrid;
			itemList.scrollBar = new ScrollBar();
			itemList.dataProvider = dataPro;
			itemList.width = 370;
			itemList.height = 447;
			itemList.x = 17;
			itemList.y = 53;
			
//			_gridPanel = new NormalScrollPane();
//			_gridPanel.content = _itemGrid;
//			_gridPanel.width = 368;
//			_gridPanel.height = 447;
//			_gridPanel.x = 17;
//			_gridPanel.y = 53;
//			addChild(_gridPanel);
			
			_pawnshopBtn = new SButton(CommonSkin.getClass("panelBtn") as SimpleButton,"当铺",new Bitmap(getSwfBD("BuyBack_Icon")));
			_pawnshopBtn.x = 148;
			_pawnshopBtn.y = 516;
			addChild(_pawnshopBtn);
		}
		
		override protected function onShow():void
		{
			super.onShow();
			
			viewUseBagArr = _model.mainItemArr;
			
			_model.addEventListener(BagEvent.MAIN_ITEM_ADD,changeItem);
			_model.addEventListener(BagEvent.MAIN_ITEM_CHANGE,changeItem);
			_model.addEventListener(BagEvent.MAIN_ITEM_DELETE,changeItem);
			
			_pawnshopBtn.addEventListener(MouseEvent.CLICK,actionBtnClickHandle);
			
			addEventListener(Event.RENDER, render);
			
			updataBag();
			
		}
		//============业务逻辑=========================
		/**
		 * 是否有道具更新 <br>
		 * stage.invalidate();
		 * @see http://blog.csdn.net/ityuany/article/details/4662378
		 */		
		private var changed:Boolean;
		
		private function render(e:Event):void {
			if(changed) {
				changed = false;
				updataBag();
			}
		}
		/**
		 * 有道具更新 
		 * 
		 */		
		private function callChange():void {
			changed = true;
			if(stage != null) stage.invalidate();
		}
		/**
		 * @param event
		 * 
		 */		
		protected function changeItem(event:BagEvent):void
		{
			switch(event.type)
			{//增加或者删除物品的时候，需要重新排序，如果只是数量变化了，则不需要
				case BagEvent.MAIN_ITEM_DELETE:
					viewUseBagArr = _model.mainItemArr.concat();
					break;
				case BagEvent.MAIN_ITEM_CHANGE:
					var data:PRO_Item = event.data as PRO_Item;
					for each(var pro:PRO_Item in viewUseBagArr)
					{
						if(data.id.toString() == pro.id.toString())
						{
							pro.num = data.num;
							break;
						}
					}
					break;
				case BagEvent.MAIN_ITEM_ADD:
					viewUseBagArr = _model.mainItemArr.concat();
					break;
					
			}
			callChange();
		}
		
		
		/**
		 * 打开回购
		 * @param event
		 * 
		 */		
		protected function actionBtnClickHandle(event:MouseEvent):void
		{
			MainUI.inst.openWindow(WindowEvent.BUYBACK_WINDOW);
		}
		
		private function updataBag():void
		{
			var addSpaceArr:Array;//填充的空格子
			var dataProvider:Array = viewUseBagArr.concat();
			if(dataProvider.length < COL * ROW)
			{
				addSpaceArr = new Array(COL * ROW - dataProvider.length);
				dataProvider = dataProvider.concat(addSpaceArr);
			}
			var residue:int = dataProvider.length % COL;//为了多出来一行，还需要添加,
			
			var addNum:int = residue > 0 ? (COL - residue) + COL : COL;//当前页要比有数据的格子多出来一行。
			addSpaceArr = new Array(addNum);
			dataPro.removeAll();
			dataPro.addItems(dataProvider.concat(addSpaceArr));
			itemList.dataProvider = dataPro;
//			_itemGrid.data = dataProvider.concat(addSpaceArr);
//			_gridPanel.refresh();
		}
		
		
		
		override public function close():void
		{
			super.close();
			WindowManager.inst.closeGeneralWindow(BuybackWindow);
			_itemGrid.clear();
			removeEventListener(Event.RENDER, render);
			_model.removeEventListener(BagEvent.MAIN_ITEM_ADD,changeItem);
			_model.removeEventListener(BagEvent.MAIN_ITEM_CHANGE,changeItem);
			_model.removeEventListener(BagEvent.MAIN_ITEM_DELETE,changeItem);
			
			_pawnshopBtn.removeEventListener(MouseEvent.CLICK,actionBtnClickHandle);
			
		}
	}
}