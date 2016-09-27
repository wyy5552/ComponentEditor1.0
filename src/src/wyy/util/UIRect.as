package src.wyy.util
{
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import mx.core.IVisualElementContainer;
	import mx.core.UIComponent;
	
	/**
	 * 组件大小区域
	 * @author weiyanyu
	 * 创建时间：2016-9-22 下午6:23:30
	 */
	public class UIRect
	{
		private static var pointArr:Array;
		/**
		 *  
		 */		
		private static const num:int = 3;
		
		private static var _editUI:DisplayObject;
		
		private static var _dragPt:UIComponent;
		public function UIRect()
		{
			super();
			pointArr = new Array();
			var arr:Array;
			var pt:UIComponent;
			for(var i:int = 0; i < num; i++)
			{
				arr = new Array();
				pointArr.push(arr);
				for(var j:int = 0; j < num; j++)
				{
					pt = drawRect(i + "," + j);
					arr.push(pt);
				}
			}
		}
		
		/**
		 * 当前编辑的ui 
		 * @param value
		 * 
		 */		
		public static function set editUI(value:DisplayObject):void
		{
			_editUI = value;
			_editUI.parent.addEventListener(MouseEvent.MOUSE_UP,onStopDrag);
			resetPt();
		}
		
		public static function resetPt():void
		{
			var arr:Array;
			var point:UIComponent;
			for(var i:int = 0; i < num; i++)
			{
				arr = pointArr[i];
				for(var j:int = 0; j < num; j++)
				{
					point = arr[j];
					point.y = editUI.y + (editUI.height >> 1) * i;
					point.x = editUI.x + (editUI.width >> 1) * j;
					(editUI.parent).addChild(point);
					if(!point.hasEventListener(MouseEvent.MOUSE_DOWN))
					{
						point.addEventListener(MouseEvent.MOUSE_DOWN,onDrag);
					}
				}
			}
		}
		
		protected static function onStopDrag(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			editUI.stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMove);
			var pt:UIComponent = event.target as UIComponent;
			pt.stopDrag();
			_dragPt = null;
		}
		
		protected static function onMove(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			switch(_dragPt.name)
			{
				case "0,0"://左上角
					up();
					left();
					break;
				case "0,1"://上中
					up();
					break;
				case "0,2"://右上
					right();
					up();
					break;
				case "1,0"://左中
					left()
					break;
				case "1,2"://右中
					right();
					break;
				case "2,0":
					left();
					down();
					break;
				case "2,1"://下中
					down();
					break;
				case "2,2":
					down();
					right();
					break;
			}
			
			resetPt();
			
			function up():void
			{
				editUI.height = editUI.height + (editUI.y - _dragPt.y)
				editUI.y = _dragPt.y+_dragPt.height/2;
			}
			function down():void
			{
				editUI.height = (_dragPt.y - editUI.y);
			}
			function left():void
			{
				editUI.width = editUI.width + (editUI.x - _dragPt.x);
				editUI.x = _dragPt.x;;
			}
			function right():void
			{
				editUI.width = (_dragPt.x - editUI.x);
			}
		}
		
		protected static function onDrag(event:MouseEvent):void
		{
			
			// TODO Auto-generated method stub
			editUI.stage.addEventListener(MouseEvent.MOUSE_MOVE,onMove);
			_dragPt = event.target as UIComponent;
			_dragPt.startDrag();
		}
		public static function get editUI():DisplayObject
		{
			return _editUI;
		}
		
		
		public static function clear():void
		{
			
		}
		
		private static function drawRect(name:String):UIComponent
		{
			var rect:UIComponent = new UIComponent();
			rect.name = name;
			rect.graphics.beginFill(0x41415D,.2);
			rect.graphics.drawCircle(0,0,5);
			rect.graphics.endFill();
			return rect
		}
	}
}