package com.gamehero.sxd2.gui.core
{
	import com.gamehero.sxd2.util.WasynManager;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	

	/**
	 * @author Wbin
	 * 创建时间：2016-3-9 下午12:04:07
	 * 特殊窗口：
	 * 1、GameWindow不支持窗口拖拽
	 * 2、全局始终显示，只支持手动关闭
	 * 3、canOpenTween = false  不需要缓动打开
	 */
	public class SpecialWindow extends GameWindow implements ISWindow 
	{
		// 移动热区Boudns
		private var _moveBounds:Rectangle;
		private var _moveActiveArea:Sprite;
		// 宽高适应次数 
		protected var _resizeNum:int = 1;
		public function SpecialWindow(position:int, resourceURL:String="", width:Number=0, height:Number=0)
		{
			super(position, resourceURL, width, height);
			canOpenTween = false;
		}
		
		override protected function initWindow():void
		{
			// TODO Auto Generated method stub
			super.initWindow();
			
			//窗口实例大小
			this.graphics.beginFill(0x000000,0);
			this.graphics.drawRect(0,0,this.width,this.height);
			this.graphics.endFill();
			
			// 标题栏移动热区
			_moveActiveArea = new Sprite();
			this.addChild(_moveActiveArea);
			_moveBounds = new Rectangle();
			
			this.calculate();
			
			//重新布局
			this.onResize();
		}
		
		/**
		 * Do Something After Show 
		 */
		override protected function onShow():void 
		{	
			super.onShow();
			
			_moveActiveArea.addEventListener(MouseEvent.MOUSE_DOWN, onWindowMove);
			App.windowUI.stage.addEventListener(MouseEvent.MOUSE_UP, onWindowMove);
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
				//获取当前点击窗口显示在最前面
				if(App.windowUI.contains(this))
					App.windowUI.setChildIndex(this,App.windowUI.numChildren - 1);
				
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
		 *重置布局 
		 * 
		 */		
		protected function onResize():void
		{
			if(canResize == true)
			{
				_resizeNum--;
				
//				_bgBitmap.setSize(this.width, this.height);
				
				_moveActiveArea.graphics.clear();
				_moveActiveArea.graphics.beginFill(0x000000, 0);
				_moveActiveArea.graphics.drawRect(0, 0, this.width, 100);
			}
		}
		
		/**
		 * Close Button Click Handler  
		 */
		override public function close():void 
		{	
			super.close();
			canOpenTween = false;
			_moveActiveArea.removeEventListener(MouseEvent.MOUSE_DOWN, onWindowMove);
			App.windowUI.stage.removeEventListener(MouseEvent.MOUSE_UP, onWindowMove);
		}
	}
}