package com.gamehero.sxd2.gui.theme.ifstheme.controls.progressBar
{
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import alternativa.gui.base.ActiveObject;
	import alternativa.gui.enum.Align;
	import alternativa.gui.mouse.CursorManager;
	
	import bowser.utils.MovieClipPlayer;
	
	/**
	 * @author shenliangliang
	 * @E-mail: 971935832@qq.com
	 * 创建时间：2016-6-28 下午4:21:52
	 * 
	 */
	public class ProgressBar extends ActiveObject
	{
		protected var _barDictory:Dictionary;
		/**
		 * 当前播放的进度条 
		 */		
		private var _mc:MovieClip;
		/**
		 * 进度条索引 
		 */		
		private var _prelv:int = -1;
		
		private var _lab:Label;
		
		/**
		 * 最大值 
		 */		
		private var _max:int;
		
		
		private var mp:MovieClipPlayer;
		private const maxFrame:int = 100;
		/**
		 * 帧频的倍数，越大越快 
		 */		
		private const speed:int = 72;//
		
		/**
		 * 
		 * @param mcList
		 * 
		 */		
		public function ProgressBar(mcList:Vector.<MovieClip>, active:Boolean = false, showLab:Boolean = true)
		{
			super();
			
			_barDictory = new Dictionary(mcList);
			//进度条
			for (var i:int = 0; i < mcList.length; i++) 
			{
				var mc:MovieClip = mcList[i];
				mc.bar.gotoAndStop(0);
				addChild(mc);
				mc.visible = false;
				if(mc.bar)
				{
					mc.bar.stop();
				}
				
				_barDictory[i] = mc;
			}
			
			if(showLab)
			{
				_lab = new Label(false);
				_lab.align = Align.CENTER;
				
				if(mc.bg)
				{
					_lab.width = mc.bg.width;
					_lab.y = mc.bg.height - _lab.size >> 1;
				}
				else
				{
					_lab.width = mc.width;
				}
				label = 0;
				_lab.fontFilter = true;
				addChild(_lab);
				_lab.visible = !active;
			}
			
			mp = new MovieClipPlayer();
			
			cursorActive = active;
		}
		
		override public function set out(value:Boolean):void
		{
			// TODO Auto Generated method stub
			super.out = value;
			
			if(value)
			{
				if(_lab)
					_lab.visible = false;
				CursorManager.cursorType = CursorManager.ARROW;
			}
		}
		
		override public function set over(value:Boolean):void
		{
			// TODO Auto Generated method stub
			super.over = value;
			
			if(value)
			{
				if(_lab)
					_lab.visible = true;
				CursorManager.cursorType = CursorManager.BUTTON;
			}
		}
		
		override public function get cursorType():String
		{
			// TODO Auto Generated method stub
			return CursorManager.ARROW;
		}
		
		
		private function showMcByKey(key:int):void
		{
			_mc = _barDictory[key];
			if(_mc)
			{
				_mc.visible = true;
				for each (var mc:MovieClip in _barDictory) 
				{
					//不是需要显示的隐藏
					if(_mc != mc)
					{
						mc.visible = false;
					}
				}
			}
		}
		
		
		/**
		 * @param lv 最小0
		 * @param value 当前值
		 * @param max 最大值
		 * 
		 */		
		public function update(lv:int,value:int,max:int):void
		{
			var percent:int = Math.ceil(Number(value / max) * maxFrame);//当前进度
			percent = Math.max(percent,1);//如果value是0，则percent取1
			_max = max;
			label = value;
			if(_mc == null)//第一次设置进度，不播放动画
			{
				showMcByKey(lv);//设置最新的
				bar.gotoAndStop(percent);
			}
			else
			{
				if(_prelv != lv)//如果等级变化了
				{
					playNext(percent,lv);
				}
				else//如果等级没变，则只需要设置新的进度
				{
					if(percent == bar.currentFrame)//如果进度没有变化
					{
						return;
					}
					else if(percent > bar.currentFrame)//进度增加
					{
						mp.play(bar,(percent - bar.currentFrame) / speed,bar.currentFrame,percent);
					}
					else
					{
						playNext(percent,lv);
					}
					
				}
			}
			_prelv = lv;
		}
		/**
		 * 播放完当前的，然后设置最新的 
		 * @param end
		 * @param lv
		 * 
		 */		
		private function playNext(end:int,lv:int):void
		{
			mp.play(bar,(bar.totalFrames - bar.currentFrame) / speed,bar.currentFrame,bar.totalFrames);//播放当前
			mp.addEventListener(Event.COMPLETE,onChange);
			function onChange(event:Event):void
			{
				showMcByKey(lv);//设置最新的
				mp.removeEventListener(Event.COMPLETE,onChange);
				mp.play(bar,end / speed,0,end);//设置新的进度
			}
		}
		
		public function get bar():MovieClip
		{
			return _mc.bar;
		}
		
		/**
		 * 
		 * @param cur
		 * 
		 */		
		public function set label(cur:uint):void
		{
			if(_lab)
				_lab.text = cur + "/" + _max;
		}
		
		/**
		 *设置颜色 
		 * @param value
		 * 
		 */		
		public function set color(value:uint):void
		{
			_lab.color = value;
		}
		
		/**
		 *清除 
		 * 
		 */		
		public function clear():void
		{
			_mc = null;
		}
	}
}