package src.wyy.view
{
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import mx.core.UIComponent;
	
	import src.wyy.event.WyyEvent;
	import src.wyy.util.UIRect;
	
	
	/**
	 * ui编辑部分
	 * @author weiyanyu
	 * 创建时间：2016-9-22 下午3:37:21
	 */
	public class UIView extends UIComponent
	{
		
		private var _curFocus:DisplayObject;
		
		private var _addVec:Vector.<DisplayObject> = new Vector.<DisplayObject>();
		
		public function UIView()
		{
			super();
			
			addEventListener(MouseEvent.ROLL_OVER,onUIOver);
			addEventListener(MouseEvent.ROLL_OUT,onUIOut);
		}
		
		public function get addVec():Vector.<DisplayObject>
		{
			return _addVec;
		}

		public function set addVec(value:Vector.<DisplayObject>):void
		{
			_addVec = value;
			
		}
		
		public function addItem(dis:DisplayObject):void
		{
			addChild(dis);
			dis.addEventListener(MouseEvent.MOUSE_DOWN,onItemDown);
			dis.addEventListener(MouseEvent.MOUSE_UP,onItemUp);
		}
		public function removeItem(dis:DisplayObject):void
		{
			removeChild(dis);
			dis.removeEventListener(MouseEvent.MOUSE_DOWN,onItemDown);
			dis.removeEventListener(MouseEvent.MOUSE_UP,onItemUp);
		}
		
		protected function onItemDown(event:Event):void
		{
			Sprite(event.target).startDrag();
			curFocus = event.target as DisplayObject;
			UIRect.inst.editUI = curFocus;
			addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
		}
		
		protected function onMouseMove(event:MouseEvent):void
		{
			UIRect.inst.editUI = curFocus;
		}
		protected function onItemUp(event:Event):void
		{
			Sprite(event.target).stopDrag();
			removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
		}
		
		/**
		 * 鼠标在ui编辑区，则监听按键动作 
		 * @param event
		 * 
		 */		
		protected function onUIOver(event:MouseEvent):void
		{
			addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
		}
		protected function onUIOut(event:MouseEvent):void
		{
			removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
		}
		
		protected function onKeyDown(event:KeyboardEvent):void
		{
			// TODO Auto-generated method stub
			if(curFocus != null)
			{
				if(event.keyCode == Keyboard.LEFT)
				{
					curFocus.x --;
				}
				else if(event.keyCode == Keyboard.RIGHT)
				{
					curFocus.x ++;
				}
				else if(event.keyCode == Keyboard.DOWN)
				{
					curFocus.y ++;	
				}
				else if(event.keyCode == Keyboard.UP)
				{
					curFocus.y --;	
				}
				
			}
		}

		/**
		 * 当前编辑的对象 
		 */
		public function get curFocus():DisplayObject
		{
			return _curFocus;
		}

		/**
		 * @private
		 */
		public function set curFocus(value:DisplayObject):void
		{
			_curFocus = value;
		}

		public function clear():void
		{
			removeChildren();
			addVec = new Vector.<DisplayObject>();
		}

	}
}