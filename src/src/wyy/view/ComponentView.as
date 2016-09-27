package src.wyy.view
{
	
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import mx.controls.Button;
	
	import spark.components.Group;
	
	import src.wyy.event.WyyEvent;
	import src.wyy.vo.PropertyBaseVo;
	
	/**
	 * 组件展示部分
	 * @author weiyanyu
	 * 创建时间：2016-9-22 下午3:54:36
	 */
	public class ComponentView extends Group
	{
		[Embed(source="/assets/component.xml",mimeType = "application/octet-stream")]
		public var xmlClass:Class;
		
		public var dict:Dictionary = new Dictionary();
		
		public function ComponentView()
		{
			super();
			
			var xml:XML = XML(new xmlClass());
			trace(xml);
			
			var vo:PropertyBaseVo;
			var i:int;
			for each(var node:XML in xml.comp)
			{
				vo = new PropertyBaseVo();
				vo.fromXML(node);
				dict[vo.type] = vo;
				var btn:Button = new Button();
				btn.x = 10;
				btn.y = 20 + (20 + 5) * i;
				i++;
				addElement(btn);
				btn.data = vo;
				btn.label = vo.type;
				btn.addEventListener(MouseEvent.MOUSE_DOWN,onStartDrag);
			}
			
		}
		
		protected function onStartDrag(event:MouseEvent):void
		{
			var btn:Button = event.target as Button;
			dispatchEvent(new WyyEvent(WyyEvent.DRAG_COMPONENT,btn.data));
		}
	}
}