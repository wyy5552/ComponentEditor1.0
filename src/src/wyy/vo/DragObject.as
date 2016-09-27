package src.wyy.vo
{
	import mx.core.UIComponent;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2016-9-22 下午4:01:32
	 */
	public class DragObject extends UIComponent
	{
		public var data:Object;
		public function DragObject()
		{
			setSize();
		}
		
		public function setSize(w:int = 100,h:int = 20):void
		{
			if(w = 0)
			{
				w = 100;
			}
			if(h = 0)
			{
				h = 20;
			}
			this.graphics.clear();
			this.graphics.beginFill(0xff,.5);
			this.graphics.drawRect(0,0,100,20);
			this.graphics.endFill();
		}
		
		
	}
}