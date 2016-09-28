package com.gamehero.sxd2.gui.core.money
{
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ItemSkin;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.ui.MouseCursor;
	
	import bowser.utils.MovieClipPlayer;
	
	/**
	 * label 闪动动画,绿色或者红色的闪动
	 * @author weiyanyu
	 * 创建时间：2015-12-17 下午5:30:07
	 * 
	 */
	public class MoneyFlashLabel extends MoneyBaseLabel
	{
		/**
		 * 绿色闪动 
		 */		
		public static var ADDED:int = 1;
		/**
		 * 红色闪动 
		 */		 
		public static var DEDUCT:int = 2;
		
		private var _icon:MoneyIcon;
		private var _tf:TextField;
		private var money:MovieClip;
		
		private var _mp:MovieClipPlayer;
		
		public function MoneyFlashLabel()
		{
			super();
			
			money = new ItemSkin.GOLD_FLASH() as MovieClip;
			addChild(money);
			_tf = money.num.label as TextField;
			//			GameDictionary.setTfDefaultFontName(_tf);
			
			_icon = new MoneyIcon();
			DisplayObjectContainer(money.icon).addChild(_icon);
			
			_mp = new MovieClipPlayer();
			
			this.cursorType = MouseCursor.ARROW;
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
		
		override public function set num(value:Number):void
		{
			super.num = value;
			_tf.text = GameDictionary.formatMoney(_num);
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
					_mp.play(money , money.totalFrames/48 , 17 , money.totalFrames,time);
					_mp.addEventListener(Event.COMPLETE , playOver);
					break;
				case DEDUCT:
					_mp.play(money , money.totalFrames/48 , 1 , 17,time);
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