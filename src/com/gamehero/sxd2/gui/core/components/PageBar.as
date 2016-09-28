package com.gamehero.sxd2.gui.core.components
{
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.SButton;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	import alternativa.gui.enum.Align;
	import alternativa.gui.event.ListEvent;
	
	/**
	 * 首页/上一页/下一页/末页
	 * 在首页点击上一页，页数没变，但希望刷新数据。所以，只要点击按钮，不管页数有没有变化，都会抛ListEvent.LIST_CHANGE事件
	 * clear方法会移除所有按钮的点击事件，需要调用onActive方法添加
	 * @author cuixu
	 * @create：2016-8-5
	 **/
	public class PageBar extends Sprite
	{
		private static const MIN_PAGE:int = 1;//起始页为第1页
		private var TEXT_FILTER:GlowFilter = new GlowFilter(GameDictionary.FATA_STROKE, 1, 2, 2, 8);//文本字体描边
		
		private var _firstPageBtn:SButton;//首页
		private var _endPageBtn:SButton;//末页
		private var _prePageBtn:SButton;//上一页
		private var _nextPageBtn:SButton;//下一页
		private var _pageLab:Label;//当前页/最大页：1/100
		
		private var _curPage:int = 1;//当前页
		private var _maxPage:int = 1;//最大页
		
		public function PageBar()
		{
			super();
			initUI();
		}
		
		private function initUI():void{
			_firstPageBtn = new SButton(CommonSkin.getClass("sPanelBtn") as SimpleButton,"首页");
			_endPageBtn = new SButton(CommonSkin.getClass("sPanelBtn") as SimpleButton,"末页");
			_prePageBtn = new SButton(CommonSkin.getClass("panelBtn") as SimpleButton,"上一页");
			_nextPageBtn = new SButton(CommonSkin.getClass("panelBtn") as SimpleButton,"下一页");
			_pageLab = new Label();
			addChild(_firstPageBtn);
			_prePageBtn.x = 53;
			addChild(_prePageBtn);
			_pageLab.x = 132;
			_pageLab.y = 3;
			_pageLab.width = 70;
			_pageLab.align = Align.CENTER;
			_pageLab.color = GameDictionary.WHITE;
			_pageLab.filters = [TEXT_FILTER];
			addChild(_pageLab);
			_nextPageBtn.x = 202;
			addChild(_nextPageBtn);
			_endPageBtn.x = 291;
			addChild(_endPageBtn);
		}
		
		/**
		 * 添加按钮点击事件的侦听
		 * 
		 */
		public function onActive():void{
			_firstPageBtn.addEventListener(MouseEvent.CLICK,firstHandler);
			_endPageBtn.addEventListener(MouseEvent.CLICK,endHandler);
			_prePageBtn.addEventListener(MouseEvent.CLICK,preHandler);
			_nextPageBtn.addEventListener(MouseEvent.CLICK,nextHandler);
		}
		
		public function get curPage():int{
			return _curPage;
		}
		
		public function get maxPage():int{
			return _maxPage;
		}
		
		public function set curPage(value:int):void{
			var valiPage:int = int(Math.min(Math.max(MIN_PAGE,value),_maxPage));
			_curPage = valiPage;
			updateLab();
		}
		
		public function set maxPage(value:int):void{
			_maxPage = value;
			if(_curPage > _maxPage){//如果curPage比maxPage小，则将curPage=maxPage
				curPage = _maxPage;
			}
			updateLab();
		}
		
		/**
		 * 更新当前页和最大页，不会触发LIST_CHANGE事件
		 * @param cur
		 * @param max
		 * 
		 */
		public function updatePage(cur:int,max:int):void{
			if(cur > max){
				cur = max;
			}
			_maxPage = max;
			curPage = cur;
		}
		
		private function updateLab():void{
			_pageLab.text = _curPage + "/" + _maxPage;
		}
		
		private function firstHandler(e:MouseEvent):void{
			curPage = MIN_PAGE;
			dispatchEvent(new ListEvent(ListEvent.LIST_CHANGE));
		}
		
		private function endHandler(e:MouseEvent):void{
			curPage = _maxPage;
			dispatchEvent(new ListEvent(ListEvent.LIST_CHANGE));
		}
		
		private function preHandler(e:MouseEvent):void{
			curPage = _curPage - 1;
			dispatchEvent(new ListEvent(ListEvent.LIST_CHANGE));
		}
		
		private function nextHandler(e:MouseEvent):void{
			curPage = _curPage + 1;
			dispatchEvent(new ListEvent(ListEvent.LIST_CHANGE));
		}
		
		public function clear():void{
			_curPage = 1;
			_maxPage = 1;
			_pageLab.text = "";
			_firstPageBtn.removeEventListener(MouseEvent.CLICK,firstHandler);
			_endPageBtn.removeEventListener(MouseEvent.CLICK,endHandler);
			_prePageBtn.removeEventListener(MouseEvent.CLICK,preHandler);
			_nextPageBtn.removeEventListener(MouseEvent.CLICK,nextHandler);
		}
	}
}