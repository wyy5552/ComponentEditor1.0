package com.gamehero.sxd2.gui.core.money
{
	import com.gamehero.sxd2.common.BitmapNumber;
	import com.gamehero.sxd2.gui.core.components.BitmapScrollNumber;
	
	
	/**
	 * icon + bitmapNumber
	 * @author weiyanyu
	 * 创建时间：2015-12-22 上午11:25:11
	 * 
	 */
	public class MoneyBitmapLabel extends MoneyBaseLabel
	{
		private var _icon:MoneyIcon;
		
		private var bitMapNumber:BitmapScrollNumber;
		
		public function MoneyBitmapLabel()
		{
			super();
			_icon = new MoneyIcon();
			bitMapNumber = new BitmapScrollNumber();
			bitMapNumber.type = BitmapNumber.Small_YELLOW;
			bitMapNumber.direction = BitmapScrollNumber.REVERSE;
			addChild(_icon);
			addChild(bitMapNumber);
			bitMapNumber.x = 26;
			
			this.mouseChildren = false;
			
		}
	
		override public function set iconId(value:int):void
		{
			super.iconId = value;
			if(_icon.iconId != value)
			{
				_icon.iconId = value;
			}
		}
		
		override public function set text(value:String):void
		{
			super.text = value;
			bitMapNumber.setNum(value,true);
			bitMapNumber.y = _icon.height - bitMapNumber.height >> 1;
		}
	}
}