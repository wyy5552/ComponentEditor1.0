package com.gamehero.sxd2.gui.core.money
{
	import flash.events.Event;
	
	
	/**
	 * 消耗物品<br>
	 * 一个物品图标，一串数字
	 * @author weiyanyu
	 * 创建时间：2015-11-15 下午6:23:54
	 * 
	 */
	public class MoneyIconTextLabel extends MoneyBaseLabel
	{
		
		private var _icon:MoneyIcon;
		
		private var _label:MoneyTextLabel;
		
		private const GAP:int = 5;
		/**
		 * 需要消耗的数量 
		 */		
		private var _needNum:int;
		
		public function MoneyIconTextLabel()
		{
			super();
			_icon = new MoneyIcon();
			_label = new MoneyTextLabel();
			
			addChild(_icon);
			addChild(_label);
			
			this.mouseChildren = false;
		}
		
		override public function set iconId(value:int):void
		{
			super.iconId = value;
			_label.iconId = value;
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
		
		override public function set num(value:Number):void
		{
			super.num = value;
			_label.text = value + "";
			resize();
		}
		
		protected function onComplet(event:Event):void
		{
			_icon.removeEventListener(Event.COMPLETE,onComplet);
			resize();
		}
		
	}
}

