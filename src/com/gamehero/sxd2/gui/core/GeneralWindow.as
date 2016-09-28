package com.gamehero.sxd2.gui.core {
	
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.IAlert;
	import com.gamehero.sxd2.gui.SButton;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	import com.gamehero.sxd2.util.WasynManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import org.bytearray.display.ScaleBitmap;
	
	
	/**
	 * 通用 Window
	 * @author Trey
	 * @create-date: 2013-8-15
	 */
	public class GeneralWindow extends GameWindow {
		/**
		 * 云朵与名字的gap 
		 */		
		private const CLOUD_NAME_GAP:int = 3;
		/**
		 * 关闭按钮
		 * */
		public var closeButton:SButton;
		/**
		 * 小问号 
		 */		
		private var interrogationBtn:SButton;

		// 移动热区Boudns
		private var _moveBounds:Rectangle;

		private var _moveActiveArea:Sprite;
		
		// 宽高适应次数 
		protected var _resizeNum:int = 1;
		
		// 背景素材
		private var _bgBitmap:ScaleBitmap;
		private var _deco1:Bitmap;
		private var _deco2:Bitmap;
		private var _titelBg:Bitmap;
		
		private var _titleSp:Sprite;
		//标题背景是否带云
		private var _titleType:Boolean;
		
		
		
		
		/**
		 * Constructor 
		 * @param position
		 * @param resourceURL
		 * @param width
		 * @param height
		 * @param bool
		 */
		public function GeneralWindow(position:int, resourceURL:String = null, width:Number = 0, height:Number = 0,titleType:Boolean = true) {
			
			super(position, resourceURL, width, height);
			_titleType = titleType;
		}
		
		
		/**
		 * Override initWindow() 
		 * 
		 */
		override protected function initWindow():void {
			
			super.initWindow();
			
			// 窗口背景
			_bgBitmap = new ScaleBitmap(CommonSkin.windowInner1Bg);
			_bgBitmap.scale9Grid = CommonSkin.windowInner1BgScale9Grid;
			this.addChild(_bgBitmap);
			
			_titelBg = _titleType?new Bitmap(MainSkin.NAME_TITLE_CLOUD_BG):new Bitmap(MainSkin.NAME_TITLE_BG);
			addChild(_titelBg);
			

			
			var bd:BitmapData = getSwfBD("TITLE_BD");
			if(bd != null) 
			{	
				_titleSp = new Sprite();
				addChild(_titleSp);
				// 窗口标题
				var titleName:Bitmap = new Bitmap();
				_titleSp.addChild(titleName);
				titleName.bitmapData = bd;
				_titleSp.x = this.width + _titleSp.width >> 1;
			}
			
			
			// 关闭按钮
			closeButton = new SButton(CommonSkin.getClass("closeButton") as SimpleButton);
			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
			this.addChild(closeButton);
			
			interrogationBtn =  new SButton(CommonSkin.getClass("interrogationBtn") as SimpleButton);
			interrogationBtn.visible = false;
			this.addChild(interrogationBtn);
			
			// 标题栏移动热区
			_moveActiveArea = new Sprite();
			this.addChildAt(_moveActiveArea, 0);
			_moveBounds = new Rectangle();
			
			this.calculate();
			
			//重新布局
			this.onResize();
		}
		
		protected function addInnerBg(c:ScaleBitmap, px:int = 0, py:int = 0, w:int = -1, h:int = -1):void 
		{	
			c.x = px;
			c.y = py;
			if(h != -1) {
				
				c.setSize(w,h);
			}
			
			addChild(c);
		}
		
		
		/**
		 * Do Something After Show 
		 */
		override protected function onShow():void 
		{	
			super.onShow();
			
			_moveActiveArea.addEventListener(MouseEvent.MOUSE_DOWN, onWindowMove);
			if(_titleSp)
			{	
				_titleSp.addEventListener(MouseEvent.MOUSE_DOWN, onWindowMove);
			}
			App.windowUI.stage.addEventListener(MouseEvent.MOUSE_UP, onWindowMove);
			
			dispatchEvent(new Event(Event.COMPLETE));//模块swf加载成功
		}
		
		
		
		
		/**
		 * Close Button Click Handler 
		 */
		protected function onCloseButtonClick(event:MouseEvent):void 
		{	
			this.close();
		}
		
		
		
		
		/**
		 * Close Button Click Handler  
		 */
		override public function close():void 
		{	
			super.close();
			
			_moveActiveArea && _moveActiveArea.removeEventListener(MouseEvent.MOUSE_DOWN, onWindowMove);
			if(_titleSp)
			{	
				_titleSp.removeEventListener(MouseEvent.MOUSE_DOWN, onWindowMove);
			}
			App.windowUI.stage.removeEventListener(MouseEvent.MOUSE_UP, onWindowMove);
		}
		
		
		/**
		 * 窗口移动Handler 
		 * @param event
		 * 
		 */
		private function onWindowMove(event:MouseEvent):void {
			
			if(event.type == MouseEvent.MOUSE_DOWN) {
				
//				_moveBounds.setTo(0, 0, App.windowUI.width - this.width, App.windowUI.height - this.height);
				_moveBounds.x = 0;
				_moveBounds.y = 0;
				_moveBounds.width = App.windowUI.width - this.width;
				_moveBounds.height = App.windowUI.height - this.height;
				//2015年12月15日12:44:23 by shenliangliang 获取当前点击窗口显示在最前面
				if(!(this is IAlert))
				{
					WindowManager.inst.topWindow(this);
				}
//				WindowManager.inst.topWindow(this);
				
				this.startDrag(false, _moveBounds);
			}
			else {
				
				this.stopDrag();
			}
			
		}
		
		override public function set width(value:Number):void
		{
			if(value==width) return;
			super.width=value;
			
			//重新布局
			asynResize();
		}
		
		
		override public function set height(value:Number):void
		{
			if(value==height) return;
			super.height=value;
			
			//重新布局
			asynResize();
		}
		
		
		
		/**
		 * 之所以覆盖改方法， BaseWindow父类计算的宽高并非所需且没有并要
		 */		
		override protected function calculate():void
		{
			
		}
		
		
		
		
		/**
		 * 帧末尾统一调用onResize，避免多次调用onResize
		 */		
		protected function asynResize():void
		{
			WasynManager.instance.addFuncToEnd(onResize);
		}
		
		
		
		
		protected function get canResize():Boolean
		{
			return _resizeNum>0&&loaded;
		}
		
		
		
		
		/**
		 *重置布局 
		 * 
		 */		
		protected function onResize():void
		{
			if(canResize == true)
			{
				_resizeNum--;
				
				_bgBitmap.setSize(this.width, this.height);
				
				this.adjustTitle();
				
				closeButton.x = this.width - closeButton.width - 1;
				closeButton.y = 1;
				
				interrogationBtn.x = closeButton.x - interrogationBtn.width;
				interrogationBtn.y = 1;
				
				_moveActiveArea.graphics.clear();
				_moveActiveArea.graphics.beginFill(0x000000, 0);
				_moveActiveArea.graphics.drawRect(0, 0, this.width, 35);
			}
		}
		
		/**
		 * 设置小问号hint
		 * */
		protected function set interrogation(value:String):void
		{
			this.interrogationBtn.visible = true;
			this.interrogationBtn.hint = GameDictionary.getGeneralTips(value);
		}
		
		
		/**
		 * 调整标题位置 
		 */
		protected function adjustTitle():void
		{	
			if(_titleSp)
			{	
				_titleSp.x = (this.width - _titleSp.width) >> 1;
				_titleSp.y = 12;
			}
			_titelBg.x = (this.width - _titelBg.width) >> 1;
			_titelBg.y = 6;
		}
	}
}