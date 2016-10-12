package com.gamehero.sxd2.gui.core.components
{
	
	import flash.display.BitmapData;
	
	import alternativa.gui.base.ActiveObject;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2016-10-12 下午5:01:04
	 */
	public class SpBitmap extends ActiveObject
	{
		private var bmp:ScaleBitmap = new ScaleBitmap();
		public function SpBitmap()
		{
			super();
			addChild(bmp);
		}
		
		public function set bitmapData(value:BitmapData):void
		{
			bmp.bitmapData = value;
		}
		
		override public function get height():Number
		{
			// TODO Auto Generated method stub
			return super.height;
		}
		
		override public function set height(value:Number):void
		{
			// TODO Auto Generated method stub
			super.height = value;
			bmp.height = value;
		}
		
		override public function get width():Number
		{
			// TODO Auto Generated method stub
			return super.width;
		}
		
		override public function set width(value:Number):void
		{
			// TODO Auto Generated method stub
			super.width = value;
			bmp.width = value;
		}
		
	}
}