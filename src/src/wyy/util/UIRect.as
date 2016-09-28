package src.wyy.util
{
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;
	
	import src.wyy.event.WyyEvent;
	
	/**
	 * 组件大小区域
	 * @author weiyanyu
	 * 创建时间：2016-9-22 下午6:23:30
	 */
	public class UIRect
	{
		private var pointArr:Array;
		/**
		 *  
		 */		
		private const num:int = 3;
		
		private var _editUI:DisplayObject;
		
		private var _dragPt:UIComponent;
		
		private static var _instance: UIRect;
		public static function get inst(): UIRect
		{
			if(_instance == null)
				_instance = new  UIRect();
			return _instance;
		}
		
		public function UIRect()
		{
			super();
			if(_instance != null)
				throw "UIRect.as" + "is a SingleTon Class!!!";
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
		public function set editUI(value:DisplayObject):void
		{
			_editUI = value;
			resetPt();
		}
		
		private function resetPt():void
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
		/**
		 * 鼠标抬起，拖拽点置空 
		 * 
		 */		
		public function onMouseUp():void
		{
			if(editUI != null && _dragPt != null)
			{
				editUI.stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMove);
				_dragPt.stopDrag();
				_dragPt = null;
			}
		}
		protected function onDrag(event:MouseEvent):void
		{
			
			editUI.stage.addEventListener(MouseEvent.MOUSE_MOVE,onMove);
			_dragPt = event.target as UIComponent;
			_dragPt.startDrag();
		}
		
		
		protected function onMove(event:MouseEvent):void
		{
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
			
			editUI.dispatchEvent(new WyyEvent(WyyEvent.UI_RESIZE));
		}
		
		public function get editUI():DisplayObject
		{
			return _editUI;
		}
		
		
		public function clear():void
		{
			
		}
		
		private function drawRect(name:String):UIComponent
		{
			var rect:UIComponent = new UIComponent();
			rect.name = name;
			rect.graphics.beginFill(0x41415D,1);
			rect.graphics.drawRect(-3,-3,6,6);
			rect.graphics.endFill();
			return rect
		}
	}
}