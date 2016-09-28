package com.gamehero.sxd2.gui.core.event
{
	import com.gamehero.sxd2.event.BaseEvent;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2015-12-8 下午5:20:10
	 * 
	 */
	public class DataGroupEvent extends BaseEvent
	{
		public static var SELECTED:String = "selected";
		
		public static var CLICK:String = "data_group_click";
		
		public static var DOUBLE_CLICK:String = "data_group_double_click";
		public function DataGroupEvent(type:String, data:Object=null)
		{
			super(type, data);
		}
	}
}