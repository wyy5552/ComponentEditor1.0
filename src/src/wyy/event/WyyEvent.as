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
		/**
		 * 组件被点击 
		 */		
		public static var DRAG_COMPONENT:String = "drag_component";
		public function WyyEvent(type:String, data:Object=null)
		{
			super(type, data);
		}
	}
}