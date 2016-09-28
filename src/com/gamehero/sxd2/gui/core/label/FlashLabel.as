package com.gamehero.sxd2.gui.core.label
{
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ItemSkin;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.ui.MouseCursor;
	
	import bowser.utils.MovieClipPlayer;

	/**
	 * label 闪动动画,绿色或者红色的闪动
	 * @author cuixu
	 * @create：2016-4-14
	 **/
	public class FlashLabel extends ActiveLabel
	{
		/**
		 * 绿色闪动 
		 */		
		public static var ADDED:int = 1;
		/**
		 * 红色闪动 
		 */		 
		public static var DEDUCT:int = 2;
		
		protected var _mc:MovieClip;
		protected var _tf:TextField;
		protected var _mp:MovieClipPlayer;
		
		public function FlashLabel()
		{
			super();
			_mc = new ItemSkin.LABEL_FLASH() as MovieClip;
			addChild(_mc);
			_tf = _mc.num.label as TextField;
			//GameDictionary.setTfDefaultFontName(_tf);
			_mp = new MovieClipPlayer();
			this.cursorType = MouseCursor.ARROW;
			this.mouseChildren = false;
		}
		
		public function set text(value:String):void
		{
			_tf.text = value;
		}
		
		override public function get width():Number {
			return _tf.textWidth;
		}
		
		/**
		 *  
		 * @param type 播放特效类型
		 * @param time 播放次数
		 * 
		 */		
		public function play(type:int = 1,time:int = 1):void
		{
			switch(type)
			{
				case ADDED:
					_mp.play(_mc , _mc.totalFrames/48 , 17 , _mc.totalFrames,time);
					_mp.addEventListener(Event.COMPLETE , playOver);
					break;
				case DEDUCT:
					_mp.play(_mc , _mc.totalFrames/48 , 1 , 17,time);
					_mp.addEventListener(Event.COMPLETE , playOver);
					break;
			}
		}
		
		protected function playOver(event:Event):void
		{
			_mp.removeEventListener(Event.COMPLETE , playOver);
		}
	}
}