package com.gamehero.sxd2.gui.core.label
{
	import com.gamehero.sxd2.data.GameDictionary;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import alternativa.gui.controls.text.Label;
	
	/**
	 * 设置属性数据  如：  等级 1 生命 20000
	 * @author weiyanyu
	 * 创建时间：2015-8-24 下午3:48:59
	 * 
	 */
	public class PropLabel extends ActiveLabel
	{
		private var _label:Label;
		private var _propName:String;
		public function PropLabel(propName:String,propNum:String = "",iconBD:BitmapData = null,bgBD:BitmapData = null)
		{
			super();
			_propName = propName;
			if(bgBD){
				var detailBg:Bitmap = new Bitmap(bgBD);
				detailBg.y = -5;
				addChild(detailBg);
			}
			var icon:Bitmap = null;
			if(iconBD){
				icon = new Bitmap(iconBD);
				icon.y = -3;
				addChild(icon);
			}
			_label = new Label();
			_label.text = _propName;
			_label.color = GameDictionary.WINDOW_BLUE;
			_label.width = 28;
			if(icon){
				_label.x = icon.width + 3;//gapX
			}else{
				_label.x = 10;
			}
			addChild(_label);
		}
		
		/**
		 * 设置文本响应区域
		 * */
		public function setSize(w:int,h:int):void
		{
			this.graphics.beginFill(0,0);
			this.graphics.drawRect(0,-2,w,h);
			this.graphics.endFill();
		}
		
		/**
		 * 设置属性数据 
		 * @param value
		 * 
		 */		
		public function setPropNum(value:String,color):void
		{
			_label.text = _propName + " " + color + value.toString() + GameDictionary.COLOR_TAG_END;
		}
		
		public function setHint(value:String):void
		{
			this.hint = value;
		}
	}
}