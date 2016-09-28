package com.gamehero.sxd2.gui.core.tab
{
	import com.greensock.TweenMax;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * 配合TabBarOnlyTwo用
	 * @see TabBarOnlyTwo
	 * @author weiyanyu
	 * 创建时间：2016-3-2 下午4:00:54
	 * 
	 */
	public class TabBarOnlyTwoBtn extends ActTabBtn
	{
		public function TabBarOnlyTwoBtn(up:BitmapData, down:BitmapData=null, overBd:BitmapData=null, dis:BitmapData=null)
		{
			super(up, down, overBd, dis);
		}
		
		private var _tween:TweenMax;
		/**
		 * 隐现的时常 
		 */		
		public var tweenTime:Number = .5;
		override public function set selected(value:Boolean):void
		{
			//如果在没有完全隐藏的是偶再次切换页签，则此时visible会变成true;
			//但是endpanel1还没有执行到，过一会儿会设置面板为不可见
			if(_tween)
				_tween.kill();
			super.selected = value;
			Sprite(_panel).mouseEnabled = false;
			Sprite(_panel).mouseChildren = false;//动画的时候要禁止面板的鼠标，可能会有莫名其妙的错误
			//面板要 渐隐渐现
			if(_panel != null)//如果绑定了界面，则选中界面后初始化，切换后清除
			{
				if(value) 
				{
					DisplayObject(_panel).visible = true;
					DisplayObject(_panel).alpha = 0;//要有渐现的赶脚
					_tween = TweenMax.to(panel,tweenTime,{alpha:1,onComplete:endPanel});
					function endPanel():void
					{
						Sprite(_panel).mouseEnabled = true;
						Sprite(_panel).mouseChildren = true;
					}
				}
				else
				{
					DisplayObject(_panel).alpha = 1;
					_tween = TweenMax.to(panel,tweenTime,{alpha:0,onComplete:endPanel1});
					
					function endPanel1():void
					{
						DisplayObject(_panel).visible = false;
						Sprite(_panel).mouseEnabled = true;
						Sprite(_panel).mouseChildren = true;
					}
				}
			}
			if(value)
			{
				bmp.bitmapData = downBd == null ? upBd : downBd;
			}
			else
			{
				bmp.bitmapData = upBd;
			}
			
			hintBG3.x = bmp.bitmapData.width - 22;
		}
	}
}