package com.gamehero.sxd2.gui.theme.ifstheme.container.list
{
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import alternativa.gui.container.list.ListItemContainer;
	import alternativa.gui.event.ListEvent;

	/**
	 * 滚动条
	 * @author shenliangliang
	 * @E-mail: 971935832@qq.com
	 * 创建时间：2016-6-6 上午10:57:08
	 * 
	 */
	public class PageList extends List
	{
		//是否显示loading
		private var _showLoading:Boolean;
		//loading
		private var _loading:MovieClip;
		//缓动
		private var _tween:TweenLite;
		//需要请求
		private var _isProxy:Boolean = false;
		//当前页
		private var _currentPage:int;
		//最大页
		private var _maxPage:int;
		//内容 延时显示 隐藏
		private var  _duration:Number = 0.3;
		
		/**
		 *1、初始化后需调用initPage()方法；<br>
		 *2、帧听ListEvent.SCORLL_MAX 请求数据；<br>
		 *3、数据返回后再调用initPage()方法；
		 * @param showLoading 是否显示loading
		 * @param scrollBarType 滚动条类型
		 * @param scrollBarPosition 滚动条位置
		 * 
		 */		
		public function PageList(showLoading:Boolean = true,scrollBarType:int=0,scrollBarPosition:String = "right")
		{
			_showLoading = showLoading;
			
			super(scrollBarType,scrollBarPosition);
		}
		
		/**
		 *更新页码 <br>
		 * 当前页 等于 最大页 时不发出请求
		 * @param currentPage 当前页
		 * @param maxPage 最大页
		 * 
		 */		
		public function initPage(currentPage:int,maxPage:int):void
		{
			_currentPage = currentPage;
			_maxPage = maxPage;
			
			_isProxy = _currentPage != _maxPage;
			
			//移除
			removeLoading();
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */		
		override protected function changeScrollPosition(e:Event):void
		{
			// TODO Auto Generated method stub
			super.changeScrollPosition(e);
			
			updateLoading();
		}
		
		/**
		 *更新loading 显示 
		 * 
		 */		
		private function updateLoading():void
		{
			if(_scrollBar.scrollPosition == _scrollBar.maxScrollPosition)
			{
				if(_isProxy)
				{
					//显示loading
					_showLoading && addLoading();
					
					//请求数据
					_isProxy = false;
					dispatchEvent(new ListEvent(ListEvent.SCORLL_MAX,_currentPage));
				}
			}
			else
			{
				removeLoading();
			}	
		}
		
		/**
		 *添加loading 
		 * 
		 */		
		private function addLoading():void
		{
			if(_loading)
			{
				removeLoading();	
			}
			_tween && _tween.kill();
			_tween = TweenLite.to((container as DisplayObject),_duration,{alpha:0.1});
			
			_loading = new MainSkin.iconLoadingClass();
			_loading.play();
			_loading.x = width >> 1
			_loading.y = height >> 1;
			addChild(_loading);
		}
		
		/**
		 *移出loading 
		 * 
		 */		
		public function removeLoading():void
		{
			if(_loading)
			{
				_loading.stop();
				contains(_loading) && removeChild(_loading);
				_loading = null;
				
				_tween && _tween.kill();
				_tween = TweenLite.to((container as DisplayObject), _duration, {alpha:1});
			}
		}
		
		override protected function draw():void
		{
			// TODO Auto Generated method stub
			super.draw();
			
			if(_scrollBar)
			{
				if(_scrollBar.scrollPosition != _scrollBar.maxScrollPosition)
				{
					removeLoading();
				}
			}
		}

		/**
		 *显示隐藏延时 
		 * @param value
		 * 
		 */		
		public function set duration(value:Number):void
		{
			_duration = value;
		}

		
		/**
		 * 列数
		 * @param value
		 * 
		 */
		public function set col(value:int):void
		{
			(_container as ListItemContainer).col = value;
		}
		
		
		/**
		 * @return 列数
		 * 
		 */
		public function get col():int
		{
			return (_container as ListItemContainer).col;
		}

		
		/**
		 *水平间距 
		 * @return 
		 * 
		 */		
		public function get gapX():int
		{
			return (_container as ListItemContainer).gapX;
		}
		
		
		/**
		 *水平间距 
		 * @param value
		 * 
		 */		
		public function set gapX(value:int):void
		{
			(_container as ListItemContainer).gapX = value;
		}
		
		/**
		 *remoteData 
		 * @param e
		 * 
		 */		
		override public function update(e:Event=null):void
		{
			// TODO Auto Generated method stub
			super.update(e);
			
			removeLoading();
		}
		
		/**
		*清理 
		* 
		*/		
		public function clear():void
		{
			dataProvider.removeAll();
			removeLoading();
		}
	}
}