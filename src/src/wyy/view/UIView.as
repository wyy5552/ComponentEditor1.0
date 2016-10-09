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
	import src.wyy.model.CompModel;
	import src.wyy.model.UIModel;
	import src.wyy.util.BinderManager;
	import src.wyy.vo.KeyValueVo;
	import src.wyy.vo.PropertyBaseVo;
	
	
	/**
	 * ui编辑部分
	 * @author weiyanyu
	 * 创建时间：2016-9-22 下午3:37:21
	 */
	public class UIView extends UIComponent
	{
		
		private var _curFocus:Sprite;
		
		public var propertyView:PropertyView;
		
		private var model:UIModel = UIModel.inst;
		
		
		public function UIView()
		{
			super();
		}
		
		public function init():void
		{
			addEventListener(MouseEvent.ROLL_OVER,onUIOver);
			addEventListener(MouseEvent.ROLL_OUT,onUIOut);
			
			propertyView.addEventListener(WyyEvent.UI_NAME_CHANGE,onUINameChange);
		}
		
		protected function onUINameChange(event:WyyEvent):void
		{
			var uiName:String = event.data as String;
			(model.voDict[curFocus] as PropertyBaseVo).uiName = uiName;
		}
		/**
		 * 编辑区添加组件 
		 * @param dis
		 * @param vo
		 * 
		 */		
		public function addItem(dis:DisplayObject,vo:PropertyBaseVo):void
		{
			model.voDict[dis] = vo;
			if(model.addVec.indexOf(dis) == -1)
			{
				model.addVec.push(dis);
			}
			BinderManager.inst.bind(dis,vo);
			addChild(dis);
			dis.addEventListener(MouseEvent.MOUSE_DOWN,onItemDown);
		}
		public function removeItem(dis:DisplayObject):void
		{
			removeChild(dis);
			model.voDict[dis] = null;
			delete model.voDict[dis];
			model.addVec.splice(model.addVec.indexOf(dis),1);
			
			dis.removeEventListener(MouseEvent.MOUSE_DOWN,onItemDown);
		}
		
		protected function onItemDown(event:Event):void
		{
			curFocus = event.target as Sprite;
			(curFocus).startDrag();
			propertyView.data = model.voDict[curFocus];
			UIRect.inst.editUI = curFocus;
			addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			if(!curFocus.hasEventListener(WyyEvent.UI_RESIZE))
				curFocus.addEventListener(WyyEvent.UI_RESIZE,onResizeUI);
		}
		/**
		 * 重新设置大小 
		 * @param event
		 * 
		 */		
		protected function onResizeUI(event:Event):void
		{
			var vo:PropertyBaseVo = model.voDict[curFocus];
			propertyView.data = vo;
		}
		//如果在拖动组件,表示只是设置坐标
		protected function onMouseMove(event:MouseEvent):void
		{
			var vo:PropertyBaseVo = model.voDict[curFocus];
			vo.setProperty("x",curFocus.x.toString());
			vo.setProperty("y",curFocus.y.toString());
			propertyView.data = vo;
			UIRect.inst.editUI = curFocus;
		}
		/**
		 * 鼠标抬起 
		 */		
		public function onItemUp():void
		{
			if(curFocus)
			{
				Sprite(curFocus).stopDrag();
				removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
				curFocus.removeEventListener(WyyEvent.UI_RESIZE,onResizeUI);
			}
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
		public function get curFocus():Sprite
		{
			return _curFocus;
		}
		/**
		 * @private
		 */
		public function set curFocus(value:Sprite):void
		{
			_curFocus = value;
		}
		
		public function clear():void
		{
			removeChildren();
			model.addVec = new Vector.<DisplayObject>();
			_curFocus = null;
		}

	}
}