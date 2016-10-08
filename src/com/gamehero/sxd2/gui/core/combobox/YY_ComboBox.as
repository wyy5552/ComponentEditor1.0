package com.gamehero.sxd2.gui.core.combobox
{
	import com.gamehero.sxd2.event.BaseEvent;
	import com.gamehero.sxd2.gui.core.group.Group;
	import com.gamehero.sxd2.gui.core.group.ItemRender;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.dropDownList.DropDownListItem;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.dropDownList.DropDownListVO;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.scrollBar.ScrollBar;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ChatSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.util.FiltersUtil;
	
	import flash.events.MouseEvent;
	
	import alternativa.gui.base.ActiveObject;
	import alternativa.gui.base.GUIobject;
	import alternativa.gui.container.list.List;
	import alternativa.gui.data.DataProvider;
	import alternativa.gui.enum.Align;
	import alternativa.gui.event.ListEvent;
	import alternativa.gui.mouse.MouseManager;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * 下拉菜单栏
	 * @author weiyanyu
	 * 创建时间：2016-8-16 下午3:59:16
	 * 
	 */
	public class YY_ComboBox extends GUIobject
	{
		/** 文本 **/
		private var titleItem:DropDownListItem;
		/** 下拉按钮 **/
		private var downBtn:Button;
		/** 上拉按钮 **/
		private var upBtn:Button;
		
		public var align:Align = Align.LEFT;
		
		/** 列表背景 **/
		private var listBg:ScaleBitmap;
		/** 列表 **/
		private var list:List;
		
		private var listGroup:Group;
		
		public var HEIGHT:int = 24;
		
		/** 下拉选择框最大能显示的条目数量 **/
		private var m_maxItemNum:int = 999;
		
		/** 下拉选择的数据 **/
		private var m_dataSource:Array;
		
		/** 当前选中状态的索引 **/
		private var m_selectedIndex:uint;
		
		protected var _isShowPanel:Boolean = false;
		
		private var _activeTitleArea:ActiveObject;
		
		public var gap:int = 1;
		
		private var UIGap:int = 6;
		
		public function YY_ComboBox()
		{
			super();
			
			downBtn = new Button(ChatSkin.DOWNBTN_UP,ChatSkin.DOWNBTN_DOWN,ChatSkin.DOWNBTN_OVER);
			this.addChild(downBtn);
			
			upBtn = new Button(ChatSkin.UPBTN_UP,ChatSkin.UPBTN_DOWN,ChatSkin.UPBTN_OVER);
			this.addChild(upBtn);
			
			listBg = new ScaleBitmap(CommonSkin.MENU_BG);
			listBg.scale9Grid = CommonSkin.MENU_BG_GRID;
			this.addChild(listBg);
			
			titleItem = new DropDownListItem();
			addChild(titleItem);
			
			_activeTitleArea = new ActiveObject();
			addChild(_activeTitleArea);
			_activeTitleArea.addEventListener(MouseEvent.CLICK,setListVisible);
			
			listGroup = new Group();
			listGroup.col = 1;
			listGroup.gapY = gap;
			listGroup.mouseOverAble = true;
			listGroup.mouseClickAble = true;
//			listGroup.needRenderEvent = true;
			
			list = new List();
			list.container = listGroup;
			list.itemRenderer = DropDownListItem;
			list.scrollBar = new ScrollBar();
			list.addEventListener(ListEvent.CLICK_ITEM, onItemSelected);
			this.addChild(list);
			list.y = HEIGHT + gap;
			
			isShowPanel = false;
			mouseEnabled = true;
			
		}
		
		override public function set width(value:Number):void
		{
			super.width = value;
			draw();
		}
		override public function set height(value:Number):void
		{
			super.height = value;
			draw();
		}
		
		public function get isShowPanel():Boolean
		{
			return _isShowPanel;
		}

		public function set isShowPanel(value:Boolean):void
		{
			_isShowPanel = value;
			if(isShowPanel)
			{
				showList();
			}
			else
			{
				hideList();
			}
		}
		protected function setListVisible(event:MouseEvent):void
		{
			MouseManager.update();
			isShowPanel = !isShowPanel;
			
		}
		/**
		 * 隐藏面板 
		 */		
		public function hideList():void
		{
			
			list.visible = false;
			listBg.setSize(itemWidth,HEIGHT);
			upBtn.visible = false;
			downBtn.visible = true;
			dispatchEvent(new BaseEvent(BaseEvent.BASE＿Event,false));
		}
		
		public function showList():String
		{
			
			list.visible = true;
			listBg.setSize(itemWidth,(HEIGHT + gap) * (maxItemNum + 1) + 2);
			upBtn.visible = true;
			downBtn.visible = false;
			
			var str:String = "";
			var item:ItemRender;
			//刷新子项的宽度
			for(var i:int = 0; i < listGroup.itemList.length; i++)
			{
				item = listGroup.itemList[i];
				if(item)
				{
					item.width = itemWidth;
					item.height = HEIGHT;
					str += DropDownListItem(item).text + item.visible + "\n";
				}
			}
			
			dispatchEvent(new BaseEvent(BaseEvent.BASE＿Event,true));
			return str;
		}
		override protected function draw():void
		{
			//头部可点区域
			_activeTitleArea.graphics.clear();
			_activeTitleArea.graphics.beginFill(0x000000,0);
			_activeTitleArea.graphics.drawRect(0,0,width,HEIGHT);
			_activeTitleArea.graphics.endFill();
			
			titleItem.width = itemWidth;
			titleItem.height = HEIGHT;
			
			upBtn.x = downBtn.x = itemWidth + UIGap;
			upBtn.y = downBtn.y = HEIGHT - upBtn.height >> 1;
			
			list.y = HEIGHT + gap;
			//设置list宽高
			list.width = itemWidth + 9;//划尺宽度是9
			list.height = maxItemNum * (HEIGHT + gap);
			
			listGroup.itemWidth = itemWidth;
			listGroup.itemHeight = HEIGHT;
		}
		/**
		 * 选中信息的索引
		 */
		public function get selectedIndex():uint
		{
			return m_selectedIndex;
		}
		public function set selectedIndex(value:uint):void
		{
			if(value>=m_dataSource.length){
				throw new Error("DropDownList：selectIndex索引溢出！");
			}
			m_selectedIndex = value;
			titleItem.text = m_dataSource[value].title;
			listGroup.selectedIndex = value;
		}
		
		public function get selectedItem():Object
		{
			return listGroup.selectedItem;
		}
		/**
		 * 下拉选择的数据
		 */
		public function get dataSource():Array
		{
			return m_dataSource;
		}
		public function set dataSource(value:Array):void
		{
			m_dataSource = value;
			isShowPanel = false;
			if(!m_dataSource || m_dataSource.length==0){
				this.locked = true;
				titleItem.text = "";
				
			}else{
				this.locked = false;
				
				var i:int;
				var len:int = m_dataSource.length;
				var listData:DataProvider = new DataProvider();
				listData.addItems(m_dataSource);
				list.dataProvider = listData;
				listGroup.update();
				this.selectedIndex = 0;
				titleItem.text = value[0].title;
				
			}
			draw();
		}
		
		public function get itemWidth():int
		{
			return width - upBtn.width - UIGap;
		}
		/**
		 * 选中了列表项
		 */
		private function onItemSelected(evt:ListEvent):void
		{
			this.selectedIndex = list.selectedIndex;
			titleItem.text = (list.selectedItem as DropDownListVO).title;
			hideList();
			dispatchEvent(new ListEvent(ListEvent.LIST_CHANGE, evt));
		}
		
		/**
		 * 下拉选择框最大能显示的条目数量
		 */
		public function get maxItemNum():int
		{
			return m_maxItemNum;
		}
		public function set maxItemNum(value:int):void
		{
			if(value<2){
				throw new Error("DropDownList：maxItemNum不能小于2");
			}
			m_maxItemNum = value;
			draw();
		}
		/**
		 * 是否锁定组件
		 */
		public function set locked(value:Boolean):void
		{
			FiltersUtil.grayFilter(this, value);
			upBtn.locked = downBtn.locked = value;
			if(value)
			{
				_activeTitleArea.removeEventListener(MouseEvent.CLICK,setListVisible);
			}
			else
			{
				_activeTitleArea.addEventListener(MouseEvent.CLICK,setListVisible);
			}
		}
		
		
	}
}