package com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons {
	
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	
	import alternativa.gui.base.GUIobject;
	import alternativa.gui.enum.Align;
	
	
	/**
	 * 翻页按钮组件 
	 * @author Trey
	 * @create-date 2013-11-7
	 */
	public class PageButton extends GUIobject {
		
		private var _prePageButton:Button;
		private var _nextPageButton:Button;
		private var _maxPageButton:Button;
		private var _minPageButton:Button;
		private var _pageLabel:Label;
		
		private var _curPage:int = 1; //当前页
		private var _maxPage:int = 1;	 // 总页数
		
		private const OFFSET_X:Number = 3;
		private const OFFSET_Y:Number = 3;//


		private var _turnCallBack:Function;
		
		
		/**
		 * Constructor 
		 * 
		 */
		public function PageButton() {
			
			_minPageButton = new Button(CommonSkin.MinStepper_Up,CommonSkin.MinStepper_Down,CommonSkin.MinStepper_Over,CommonSkin.MinStepper_Up);
			_minPageButton.addEventListener(MouseEvent.CLICK , onTurnPage);
			_minPageButton.x = 0;
			_minPageButton.y = 0;
			addChild(_minPageButton);
			
			_prePageButton = new Button(CommonSkin.LeftStepper_Up,CommonSkin.LeftStepper_Down,CommonSkin.LeftStepper_Over,CommonSkin.LeftStepper_Up);
			_prePageButton.addEventListener(MouseEvent.CLICK , onTurnPage);
			_prePageButton.x = _minPageButton.width + OFFSET_X;
			_prePageButton.y = 0;
			addChild(_prePageButton);
			
			var bmp:Bitmap = new Bitmap(CommonSkin.NUMBER_INPUT_BG);//资源宽高是26*15
			addChild(bmp);
			bmp.width = 40;
			bmp.x = _prePageButton.x + _prePageButton.width + OFFSET_X;
			
			_pageLabel = new Label();
			_pageLabel.text = "1/1";
			_pageLabel.align = Align.CENTER;
			_pageLabel.color = GameDictionary.GRAY;
			_pageLabel.width = bmp.width;
			_pageLabel.x = bmp.x;
			_pageLabel.y = OFFSET_Y ;
			addChild(_pageLabel);
			
			_nextPageButton = new Button(CommonSkin.RightStepper_Up,CommonSkin.RightStepper_Down,CommonSkin.RightStepper_Over,CommonSkin.RightStepper_Up);
			_nextPageButton.addEventListener(MouseEvent.CLICK , onTurnPage);
			_nextPageButton.x = bmp.x + bmp.width + OFFSET_X;
			_nextPageButton.y = 0;
			addChild(_nextPageButton);
			
			_maxPageButton = new Button(CommonSkin.MaxStepper_Up,CommonSkin.MaxStepper_Down,CommonSkin.MaxStepper_Over,CommonSkin.MaxStepper_Up);
			_maxPageButton.addEventListener(MouseEvent.CLICK , onTurnPage);
			_maxPageButton.x = _nextPageButton.x + _nextPageButton.width + OFFSET_X;
			_maxPageButton.y = 0;
			addChild(_maxPageButton);
			
			resize(_maxPageButton.x + _maxPageButton.width,_maxPageButton.height);
		}
		
				
		/**
		 * 初始化 
		 * @param pageNums
		 * @param maxNums
		 * @param turnCallBack
		 * 
		 */
		public function init(curPage:int, maxPage:int, turnCallBack:Function):void {
			
			this._curPage = Math.max(1,curPage);
			this._maxPage = Math.max(1,maxPage);
			
			_turnCallBack = turnCallBack;
			
			update();
		}
		
		
		/**
		 * Reset 
		 * 
		 */
		public function reset():void {
			
			this._maxPage = 1;
			this._curPage = 1;
			
			update();
			_turnCallBack = null;
		}
		
		
		/**
		 * Update UI 
		 * 
		 */
		private function update():void {
			
			_pageLabel.text = _curPage + "/" + _maxPage;
		}
		
		
		/**
		 * 翻页Handler
		 * @param event
		 * 
		 */
		private function onTurnPage(event:MouseEvent):void {
			
			var changed:Boolean = false;
			switch(event.target)
			{
				case _minPageButton:
				{
					if(_curPage > 1)
					{
						changed = true;
					}
					_curPage = 1;
					break;
				}
				case _prePageButton:
				{
					if(_curPage > 1)
					{
						changed = true;
						_curPage --;
					}
					break;
				}
				case _nextPageButton:
				{
					if(_curPage < _maxPage)
					{
						changed = true;
						_curPage ++;
					}
					break;
				}
				case _maxPageButton:
				{
					if(_curPage < _maxPage)
					{
						changed = true;
						_curPage = _maxPage;
					}
					break;
				}
					
				default:
				{
					break;
				}
			}
			
			if(changed && _turnCallBack) {
				_turnCallBack();
			}
		}

		public function get maxPage():int
		{
			return _maxPage;
		}
		
		public function get curPage():int
		{
			return _curPage;
		}

		public function set maxPage(value:int):void
		{
			_maxPage = value;
		}


	}
}