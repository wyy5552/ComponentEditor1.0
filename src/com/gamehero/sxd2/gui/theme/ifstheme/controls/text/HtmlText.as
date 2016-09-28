package com.gamehero.sxd2.gui.theme.ifstheme.controls.text {
	
	import com.gamehero.sxd2.data.GameDictionary;
	
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import alternativa.gui.base.ActiveObject;
	
	/**
	 * 带html格式的TextField
	 * @author Trey
	 * @create-date 2014-1-22
	 */
	public class HtmlText extends ActiveObject {
		
		private var _textField:TextField;
		private var _textFormat:TextFormat;
		
		// 鼠标手型使用
		private var _activeObject:ActiveObject
		private var _isClickActive:Boolean
		
		protected var myEvent:EventDispatcher = new EventDispatcher();
		
		private var _align:String = "";
		
		/**
		 * Constructor 
		 * 
		 */
		public function HtmlText(textHeight:int = 20) {
			
			super();
			
			this.height = textHeight;
			
			this.cursorActive = true;
			
			_textFormat = new TextFormat();
			_textFormat.color = GameDictionary.WHITE;
			
			_textField = new TextField();
			_textField.height = textHeight;
			//			_textField.autoSize = TextFieldAutoSize.LEFT;
			_textField.filters = [Label.TEXT_FILTER];
			_textField.selectable = false;
			_textField.type = TextFieldType.DYNAMIC;
			//			_textField.border = true;
			//			_textField.mouseEnabled = false;
			_textField.wordWrap = true; 
			_textField.multiline = true;
			addChild(_textField);
			
			_textField.defaultTextFormat = _textFormat;
			
			_activeObject = new ActiveObject();
		}
		
		
		public function set text(value:String):void {
			
			if(value == null)	return;
			
			_textField.htmlText = "<p align='"+ align + "'>" + value + "</p>";
			
			var enabled:Boolean = value.indexOf("</a") >= 0;
			
			// TO DO：为了使链接文字也有手型，今后通过MouseManager修改
			if(enabled == true) 
			{
				addChild(_activeObject);
			}
			if(_activeObject)
			{
				_activeObject.cursorActive = true;
				_activeObject.graphics.clear();
				_activeObject.graphics.beginFill(0x777777, 0);
				_activeObject.graphics.drawRect(0, 0, _textField.textWidth, _textField.textHeight);
				_activeObject.graphics.endFill();
			}
			if(_isClickActive)
				_activeObject.addEventListener(MouseEvent.CLICK,activeObjectClickHandle);
			
			this.height = _textField.height;
			this.width = _textField.textWidth;
		}
		
		
		private function activeObjectClickHandle(e:MouseEvent):void
		{
			var str:String = this._textField.htmlText;
			var strList:Array = str.split("event:");
			str = strList[1];
			strList = str.split('"');
			var textEvent:TextEvent = new TextEvent(TextEvent.LINK, true, false, strList[0]);
			dispatchEvent(textEvent);	
		}
		
		
		public function get activeObject():ActiveObject {
			
			return _activeObject;
		}
		
		
		public function get text():String {
			
			return _textField.htmlText;
		}
		
		
		public function setTextWidth(value:Number):void {
			
			_textField.autoSize = TextFieldAutoSize.NONE;
			_textField.width = value;
		}
		
		
		public function get textField():TextField
		{
			return this._textField;
		}
		
		
		public function set isClickActive(bool:Boolean):void
		{
			_isClickActive = bool;
		}
		
		
		public function get isClickActive():Boolean
		{
			return _isClickActive;
		}
		
		
		override public function set hint(value:String):void
		{
			if(_activeObject)
			{
				_activeObject.hint = value;
			}
		}
		
		public function get align():String
		{
			return _align;
		}
		
		public function set align(value:String):void
		{
			_textField.defaultTextFormat.align = value;
			_align = value;
		}
		
		public function set leading(value:int):void
		{
			_textFormat.leading = value;
			_textField.defaultTextFormat = _textFormat;
			
			this.text = _textField.text;
		}
	}
}