package com.gamehero.sxd2.gui.theme.ifstheme.controls {

	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.greensock.TweenLite;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import alternativa.gui.alternativagui;
	import alternativa.gui.base.ActiveObject;
	import alternativa.gui.mouse.CursorManager;
	
	import org.as3commons.logging.level.ERROR;
	import org.bytearray.display.ScaleBitmap;

	use namespace alternativagui;

	
	/**
	 * ProgressBar
	 * @author Trey
	 * @create-date 2013-8-14
	 */
	// Modify by Trey, 2014-4-11, 为了增加hint显示，继承修改为ActiveObject
//	public class ProgressBar extends GUIobject {
	public class ProgressBar extends ActiveObject {
		
		// RU: фон
        // EN: background
		protected var bgLine:ScaleBitmap;

		// RU: заполненная линия
        // EN: filled line
		protected var fullLine:ScaleBitmap;

		// RU: маска
        // EN: mask
		protected var maskLine:ScaleBitmap;

		// RU: процент загрузки (0 - 1)
        // EN: load percent (from 0 to 1)
		protected var _percent:Number = 0;

		// RU: текстовая метка
        // EN: text label
//		protected var _label:Label;
		protected var labelTF:Label;
		
		protected var _isPlay:Boolean;//播放动画
		private var _skip:Boolean;//跳过，越级，涨到最高在到当前
		
		private var _tween:TweenLite;
		
		private var _showLab:Boolean;
		
		/**
		 * 
		 * @param lineBGSkin 进度条背景
		 * @param lineFullSkin 进度条填充背景
		 * @param scale9Grid 进度条九宫格
		 * @param showLab 进度条是否常显
		 * 
		 */		
		public function ProgressBar(lineBGSkin:BitmapData, lineFullSkin:BitmapData,scale9Grid:Rectangle,showLab:Boolean = false) {
			
			bgLine = new ScaleBitmap(lineBGSkin);
			addChild(bgLine);
			
			fullLine = new ScaleBitmap(lineFullSkin,"auto",true);
			bgLine.scale9Grid = scale9Grid;
			fullLine.width = bgLine.width = 0;
			addChild(fullLine);
			
			labelTF = new Label();
			addChild(labelTF);
			labelTF.visible = showLab;
			labelTF.filters = [new GlowFilter(0x653f08, 1, 2, 2, 8)];

			_showLab = showLab;
			cursorType = CursorManager.ARROW;
		}
		
		override public function set out(value:Boolean):void
		{
			// TODO Auto Generated method stub
			super.out = value;
			if(value)
			{
				if( !_showLab )
				{
					labelTF.visible = false;	
				}
			}
		}
		
		override public function set over(value:Boolean):void
		{
			// TODO Auto Generated method stub
			super.over = value;
			if(value)
			{
				if( !_showLab )
				{
					labelTF.visible = true;	
				}
			}
		}
		
		
		public function get percent():Number {
			return _percent;
		}

		public function set percent(value:Number):void {
			_tween && _tween.kill();
			
			function setWidth():void
			{
				_tween && _tween.kill();
				if(value <= 0)
				{
					fullLine.visible = false;	
				}
				else
				{
					fullLine.visible = true;
					fullLine.setSize(_width * value,_height);
				}
			}
			
			if(_isPlay)
			{
				fullLine.height = _height;
				
				if(value < _percent && _skip)
				{
					_tween = TweenLite.to(fullLine,0.3,{width:_width,onComplete:setWidth});
				}
				else
				{
					_tween = TweenLite.to(fullLine,0.3,{width:_width * value});
				}
			}
			else
			{
				setWidth();
			}
			_percent = value;
			draw();
		}

		override protected function draw():void {
			
			super.draw();
			
			bgLine.setSize(_width, _height);
			
			labelTF.x = (_width - int(labelTF.width)) >> 1;
			labelTF.y = ((_height - int(labelTF.height)) >> 1) - 1;
		}
		
		public function get text():String {
			return labelTF.text;
		}

		public function set text(value:String):void {
			labelTF.text = value;
			draw();
		}
		
		/**
		 *设置 
		 * @param current
		 * @param max
		 * 
		 */		
		public function setPercent(current:int,max:int):void
		{
			if(max == 0)
			{
				this.fullLine.width = 0;
			}
			else
			{
				this.percent = current / max;
			}
		}
		
		
		/**
		 *颜色 
		 * @param color
		 * 
		 */		
		public function set color(value:int):void
		{
			labelTF.color = value;
		}
		
		
		// Add by Trey, 2013-11-21, 增加前景
		public function addForeground(foreground:DisplayObject, point:Point = null):void {
			
			foreground.x = (_width - foreground.width) >> 1;
			foreground.y = (_height - foreground.height) >> 1;
			
			if(point) {
				
				foreground.x += point.x;
				foreground.y += point.y;
			}
			
			this.addChildAt(foreground, getChildIndex(labelTF));
		}

		public function set isPlay(value:Boolean):void
		{
			_isPlay = value;
		}

		public function set skip(value:Boolean):void
		{
			_skip = value;
		}


	}
}
