package com.gamehero.sxd2.gui.core.components
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import alternativa.gui.base.ActiveObject;
	
	/**
	 * 可以滚动的数字
	 * @author weiyanyu
	 * 创建时间：2015-12-22 下午2:20:08
	 * 
	 */
	public class BitmapScrollNumber extends ActiveObject
	{
		
		private var _num:String;
		/**
		 * 数字样式 
		 */		
		private var _type:String;
		
		private var _gap:int;
		
		private var _effects:Vector.<NumberEffect>;
		
		private var _cacheEffects:Vector.<NumberEffect>;
		
		private var _direction:int = FORWARD;
		/**
		 * 游标位置 
		 */		
		private var vernier:int;
		
		/**
		 * 正向播放 
		 */		
		public static var FORWARD:int = 1;
		/**
		 * 反向播放 
		 */		
		public static var REVERSE:int = 2;
		
		
		public function BitmapScrollNumber()
		{
			super();
			
			_effects = new Vector.<NumberEffect>();
			
			_cacheEffects = new Vector.<NumberEffect>();
			
			mouseChildren = false;
		}
		
		/**
		 * 播放动画的方向，正向1，逆向2,默认正向
		 */
		public function get direction():int
		{
			return _direction;
		}

		/**
		 * @private
		 */
		public function set direction(value:int):void
		{
			_direction = value;
		}

		public function get gap():int
		{
			return _gap;
		}

		public function set gap(value:int):void
		{
			_gap = value;
		}

		public function set type(value:String):void
		{
			_type = value;
		}
		/**
		 * 设置新值，并且设置是否要播放特效 
		 * @param value
		 * @param needPlay
		 * 
		 */		
		public function setNum(value:String,needPlay:Boolean = false):void
		{
			if(value == _num) return;
			_num = value;
			var oneNumEffect:NumberEffect;
			for (var i:int = 0; i < _effects.length; i++)//移除掉之前设置的，因为数字的长度可能会变化
			{
				oneNumEffect = _effects[i];
				removeChild(oneNumEffect);
				if(oneNumEffect.hasEventListener(Event.COMPLETE))
					oneNumEffect.removeEventListener(Event.COMPLETE,onPlay);
				_cacheEffects.push(oneNumEffect);//推入缓存
			}
			_effects.length = 0;
			
			var length:int = value.toString().length;
			var pre:DisplayObject;//因为数字宽不一致，所以数字组合并不是等分宽度。
			var w:int;
			for (i = 0; i < length; i++)//创建新的数字组合
			{
				oneNumEffect = getNumEffect();
				oneNumEffect.num = value.toString().substr(i, 1);
				if(i == 0)
				{
					oneNumEffect.x = 0;
				}
				else
				{
					oneNumEffect.x = pre.x + pre.width + gap;//因为数字宽不一致，所以数字组合并不是等分宽度。
				}
				w += oneNumEffect.width + gap;
				addChild(oneNumEffect);
				_effects.push(oneNumEffect);
				pre = oneNumEffect;
				if(needPlay)
					oneNumEffect.addEventListener(Event.COMPLETE,onPlay);
			}
			width = w;
			height = pre.height;
			if(needPlay)
			{
				if(direction == FORWARD)
				{
					vernier = 0;//游标从第一个数字开始放
				}
				else
				{
					vernier = _effects.length - 1;//倒着播放动画
				}
				play();
			}

		}
		
		public function get num():int
		{
			return num;
		}
		
		
		private function getNumEffect():NumberEffect 
		{
			if(_cacheEffects.length > 0)
			{
				return _cacheEffects.pop();
			}
			return  new NumberEffect(_type);
		}
		
		//一个一个的播放数字
		protected function onPlay(event:Event):void
		{
			if(direction == FORWARD)
			{
				if(vernier < _effects.length)
				{
					play();
				}
				else
				{
					clearEvent();
				}
			}
			else
			{
				if(vernier > -1)
				{
					play();
				}
				else
				{
					clearEvent();
				}
			}
		}
		
		private function play():void
		{
			if(direction == FORWARD)
			{
				_effects[vernier++].play();
			}
			else
			{
				_effects[vernier--].play();
			}
		}
		
		public function clearEvent():void
		{
			var length:int = _effects.length;
			var oneNumEffect:NumberEffect;
			var i:int;
			for (i = 0; i < length; i++)//创建新的数字组合
			{
				oneNumEffect = _effects[i];
				oneNumEffect.removeEventListener(Event.COMPLETE,onPlay);
			}
		}
		
		public function clear():void
		{
			
		}
		
		
	}
}