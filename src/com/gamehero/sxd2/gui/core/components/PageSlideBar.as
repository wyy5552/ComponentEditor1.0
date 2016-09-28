package com.gamehero.sxd2.gui.core.components
{
	import com.gamehero.sxd2.gui.core.group.ItemRender;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.greensock.TweenMax;
	import com.greensock.data.TweenMaxVars;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import alternativa.gui.base.GUIobject;
	import alternativa.gui.mouse.CursorManager;
	
	/**
	 * 滑动切页 页码动态，不确定条数，区别于ToggleBar
	 * @author shenliangliang
	 * @E-mail: 971935832@qq.com
	 * 创建时间：2016年6月17日 16:44:46
	 * 
	 */
	public class PageSlideBar extends GUIobject
	{
		private var _leftBtn:Button;
		private var _rightBtn:Button;
		private var _itemHideArray:Array;
		private var _itemShowArray:Array;
		
		private var _data:Array;
		//每条
		private var _itemWidth:Number = 0;
		
		private var _itemHeight:Number = 0;
		
		//当前页
		private var _currentPage:int = 1;
		//最大页
		private var _maxPage:int;
		
		//显示数量
		private var _showNum:int;
		//cell容器
		private var _container:Sprite;
		//
		private var itemRender:Class;
		
		private var _padding:Number = 3;
		
		//内容 延时显示 隐藏
		private var  _duration:Number = 0.5;
		
		private var _totalWidth:Number = 0;
		
		private var _tweenList:Array;
		
		public function PageSlideBar(render:Class ,upbd:BitmapData,downbd:BitmapData = null,overbd:BitmapData = null,showNum:int = 1)
		{
			super();
			
			_showNum = showNum;
			itemRender = render;
			
			_leftBtn = new Button(upbd, downbd, overbd);
			_rightBtn = new Button(upbd, downbd, overbd);
			_rightBtn.scaleX = -1;
			_leftBtn.locked = _rightBtn.locked = true;
			
			init();
		}
		
		private function init():void
		{
			// TODO Auto Generated method stub
			_itemShowArray = new Array();
			_itemHideArray = new Array();
			
			_leftBtn.x = 0;
			
			_container = new Sprite();
			addChild(_container);
			_container.x = _leftBtn.width + _padding;
			addChild(_leftBtn);
			addChild(_rightBtn);
			
			
			for (var i:int = 0; i < _showNum * 2; i++) 
			{
				var item:ItemRender = new itemRender();
				_container.addChild(item);
				item.x = i * (item.width + _padding);
				if(_itemWidth <= 0)
				{
					_itemWidth = item.width;
					_itemHeight = item.height;
				}
				//
				if(i < _showNum)
				{
					_itemShowArray.push(item);
				}
				else
				{
					_itemHideArray.push(item);
				}
			}
			_container.scrollRect = new Rectangle(
				0,0,
				(_itemWidth + _padding) * _showNum,_itemHeight);
			
			_totalWidth = (_itemWidth + _padding) * _showNum + _padding + _leftBtn.width * 2;
			_rightBtn.x = _totalWidth;
		}
		
		/**
		 *更新页码 <br>
		 * 当前页 等于 最大页 时不发出请求
		 * @param currentPage 当前页
		 * @param maxPage 最大页
		 * 
		 */		
		public function initPage(curPage:int,maxPage:int,data:Array):void
		{
			_data = data;
			
			var i:int = 0;
			curPage = Math.max(curPage,1);
			maxPage = Math.max(maxPage,1);
			//killall
			if(_tweenList && _tweenList.length > 0)
			{
				for (var j:int = 0; j < _tweenList.length; j++) 
				{
					var tween:TweenMax = _tweenList[j];
					tween.kill();
				}
			}
			//向左滑动
			if(_currentPage > curPage)
			{
				for (i = 0; i < _itemHideArray.length; i++) 
				{
					_itemHideArray[i].data = i >= data.length ?null : data[i];
					_itemHideArray[i].x = 0 - (_itemWidth + _padding) * (_showNum - i);
				}
				
				_tweenList = TweenMax.staggerTo(_itemHideArray.concat(_itemShowArray),_duration,{x:"+"+_showNum * (_itemWidth + _padding)},0,complete);
			}
			//向右滑动
			else if(_currentPage < curPage)
			{
				for (i = 0; i < _itemHideArray.length; i++) 
				{
					_itemHideArray[i].data = i >= data.length ?null : data[i];
					_itemHideArray[i].x = _showNum * (_itemWidth + _padding) + (_itemWidth + _padding) * (i);
				}
				
				_tweenList = TweenMax.staggerTo(_itemShowArray.concat(_itemHideArray),_duration,{x:"-"+_showNum * (_itemWidth + _padding)},0,complete);
			}
			else
			{
				for (i = 0; i < _itemShowArray.length; i++) 
				{
					_itemShowArray[i].data = i >= data.length ?null : data[i];
					_itemShowArray[i].x = (_itemWidth + _padding) * (i);
				}
				
				for (i = 0; i < _itemHideArray.length; i++) 
				{
					_itemHideArray[i].data = i >= data.length ?null : data[i];
					_itemHideArray[i].x = (_itemWidth + _padding) * (i) + _showNum * (_itemWidth + _padding);
				}
			}
			
			function complete():void
			{
				var temp:Array = _itemHideArray.concat();
				_itemHideArray = _itemShowArray.concat();
				_itemShowArray = temp;
			}
			
			//页码
			if(curPage <= 1)
			{
				curPage = 1;
				_leftBtn.locked = true;
			}
			else
			{
				_leftBtn.locked = false;
			}
			
			if(curPage >= maxPage)
			{
				curPage = maxPage;
				_rightBtn.locked = true;
			}
			else
			{
				_rightBtn.locked = false;
			}
			
			_currentPage = curPage;
			_maxPage = maxPage;
		}

		public function set padding(value:Number):void
		{
			_padding = value;
		}

		public function get leftBtn():Button
		{
			return _leftBtn;
		}

		public function get rightBtn():Button
		{
			return _rightBtn;
		}

		public function get currentPage():int
		{
			return _currentPage;
		}

		/**
		 * 数据清理
		 * 
		 */		
		public function clear():void
		{
			var items:Array = _itemShowArray.concat(_itemHideArray);
			for (var i:int = 0; i < items.length; i++) 
			{
				items[i].data = null;
			}
			
		}

	}
}