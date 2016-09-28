package src.wyy.event
{
	
	import flash.events.Event;
	
	/**
	 * 
	 * @author weiyanyu
	 * 创建时间：2016-9-22 下午4:09:11
	 */
	public class WyyEvent extends Event
	{
		public var data:Object;
		/**
		 * 组件被点击 
		 */		
		public static var DRAG_COMPONENT:String = "drag_component";
		/**
		 * 组件属性设置 
		 */		
		public static var PROPERTY_CHANGE:String = "PROPERTY_CHANGE";
		/**
		 * 组件变量名字
		 */		
		public static var UI_NAME_CHANGE:String = "UI_NAME_CHANGE";
		
		/**
		 * 组件拖动大小 
		 */		
		public static var UI_RESIZE:String = "UI_RESIZE";
		public function WyyEvent(type:String, data:Object=null)
		{
			super(type,true);
			this.data = data;
		}
	}
}