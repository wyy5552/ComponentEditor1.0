package com.gamehero.sxd2.gui.core.money
{
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.bag.model.BagModel;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	
	import flash.events.Event;
	
	import alternativa.gui.mouse.CursorManager;
	
	
	/**
	 * 消耗物品<br>
	 * 一个物品图标，一串数字<br>
	 * 铜钱图标是一个有很大空白像素的方框，左侧8像素透明，上方7像素，下方6像素
	 * @author weiyanyu
	 * 创建时间：2015-11-15 下午6:23:54
	 * 
	 */
	public class MoneyLabel extends MoneyBaseLabel
	{
		
		private var _icon:MoneyIcon;
		
		private var _label:Label;
		
		private const GAP:int = 5;
		/**
		 * 需要消耗的数量 
		 */		
		private var _needNum:int;
		
		public function MoneyLabel()
		{
			super();
			_icon = new MoneyIcon();
			_label = new Label();
			
			addChild(_icon);
			addChild(_label);
			
			this.mouseChildren = false;
		}
		
		override public function set iconId(value:int):void
		{
			super.iconId = value;
			if(_icon.iconId != value)
			{
				_icon.iconId = value;
				_icon.addEventListener(Event.COMPLETE,onComplet);
			}
			else
			{
				resize();
			}
		}
		
		private function resize():void
		{
			_label.x = _icon.width + GAP;
			_label.y = _icon.height - _label.height >> 1;
			this.width = _icon.width + GAP + _label.width;
		}
		/**
		 *  需要实时更新物品数量
		 * @param num 基础值，如果低于这个值 显示红色，大于或等于这个值显示白色
		 * @param fun
		 * 
		 */		
		public function needFresh(num:int = 0):void
		{
			_needNum = num;
			setAutoColor();
			activeFresh = true;
		}
		
		override protected function updataPlayerHandle(event:Event):void
		{
			super.updataPlayerHandle(event);
			setAutoColor();
		}
		
		private function setAutoColor():void
		{
			if(_needNum > BagModel.inst.getNumByItemId(_icon.iconId))
			{
				_label.color = GameDictionary.RED;
			}
			else
			{
				_label.color = GameDictionary.WHITE;
			}
		}
		
		override public function set num(value:Number):void
		{
			super.num = value;
			_label.text = GameDictionary.formatMoney(value);
			resize();
		}
		public function set text(value:String):void
		{
			_label.text = value;
			resize();
		}
		/**
		 *  根据文本的坐标y设置新坐标；<br>
		 *  正常情况下坐标设置是根据 icon图标的。<br>
		 * 
		 */		
		public function setyByLabel(value:int):void
		{
			resize();
			this.y = value - _label.y;
		}
		/**
		 * 获取label，方便给lb设置属性 <br>
		 * 注意   不要直接设置文本，否则坐标会有问题
		 * @return 
		 * 
		 */		
		public function get lb():Label
		{
			return _label;
		}
		
		/**
		 * 不需要tips
		 * */
		public function hideHint():void
		{
			this.hint = "";
			this.cursorType = CursorManager.ARROW;
		}
		
		protected function onComplet(event:Event):void
		{
			_icon.removeEventListener(Event.COMPLETE,onComplet);
			resize();
		}
		
	}
}