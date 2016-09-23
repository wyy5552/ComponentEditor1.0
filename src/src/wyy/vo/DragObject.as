package src.wyy.vo
{
	import flash.display.DisplayObject;
	
	import mx.core.UIComponent;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2016-9-22 下午4:01:32
	 */
	public class DragObject extends UIComponent
	{
		public var ui:DisplayObject;
		public var data:Object;
		public function DragObject()
		{
			this.graphics.beginFill(0xff,.5);
			this.graphics.drawRect(0,0,100,20);
			this.graphics.endFill();
		}
		
		
	}
}