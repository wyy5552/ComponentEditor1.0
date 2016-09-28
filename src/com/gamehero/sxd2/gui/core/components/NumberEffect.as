package com.gamehero.sxd2.gui.core.components
{
	import com.gamehero.sxd2.common.BitmapNumber;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	
	/**
	 * 简单的动画数字,红绿闪动<br>(见左上角元宝跟铜钱动画)
	 * @author weiyanyu
	 * 创建时间：2015-12-22 下午2:49:59
	 * 
	 */
	public class NumberEffect extends Sprite
	{
		
		private var type:String;
		/**
		 * 最终显示的数字 
		 */		
		private var bmpNum:BitmapNumber;
		/**
		 * 文字 
		 */		
		private var _num:String;
		
		
		
		/**
		 * 动态跳动效果 
		 */
		private var bmpNumDynamic:BitmapNumber;
		/**
		 * 当前跳动的数字 
		 */		
		private var dynamicNum:int;
		/**
		 * 模糊滤镜 
		 */		
		private var bf:BlurFilter =new BlurFilter(0,6,BitmapFilterQuality.LOW);
		
		public function NumberEffect(typ:String = "")
		{
			super();
			if(typ == "" || typ == null)
			{
				this.type = BitmapNumber.WINDOW_S_YELLOW;
			}
			else
			{
				this.type = typ;
			}
			
			bmpNum = new BitmapNumber(type);
			
			bmpNumDynamic = new BitmapNumber(type);
			bmpNumDynamic.filters = [bf];
			
			addChild(this.bmpNum);
		}
		
		public function get num():String
		{
			return _num;
		}

		public function set num(value:String):void
		{
			_num = value;
			bmpNum.update(type, _num);
		}
		
		public function play():void
		{
			if(contains(bmpNum)) {
				
				removeChild(bmpNum);
			}
			addChild(bmpNumDynamic);
			bmpNumDynamic.update(BitmapNumber.Small_YELLOW,dynamicNum.toString());
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void {
			bmpNumDynamic.update(BitmapNumber.Small_YELLOW,(++dynamicNum).toString());
			if(dynamicNum >= 9) {
				dynamicNum = 0;
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				addChild(bmpNum);
				removeChild(bmpNumDynamic);
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
	}
}