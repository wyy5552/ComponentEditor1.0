package com.gamehero.sxd2.gui.bag.component
{
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ItemSkin;
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import bowser.utils.time.TimeTick;
	
	/**
	 * 时效框框
	 * @author weiyanyu
	 * 创建时间：2016-6-24 下午4:03:37
	 * 
	 */
	public class ItemTimeliness extends Sprite
	{
		private var _flash:Bitmap;
		private var _canIcon:Bitmap;
		private var _notIcon:Bitmap;
		
		private var tween:TweenMax;
		
		private var size:int;
		
		private var _outTime:Number = 0;
		
		private var _alphaStep:Number = -.1;
		/**
		 * 时限道具警示提示优化：道具时长<30min,出现警示特效
		 * @see http://10.1.29.87:8080/browse/SXD-5338
		 */		
		private var lostTime:int = 1800;//30 * 60;
		
		public function ItemTimeliness(size:int = 46)
		{
			super();
			this.size = size;
			mouseEnabled = false;
		}
		/**
		 * 设置到期时间戳 
		 * @param value
		 * 
		 */		
		public function set outTime(value:Number):void
		{
			_outTime = value;	
			if(value == 0)return;
			timeOut = getIsTimeOut(value);
		}
		private function set timeOut(value:Boolean):void
		{
			if(value)
			{
				removeEventListener(Event.ENTER_FRAME,onFrame);
				clearItem(_flash);
				clearItem(_canIcon);
				_notIcon = new Bitmap(ItemSkin.BagTime_notuse);
				addChild(_notIcon);
				_notIcon.x = size - _notIcon.width;
			}
			else
			{
				clearItem(_notIcon);
				_flash = new Bitmap(ItemSkin.BagTime_flash);
				addChild(_flash);
				_flash.visible = false;
				_canIcon = new Bitmap(ItemSkin.BagTime_canuse);
				addChild(_canIcon);
				_canIcon.x = size - _canIcon.width;
				addEventListener(Event.ENTER_FRAME,onFrame);
			}
		}
		
		private function getIsTimeOut(value:Number):Boolean
		{
			return value <= TimeTick.inst.getCurrentTime2();
		}
		
		protected function onFrame(event:Event):void
		{
			if(getIsTimeOut(_outTime))
			{
				timeOut = true;
			}
			else
			{
				var lt:int = _outTime - TimeTick.inst.getCurrentTime2();
				if(lt < lostTime)//道具时长<30min,出现警示特效
				{
					_flash.visible = true;
					_flash.alpha += _alphaStep;
					if(_flash.alpha < 0)
					{
						_alphaStep = .1;
					}
					else if(_flash.alpha >= 1)
					{
						_alphaStep = -.1;
					}
				}
			}
		}
		
		public function clear():void
		{
			clearItem(_flash);
			clearItem(_canIcon);
			clearItem(_notIcon);
			removeEventListener(Event.ENTER_FRAME,onFrame);
		}
		
		private function clearItem(ds:DisplayObject):void
		{
			if(ds && ds.parent)
			{
				ds.parent.removeChild(ds);
				ds = null;
			}
		}
	}
}