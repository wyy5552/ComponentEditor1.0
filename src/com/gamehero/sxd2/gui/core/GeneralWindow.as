package com.gamehero.sxd2.gui.core {
	
	import com.gamehero.sxd2.gui.SButton;
	import com.gamehero.sxd2.gui.core.util.SpAddUtil;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import org.bytearray.display.ScaleBitmap;
	
	import src.wyy.model.ResourceModel;
	
	
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
			initWindow();
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
			

			
			var bd:BitmapData = SpAddUtil.getBD(ResourceModel.inst.getDomain(ResourceModel.UI),"TITLE_BD");
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
			this.addChild(closeButton);
			
			interrogationBtn =  new SButton(CommonSkin.getClass("interrogationBtn") as SimpleButton);
			interrogationBtn.visible = false;
			this.addChild(interrogationBtn);
			
			_moveBounds = new Rectangle();
			
			this.calculate();
			
			//重新布局
			this.onResize();
		}
		
		
		
		
		/**
		 * Close Button Click Handler  
		 */
		override public function close():void 
		{	
			super.close();
		}
		
		override public function set width(value:Number):void
		{
			if(value==width) return;
			super.width=value;
			
			//重新布局
			onResize();
		}
		
		
		override public function set height(value:Number):void
		{
			if(value==height) return;
			super.height=value;
			
			//重新布局
			onResize();
		}
		
		
		
		
		
		
		protected function get canResize():Boolean
		{
			return true;
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
				
			}
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