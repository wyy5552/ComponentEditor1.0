package com.gamehero.sxd2.gui.core
{
	import com.gamehero.sxd2.gui.IAlert;
	import com.gamehero.sxd2.gui.SButton;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.DialogSkin;
	import com.gamehero.sxd2.util.WasynManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * 没有区分标题状态的可拖动<br>
	 * <font color="gray" size=3>标题</font>
	 * <font color="gray" size=3>背景</font>
	 * 颜色一样
	 * @author shenliangliang
	 * @E-mail: 971935832@qq.com
	 * 创建时间：2015-12-28 下午5:58:10
	 * 
	 */
	public class PanelWindow extends GameWindow
	{
		private var _titleSp:Sprite;
		
		/**
		 * 关闭按钮
		 * */
		public var closeButton:SButton;
		/**
		 * 横线
		 * */
		public var line:ScaleBitmap;
		
		// 移动热区Boudns
		private var _moveBounds:Rectangle;
		
		private var _moveActiveArea:Sprite;
		
		protected var _titleName:Bitmap;
		
		// 宽高适应次数 
		protected var _resizeNum:int = 1;
		public function PanelWindow(position:int, resourceURL:String=null, width:Number=0, height:Number=0)
		{
			super(position, resourceURL, width, height);
		}
		
		override protected function initWindow():void
		{
			// TODO Auto Generated method stub
			super.initWindow();
			//背景
			var _bgBitmap:ScaleBitmap = new ScaleBitmap(DialogSkin.DIALOG_BG);
			_bgBitmap.scale9Grid = DialogSkin.DIALOG_BG_9GRID;
			this.addChild(_bgBitmap);
			_bgBitmap.setSize(this.width,this.height);
			
			var bd:BitmapData = getSwfBD("TITLE_BD");
			if(bd != null) 
			{	
				_titleSp = new Sprite();
				addChild(_titleSp);
				// 窗口标题
				_titleName = new Bitmap();
				_titleSp.addChild(_titleName);
				_titleName.bitmapData = bd;
				_titleSp.x = (this.width>>1) - (_titleName.width>>1);
				_titleSp.y = 11;
			}
			
			// 关闭按钮
			closeButton = new SButton(CommonSkin.getClass("closeButton") as SimpleButton);
			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
			this.addChild(closeButton);
			closeButton.x = (this.width) - (closeButton.width);
			
			//线
			line = new ScaleBitmap();
			line.bitmapData = CommonSkin.WINDOW_LINE2;
			line.setSize(this.width,1);
			add(line,1,this.closeButton.height,this.width - 2);
			
			// 标题栏移动热区
			_moveActiveArea = new Sprite();
			this.addChildAt(_moveActiveArea, 0);
			_moveBounds = new Rectangle();
			
			this.calculate();
			
			//重新布局
			this.onResize();
		}
		
		protected function setTitleName(bd:BitmapData):void
		{
			if(bd != null) 
			{	
				_titleSp = new Sprite();
				addChild(_titleSp);
				// 窗口标题
				_titleName = new Bitmap();
				_titleSp.addChild(_titleName);
				_titleName.bitmapData = bd;
				_titleSp.x = (this.width>>1) - (_titleName.width>>1);
				_titleSp.y = 11;
			}
		}
		
		protected function onCloseButtonClick(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			this.close();
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
				
//				_bgBitmap.setSize(this.width, this.height);
				
				
				closeButton.x = this.width - closeButton.width - 1;
				closeButton.y = 1;
				
				_moveActiveArea.graphics.clear();
				_moveActiveArea.graphics.beginFill(0x000000, 0);
				_moveActiveArea.graphics.drawRect(0, 0, this.width, 35);
			}
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
		 * Close Button Click Handler  
		 */
		override public function close():void 
		{	
			super.close();
			
			_moveActiveArea.removeEventListener(MouseEvent.MOUSE_DOWN, onWindowMove);
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
		}
		
	}
}