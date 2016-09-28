package com.gamehero.sxd2.gui.core.components
{
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import bowser.utils.MovieClipPlayer;
	
	/**
	 * 一次播放完的mc
	 * @author weiyanyu
	 * 创建时间：2016-9-6 下午9:26:59
	 */
	public class MoviePlayOnce extends Sprite
	{
		protected var mc:MovieClip;
		protected var mp:MovieClipPlayer;
		/**
		 * 是否自动设置显隐 
		 */		
		protected var isAutoVisible:Boolean;
		
		public function MoviePlayOnce(mc:MovieClip,autoVisible:Boolean = true)
		{
			super();
			this.mc = mc;
			addChild(mc);
			mc.gotoAndStop(1);
			mp = new MovieClipPlayer();

			isAutoVisible = autoVisible;
			if(isAutoVisible)
			{
				mc.visible = false;
			}
		}
		
		public function play():void
		{
			clear();
			if(isAutoVisible)
			{
				mc.visible = true;
			}
			mp.play(mc,mc.totalFrames/ 24 ,1,mc.totalFrames);
			mp.addEventListener(Event.COMPLETE , playOvered);
		}
		protected function playOvered(e:Event):void
		{
			clear();
			dispatchEvent(new Event(Event.COMPLETE));
		}
		public function clear():void
		{
			mp.removeEventListener(Event.COMPLETE , playOvered);
			mc.gotoAndStop(1);
			if(isAutoVisible)
			{
				mc.visible = false;
			}
			
		}
	}
}