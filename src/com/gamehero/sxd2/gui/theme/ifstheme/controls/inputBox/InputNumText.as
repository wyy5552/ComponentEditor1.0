package com.gamehero.sxd2.gui.theme.ifstheme.controls.inputBox
{
	
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * 输入<br>
	 * 文字默认宽高 60,14<br>
	 * 原则上背景框不应该太宽，否则很丑,see draw();
	 * @author weiyanyu
	 * 创建时间：2016-8-23 下午8:35:15
	 */
	public class InputNumText extends Sprite
	{
		
		/** 数量文本 **/
		private var numField:TextField;
		
		private var _max:int = 99999999;
		
		private var _min:int = 0;
		
		private var _defaultNum:int;
		
		protected var _backgroud:ScaleBitmap;
		
		public function InputNumText()
		{
			super();
			
			// 物品使用个数输入文本
			numField = new TextField();
			numField.restrict = "0-9";
			numField.type = TextFieldType.INPUT;
			numField.height = 14;
			numField.width = 60;
			numField.x = 3;
			var tf:TextFormat = new TextFormat();
			tf.size = 12;
			tf.font = GameDictionary.FONT_NAME;
			tf.color = GameDictionary.WHITE;
			numField.defaultTextFormat = tf;
			
			this.addChild(numField);
			
			
			numField.type = TextFieldType.INPUT;
			numField.addEventListener(Event.CHANGE, changeNum);
			numField.addEventListener(FocusEvent.FOCUS_OUT,onOutFocus);
		}
		
		
		
		public function set type(value:String):void
		{
			numField.type = value;
		}
		
		override public function set width(value:Number):void
		{
			super.width = value;
			numField.width = value;
			if(_backgroud)
			{
				_backgroud.width = value;
			}
		}
		override public function set height(value:Number):void
		{
			super.height = value;
			if(_backgroud)
			{
				_backgroud.height = value;
			}
			draw();
		}
		/**
		 * 更改物品数量
		 * */
		private function changeNum(e:Event):void
		{
			if(numField.text == "" || numField.text == " "||numField.text == "  " || numField.text == "   ")
			{
			}
			else
			{
				var _num:int = num;
				if(_num > max){
					_num = max;
				}else if(_num < min){
					_num = min;
				}
				num = _num;
			}
		}
		
		
		
		protected function onOutFocus(event:FocusEvent):void
		{
			if(numField.text == "" || numField.text == " "||numField.text == "  " || numField.text == "   ")
			{
				numField.text = defaultNum.toString();
				changeNum(null);
			}
		}
		
		
		
		
		public function get max():int
		{
			return _max;
		}

		public function set max(value:int):void
		{
			_max = value;
		}

		public function get min():int
		{
			return _min;
		}

		public function set min(value:int):void
		{
			_min = value;
		}
		/**
		 * 获取数量
		 * */
		public function get num():int
		{
			return int(numField.text);
		}
		public function set num(value:int):void
		{
			if(value <=  max && value >= min)
			{
				numField.text = value + "";
				this.dispatchEvent(new Event(Event.CHANGE));
			}
		}

		public function get defaultNum():int
		{
			return _defaultNum;
		}

		public function set defaultNum(value:int):void
		{
			_defaultNum = value;
		}

		public function set backgroudBd(value:BitmapData):void
		{
			if(_backgroud == null)
			{
				_backgroud = new ScaleBitmap();
				addChildAt(_backgroud,0);
				_backgroud.scale9Grid = CommonSkin.MENU_BG_GRID;
			}
			_backgroud.bitmapData = value;
			draw();
		}
		
		private function draw():void
		{
			if(_backgroud)
			{
				this.numField.y = _backgroud.height - numField.height >> 1;
			}
		}
		
	}
}