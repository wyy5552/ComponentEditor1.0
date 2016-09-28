package com.gamehero.sxd2.gui.core.imageCutBox
{
	import com.gamehero.sxd2.event.BaseEvent;
	
	import flash.events.Event;
	
	/**
	 * @author Wbin
	 * 创建时间：2016-9-20 上午10:27:27
	 * 
	 */
	public class ImageCutEvent extends BaseEvent
	{
		/**
		 * 裁切区域过小
		 * */
		public static const CUT_SMALL:String = "CUT_SMALL";
		
		/**
		 * 裁切变化
		 * */
		public static const CUT_CHANGE:String = "CUT_CHANGE";
		
		/**
		 * 预览图片资源
		 * */
		public static const SCAN_BITMAPDATA:String = "SCAN_BITMAPDATA";
		
		public function ImageCutEvent(type:String, data:Object=null)
		{
			super(type, data);
		}
		
		override public function clone():Event
		{
			return new ImageCutEvent(type , data);
		}
	}
}