package com.gamehero.sxd2.gui.bag.component
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.bag.model.BagTypeDict;
	import com.gamehero.sxd2.gui.bag.model.ItemSizeDict;
	import com.gamehero.sxd2.gui.bag.model.ItemTypeDict;
	import com.gamehero.sxd2.gui.bag.model.vo.ItemCellData;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.core.group.Cell;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ItemSkin;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.pro.PRO_Item;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	import alternativa.gui.enum.Align;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * 物品格子<br>
	 * <li>物品品质框，以及闪烁
	 * <li>镀金处理
	 * <li>碎片处理
	 * <li>时限处理
	 * <li>数量设置
	 * @author weiyanyu
	 * 创建时间：2015-8-5 下午7:58:02
	 * 
	 */
	public class ItemCell extends Cell
	{
		
		public static var CIRCLE:int = 1;
		public static var  RECT:int = 0;
		
		
		/**
		 * 被用来设置遮罩的容器 ，碎片显示用
		 */		
		protected var _maskedContaner:Sprite;
		/**
		 * 品质框 
		 */		
		protected var _qualityBg:ItemQualityBg;
		/**
		 * 右下角的数量字符 
		 */		
		protected var _numLabel:Label;
		/**
		 * 装备的镀金边框 
		 */		
		protected var _equipGoldBg:Bitmap;
		/**
		 * 时限框 
		 */		
		protected var _timeLiness:ItemTimeliness;
		/**
		 * 拖拽的数据 
		 */		
		protected var _dragData:Object;
		
		protected var _mouseOverAble:Boolean = false;
		
		/**
		 * 黑色遮罩 
		 */		
		protected var _blackMask:Bitmap;
		
		protected var _num:int;
		
		public function ItemCell(itemSize:int = 0)
		{
			super();
			mouseChildren = false;
			size = itemSize > 0 ? itemSize : ItemSizeDict.bag;
			initUI();
		}
		
		/**
		 * 是否有鼠标滑动的效果 
		 */
		public function get mouseOverAble():Boolean
		{
			return _mouseOverAble;
		}

		/**
		 * @private
		 */
		public function set mouseOverAble(value:Boolean):void
		{
			_mouseOverAble = value;
			if(mouseOverAble)
			{
				addEventListener(MouseEvent.ROLL_OVER,onOver);
				addEventListener(MouseEvent.ROLL_OUT,onOut);
			}
			else
			{
				removeEventListener(MouseEvent.ROLL_OVER,onOver);
				removeEventListener(MouseEvent.ROLL_OUT,onOut);
			}
		}
		
		/**
		 * 设置基本的ui 
		 * 
		 */		
		override protected function initUI():void
		{
			
			_maskedContaner = new Sprite();
			addChild(_maskedContaner);
			
			_backGroud = new Bitmap();
			_maskedContaner.addChild(_backGroud);
			
			_qualityBg = new ItemQualityBg();
			_qualityBg.qualityBgRes = ItemSkin.BagBgArr;//default
			_maskedContaner.addChild(_qualityBg);
			_qualityBg.visible = false;
			
			_icon = new ScaleBitmap();
			_maskedContaner.addChild(_icon);
			
			_timeLiness = new ItemTimeliness();
			_maskedContaner.addChild(_timeLiness);
			
			_numLabel = new Label();
			_numLabel.align = Align.RIGHT;
			_numLabel.color = GameDictionary.ITEM_LABEL;
			_numLabel.filters = [new GlowFilter(0x000000, 1, 2, 2, 8)];
			_maskedContaner.addChild(_numLabel);
			
		}
		
		override public function set scaleX(value:Number):void
		{
			super.scaleX = value;
			iconWidth = size * value;
		}
		
		override public function set scaleY(value:Number):void
		{
			super.scaleY = value;
			iconHeight = size * value;
		}
		/**
		 * 重新设置位置 
		 * 
		 */		
		override protected function initLoc():void
		{
			super.initLoc();
			
			_numLabel.y = _size - 16;
			_numLabel.width = _size - 2;//减2，不要太靠右
		}
		
		/**
		 * 格子信息，来源；基础数据；服务器数据； 
		 */
		override public function get itemCellData():ItemCellData
		{
			_itemCellData.itemSrcType = itemSrcType;
			_itemCellData.propVo = propVo;
			if(data != null)
			{
				_itemCellData.data = data as PRO_Item;
			}
			else if(num > 0)
			{
				var pro:PRO_Item = new PRO_Item();
				if(propVo != null)
				{
					pro.itemId = int(propVo.id);
				}
				pro.num = num;
				_itemCellData.data = pro;
			}
			
			return _itemCellData;
		}
		
		public function get itemType():int
		{
			return propVo.type;
		}
		/**
		 * 格子道具信息 
		 * @return 
		 * 
		 */		
		override public function get propVo():PropBaseVo
		{
			if(_data && _propVo == null)
			{
				_propVo = ItemManager.instance.getPropById(_data.itemId);
			}
			return _propVo;
		}
		
		override public function set propVo(value:PropBaseVo):void
		{
			_propVo = value;
			url = GameConfig.ITEM_ICON_URL + value.ico + ".swf";
			_qualityBg.quality = _propVo.quality;//设置品质
			_qualityBg.visible = true;
		}

		public function set qualityBgRes(value:Vector.<BitmapData>):void{
			_qualityBg.qualityBgRes = value;
		}
		
		/**
		 * @private
		 */
		override public function set data(value:Object):void
		{
			super.data = value;
			
			if(value) 
			{
				num = (value.num);// 数量
				if(value.gilt)//镀金了
				{
					addGiltBg();
				}
				else
				{
					clearGiltBg();
				}
				_timeLiness.clear();
				_timeLiness.outTime = value.endTime;
			}
			
		}
		/**
		 * 添加镀金边框 
		 * 
		 */		
		public function addGiltBg():void
		{
			if(_equipGoldBg == null)
			{
				_equipGoldBg = new Bitmap(ItemSkin.ItemGoldBg);
				_maskedContaner.addChild(_equipGoldBg);
				_equipGoldBg.x = _icon.x;
				_equipGoldBg.y = _icon.y;
			}
		}
		
		private function clearGiltBg():void
		{
			if(_equipGoldBg != null && _equipGoldBg.parent)
			{
				_equipGoldBg.parent.removeChild(_equipGoldBg);
				_equipGoldBg = null;
			}
		}
		
		
		
		/**
		 * 设置右下角数量显示 
		 * @param value
		 * 
		 */		
		public function set num(value:int):void
		{
			_num = value;
			if(value <= 1)
			{
				_numLabel.text = "";
			}
			else
			{//http://10.1.29.87:8080/browse/SXD-4380 显示规则
				var str:String = GameDictionary.formatMoney(value);
				_numLabel.text = str;
			}
			initLoc();
		}
		public function get num():int
		{
			return _num;
		}
		
		public function set numStr(value:String):void
		{
			_numLabel.text = value;
			initLoc();
		}
		
		override protected function onIconLoaded(event:Event):void
		{
			
			super.onIconLoaded(event);
			isChips = (propVo && propVo.type == ItemTypeDict.HERO_CHIPS)//碎片要加一个六边形的遮罩
		}
		
		override public function onOver(e:MouseEvent = null):void
		{
			if(_qualityBg)_qualityBg.over();
		}
		
		override public function onOut(e:MouseEvent = null):void
		{
			if(_qualityBg)_qualityBg.out();
		}
		
		
		/**
		 * 是否是碎片，碎片有特殊的显示规则 
		 * @param bool
		 * 
		 */		
		public function set isChips(bool:Boolean):void
		{
			bool ? addChipMask() : clearChipMask();
		}
		
		/**
		 * 碎片添加特殊图片遮罩 
		 * 
		 */		
		protected function addChipMask():void
		{
			if(_blackMask == null)
			{
				_blackMask = new Bitmap(ItemSkin.ChipSmallMask);
				addChild(_blackMask); 
				_blackMask.cacheAsBitmap = true;
				_maskedContaner.cacheAsBitmap = true;
				_maskedContaner.mask = _blackMask;
			}
		}
		/**
		 * 碎片去掉特殊图片遮罩 
		 * 
		 */		
		protected function clearChipMask():void
		{
			if(_blackMask && _blackMask.parent){
				_blackMask.parent.removeChild(_blackMask);
				_blackMask = null;
				this.mask = null;
				_maskedContaner.cacheAsBitmap = false;
				_maskedContaner.mask = null;
			}
		}
		
		
		public static function isItemTypeSpecial(type:int):Boolean
		{
			return (type == ItemTypeDict.FATE_CELL     //命格
				|| type == ItemTypeDict.FATE_CELL_DARK//暗命格
				|| type == ItemTypeDict.WASH_EQUIP);//灵件;
		}
		/**
		 * 根据背包类型判断是否为特殊背景框 
		 * @param bagType 服务器的背包类型
		 * @return 
		 * 
		 */		
		public static function isBagTypeSpecial(bagType:int):Boolean
		{
			return (bagType == BagTypeDict.FATE_CELL_BAG
				|| bagType == BagTypeDict.FATE_CELL_DARK_BAG
				|| bagType == BagTypeDict.WASH_WEAPEN);
		}
		
		/**
		 * 
		 * 清除数据相关的内容
		 * （一般用于界面内清除，背景_backGroud保留）
		 *  @see gc()
		 */		
	    override public function clear():void
		{
			_icon.bitmapData = null;
			_qualityBg.visible = false;
			_timeLiness.clear();
			itemSrcType = 0;
			this.hint = "";
			_data = null;
			_propVo = null;
			_url = null;
			this.filters = null;
			if(_numLabel)
			{
				_numLabel.text = "";
			}
			_dragData = null;
			
			if(_mouseOverAble)
			{
				removeEventListener(MouseEvent.ROLL_OVER,onOver);
				removeEventListener(MouseEvent.ROLL_OUT,onOut);
			}
			
			clearChipMask();
			clearGiltBg();
		}
	}
}