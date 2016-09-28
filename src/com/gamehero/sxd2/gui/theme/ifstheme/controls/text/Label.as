package com.gamehero.sxd2.gui.theme.ifstheme.controls.text {
	
	
	import com.gamehero.sxd2.data.Browser;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.data.OS;
	import com.gamehero.sxd2.manager.JSManager;
	
	import flash.filters.GlowFilter;
	import flash.text.engine.FontDescription;
	import flash.text.engine.FontLookup;
	
	import alternativa.gui.controls.text.Label;
	import alternativa.gui.enum.Align;
	import alternativa.gui.theme.defaulttheme.skin.NumericConst;


	/**
	 * 自定义Lable控件<br/>
	 * 增加自定义一些属性
	 * @author Trey
	 * @edit xuwenyi 2016-03-30 去掉颜色引用,基础组件类不能引用GameDictionary类似的类,否则SXD2Game会变大
	 */
	public class Label extends alternativa.gui.controls.text.Label {
		
		// 字体黑灰色描边
		static public const TEXT_FILTER:GlowFilter = new GlowFilter(0x191d20, 1, 2, 2, 8);
		
		
		/**
		 * Constructor 
		 * @param autosize
		 * 
		 */
		public function Label(autosize:Boolean=true) {
			
			super(autosize);
			
			// 根据浏览器设置字体
			var fontName:String = GameDictionary.getFontName();
			fontDescription = new FontDescription(fontName);
			if(GameDictionary.needEmbedFont()){
				fontDescription.fontLookup = FontLookup.EMBEDDED_CFF;
			}
			ef.fontDescription = fontDescription.clone();
			
			// mac系统的chrome不兼容tlf文字渲染，故采用位图缓存
			var system:String = JSManager.getSystemName();
			if(system == OS.Mac)
			{
				this.cacheAsBitmap = true;
			}
			
			size = NumericConst.textSize;
			color = GameDictionary.GRAY;
			
			leading = .5;//默认行间距是半个文字高度
		}
		
		/**
		 *設置字體描邊 
		 * @param bool
		 * 
		 */		
		public function set fontFilter(value:Boolean):void
		{
			if(value == true)
			{
				this.filters = [TEXT_FILTER];
			}
			else
			{
				this.filters = [];
			}
		}
		
		/**
		 * 居中、居右必须设置autosize为false才起效 
		 * @param value
		 * 
		 */
		override public function set align(value:Align):void {
			
			if(value != Align.LEFT) {
				
				this.autosize = false;
			}
			else {
				
				this.autosize = true;
			}
			
			super.align = value;
		}
		
		override public function set bold(value:Boolean):void
		{
			//chrome里面设置黑体会乱码
			if(JSManager.getBrowserName() == Browser.Chrome)
				return;
			super.bold = value;
		}
		
		
//		override public function update():void {
//			
//			super.update();
//			
//			graphics.clear();
//			graphics.beginFill(0xFF0000, 1);
//			graphics.drawRect(0, 0, this.width, this.height);
//			
//		}
		
	}
}
