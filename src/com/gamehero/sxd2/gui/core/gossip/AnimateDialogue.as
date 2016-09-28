package com.gamehero.sxd2.gui.core.gossip
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	
	import flash.display.DisplayObject;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;

	/**
	 * 
	 * 弹出->显示n秒->隐藏<br>
	 * @see GossipPop
	 * @author weiyanyu
	 * 创建时间：2016-9-5 18:42:29
	 */
	public class AnimateDialogue
	{
		
		public function AnimateDialogue(sp:DisplayObject,duration:Number = 1,showTime:Number = 3,delayTime:Number = 15)
		{
			this.sp = sp;
			this.duration = duration;
			this.showTime = showTime;
			this.delayTime = delayTime;
			init();
		}
		private var tween:TweenLite;
		
		private var sp:DisplayObject;
		/**
		 * 弹出用时 
		 */		
		private var duration:Number = 1;
		/**
		 * 展示时间（秒数） 
		 */		
		private var showTime:Number = 3;
		/**
		 * 沉寂的时间 
		 */		
		private var delayTime:Number = 10;
		
		private var interItemId:uint;
		
		private var callback:Function;
		
		/**
		 * 开始动画前要设置基本参数，不设置就出错； 
		 */		
		public function start(fun:Function):void
		{
			if(interItemId == 0)
			{
				interItemId = setInterval(start,delayTime * 1000,callback);
			}
			callback = fun;
			tween = TweenLite.to(sp, duration, {scaleX:1, scaleY:1, alpha:1, ease:Back.easeOut,onComplete:onReset});
		}
		//从小变大
		private function onReset():void
		{
			tween = TweenLite.to(sp, duration, {scaleX:.1, scaleY:.1,delay:showTime, alpha:0, ease:Back.easeIn,onComplete:onEnd});
		}
		
		private function onEnd():void
		{
			if(callback)
				callback();
//			start(callback);
		}
		
		public function init():void
		{
			clear();
			sp.scaleX = sp.scaleY = .1;
			sp.alpha = 0;
		}
		
		public function clear():void
		{
			if(tween != null)
			{
				tween.kill();
				tween = null;
			}
			
			if(interItemId > 0)
			{
				clearInterval(interItemId);
				interItemId = 0;
			}
		}
		
		
	}
}