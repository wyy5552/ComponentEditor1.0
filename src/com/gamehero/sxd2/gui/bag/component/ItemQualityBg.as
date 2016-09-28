package com.gamehero.sxd2.gui.bag.component
{
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	/**
	 * 道具品质底
	 * @author weiyanyu
	 * 创建时间：2015-12-3 下午1:50:59
	 * 
	 */
	public class ItemQualityBg extends Sprite
	{
		
		private const minAlpha:Number = .3;
		
		private const maxAlpha:Number = 1;
		/**
		 * 闪动时间 
		 */		
		private const flashTime:Number = .3;
		
		private var bg:Bitmap;
		
		private var tween:TweenMax;
		
		private var _qualityRes:Vector.<BitmapData>;
		
		public function ItemQualityBg()
		{
			super();
			bg = new Bitmap();
			addChild(bg);
		}
		
		public function set qualityBgRes(value:Vector.<BitmapData>):void{
			_qualityRes = value;
		}
		
		public function set quality(value:int):void
		{
			bg.bitmapData = _qualityRes[value];
			this.alpha = minAlpha;
		}
		
		public function over():void
		{
			onEnd();
			tween = TweenMax.to(this , flashTime , {alpha:maxAlpha , onComplete:onEnd});
		}
		
		public function out():void
		{
			onEnd();
			tween = TweenMax.to(this , flashTime , {alpha:minAlpha , onComplete:onEnd});
		}
		
		
		private function onEnd():void
		{
			if(tween) 
			{
				tween.kill();
				tween = null;
			}
		}
	}
}