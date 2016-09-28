package com.gamehero.sxd2.gui.core.group
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.gui.bag.model.vo.ItemCellData;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.core.interFace.ICellData;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.pro.PRO_Item;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	
	import bowser.loader.BulkLoaderSingleton;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * 基础的格子,只设置一个图标
	 * @author weiyanyu
	 * 创建时间：2016-1-4 下午3:26:53
	 * 
	 */
	public class Cell extends ItemRender implements ICellData
	{
		/**
		 * 背景框 
		 */		
		protected var _backGroud:Bitmap;
		/**
		 * 图标资源 
		 */		
		protected var _icon:ScaleBitmap;
		
		/**
		 * 图标路径 
		 */		
		protected var _url:String;
		
		/**
		 * 道具信息 
		 */		
		protected var _propVo:PropBaseVo;
		
		private var _itemSrcType:int;
		
		/**
		 * 格子大小 
		 */		
		protected var _size:int;
		
		protected var _itemCellData:ItemCellData = new ItemCellData();
		
		protected var _iconWidth:int = 0;//图标默认大小
		protected var _iconHeight:int = 0;//图标默认大小
		/**
		 * 加载圆圈 
		 */		
		protected var _loading:MovieClip;
		
		public function Cell()
		{
			super();
			initUI();
		}
		
		/**
		 * 设置格子背景 
		 * @param bd
		 * 
		 */		
		public function setBackGroud(bd:BitmapData):void
		{
			_backGroud.bitmapData = bd;
			initLoc();
		}
		
		/**
		 * 格子来源类型 
		 */
		public function get itemSrcType():int
		{
			return _itemSrcType;
		}

		/**
		 * @private
		 */
		public function set itemSrcType(value:int):void
		{
			_itemSrcType = value;
		}

		/**
		 * 格子道具信息 
		 * @return 
		 * 
		 */		
		public function get propVo():PropBaseVo
		{
			return _propVo;
		}
		
		public function set propVo(value:PropBaseVo):void
		{
			_propVo = value;
			url = GameConfig.ITEM_ICON_URL + value.ico + ".swf";
		}
		
		
		/**
		 * @private
		 */
		override public function set data(value:Object):void
		{
			
			if(value == null)
			{
				clear();
				return;
			}
			_data = value;
			propVo = ItemManager.instance.getPropById(_data.itemId);
		}
		
		/**
		 * 格子信息，来源；基础数据；服务器数据； 
		 */
		public function get itemCellData():ItemCellData
		{
			_itemCellData.itemSrcType = itemSrcType;
			_itemCellData.data = data as PRO_Item;
			_itemCellData.propVo = propVo;
			return _itemCellData;
		}
		/**
		 * 设置基本的ui 
		 * 
		 */		
		protected function initUI():void
		{
			_backGroud = new Bitmap();
			addChild(_backGroud);
			_icon = new ScaleBitmap();
			addChild(_icon);
		}
		public function set size(value:int):void
		{
			this.height = this.width = _size = value;
			initLoc();
		}
		
		public function get size():int
		{
			return _size;
		}
		
		public function set iconWidth(value:int):void{
			_iconWidth = value;
		}
		
		public function get iconWidth():int{
			return _icon.width;
		}
		
		public function set iconHeight(value:int):void{
			_iconHeight = value;
		}
		
		public function get iconHeight():int{
			return _icon.height;
		}
		/**
		 * 设置hint放在了设置url的地方 
		 * @param value
		 * 
		 */		
		protected function set url(value:String):void
		{
			_url = value;
			this.hint = _propVo.ico + "";
			if(value != "")
			{
				if(_loading == null)
				{
					_loading = new MainSkin.iconLoadingClass();//菊花要放在加载上面，如果放在load下面：资源已经存在时候，菊花会一直存在
					
					_loading.x = _size >> 1;
					_loading.y = _size >> 1;
					
				}
				_loading.play();
				this.addChild(_loading);
				BulkLoaderSingleton.instance.addWithListener(_url, null, onIconLoaded,null, onIconLoadError);
				BulkLoaderSingleton.instance.start();
			}

		}
		
		protected function onIconLoaded(event:Event):void {
			
			if(_loading != null && this.contains(_loading) == true)
			{
				_loading.stop();
				this.removeChild(_loading);
			}
			
			var imageItem:ImageItem = event.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE, onIconLoaded);
			imageItem.removeEventListener(ErrorEvent.ERROR, onIconLoadError);
			
			var PNGDataClass:Class = imageItem.getDefinitionByName("PNGData") as Class;
			_icon.bitmapData = new PNGDataClass();
			if((_iconWidth > 0) && (_iconHeight > 0)){
				_icon.setSize(_iconWidth,_iconHeight);
			}
			initLoc();
		}
		
		/**
		 * 加载失败（临时用） 
		 * @param event
		 * 
		 */
		protected function onIconLoadError(event:ErrorEvent):void {
			
			event.target.removeEventListener(Event.COMPLETE, onIconLoaded);
			event.target.removeEventListener(ErrorEvent.ERROR, onIconLoadError);
			// 使用默认图标
			_url = GameConfig.ITEM_ICON_URL + "default.swf";
			BulkLoaderSingleton.instance.addWithListener(_url, null, onIconLoaded);
		}	
		
		/**
		 * 重新设置位置 
		 * 
		 */		
		protected function initLoc():void
		{
			if(_icon.width > 0)
			{
				_icon.x = (_size - _icon.width) >> 1;
				_icon.y = (_size - _icon.height) >> 1;
			}
			_backGroud.x = _size - _backGroud.width >> 1;
			_backGroud.y = _size - _backGroud.height >> 1;
		}
		
		override public function clear():void
		{
			_icon.bitmapData = null;
			this.hint = null;
			_data = null;
			_propVo = null;
			if(_loading != null && this.contains(_loading) == true)
			{
				_loading.stop();
				this.removeChild(_loading);
			}
//			itemSrcType = 0;
		}
	}
}