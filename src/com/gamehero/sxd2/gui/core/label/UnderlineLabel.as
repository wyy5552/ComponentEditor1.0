package com.gamehero.sxd2.gui.core.label
{
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	
	import alternativa.gui.base.ActiveObject;
	
	/**
	 * 下划线文本
	 * @author CUIXU
	 * 
	 */
	public class UnderlineLabel extends ActiveObject
	{
		private var _label:Label;
		public var underLine:Boolean = true;//显示下划线
		
		public function UnderlineLabel()
		{
			super();
			_label = new Label();
			addChild(_label);
		}
		
		public function set color(value:uint):void
		{
			_label.color = value;
			drawLine();
		}
		
		public function set text(value:String):void {
			_label.text = value;
			drawLine();
		}
		
		private function drawLine():void{
			this.graphics.clear();
			if(_label.text != "" && underLine){
				this.graphics.lineStyle(1,_label.color);
				this.graphics.moveTo(0,_label.height + 1);
				this.graphics.lineTo(_label.width,_label.height + 1);
			}
		}
		
		override public function get width():Number
		{
			// TODO Auto Generated method stub
			return _label.width;
		}
		
		
	}
}