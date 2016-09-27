package src.wyy.view
{
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.geom.Point;
	import flash.net.FileFilter;
	import flash.ui.Keyboard;
	
	import mx.controls.Button;
	import mx.core.UIComponent;
	
	import src.wyy.event.WyyEvent;
	import src.wyy.model.UIModel;
	import src.wyy.util.UICreater;
	import src.wyy.util.UIRect;
	import src.wyy.vo.DragObject;
	import src.wyy.vo.PropertyBaseVo;
	
	/**
	 * 最上层
	 * @author weiyanyu
	 * 创建时间：2016-9-22 下午4:05:19
	 */
	public class GlobalMdr
	{
		public var view:MyUI;
		
		public var cmp:ComponentView;
		
		public var ui:UIView;
		
		public var ppt:PropertyView;
		/**
		 * 当前拖动的 
		 */		
		public var curDrag:DragObject;
		/**
		 * 当前编辑的对象 
		 */		
		public var curFocus:DisplayObject;
		
		public var addVec:Vector.<DisplayObject> = new Vector.<DisplayObject>();
		
		public function GlobalMdr(ui:MyUI)
		{
			super();
			new UIRect();//实例化拖动点
			this.view = ui;
			
			this.cmp = ui.cmp;
			this.ui = ui.ui;
			this.ppt = ui.ppt;
			
			ui.addEventListener(Event.ADDED,onAdded);
		}
		
		protected function onAdded(event:Event):void
		{
			// TODO Auto-generated method stub
			cmp.addEventListener(WyyEvent.DRAG_COMPONENT,onStartDrag);
			view.stage.addEventListener(MouseEvent.MOUSE_UP,onStopDrag);
			//鼠标抬起
			ui.addEventListener(MouseEvent.MOUSE_UP,onUIUp);
			//鼠标点击ui编辑区域
			ui.addEventListener(MouseEvent.CLICK,onUIClick);
			
			ui.addEventListener(MouseEvent.ROLL_OVER,onUIOver);
			ui.addEventListener(MouseEvent.ROLL_OUT,onUIOut);
			
			
			view.saveBtn.addEventListener(MouseEvent.CLICK,onSaveCode);
			view.openBtn.addEventListener(MouseEvent.CLICK,onOpenCode);
		}
		
		private var _loadFile:File;
		
		protected function onOpenCode(event:MouseEvent):void
		{
			_loadFile = new File();
			_loadFile.addEventListener(Event.SELECT, selectFileHandler);
			var fileFilter:FileFilter = new FileFilter("游戏界面UI: (*.as)", "*.as");
			_loadFile.browseForOpen("游戏界面UI", [fileFilter]);
		}
		
		/**
		 * @param event
		 */
		private function selectFileHandler(event:Event):void {
			_loadFile.removeEventListener(Event.SELECT, selectFileHandler);
			_loadFile.addEventListener(Event.COMPLETE, loadFileCompleteHandler);
			_loadFile.load();
		}
		/**
		 * @param event
		 */
		private function loadFileCompleteHandler(event:Event):void 
		{
			ui.removeChildren();
			_loadFile.removeEventListener(Event.COMPLETE, loadFileCompleteHandler);
			addVec = UIModel.inst.analyse(String(_loadFile.data));
			for(var i:int = 0; i < addVec.length; i++)
			{
				ui.addChild(addVec[i]);
			}
		}	

		/**
		 * 生成代码 
		 * @param event
		 * 
		 */		
		protected function onSaveCode(event:MouseEvent):void
		{
			UIModel.inst.sava(addVec);
		}
		/**
		 * 鼠标在ui编辑区，则监听按键动作 
		 * @param event
		 * 
		 */		
		protected function onUIOver(event:MouseEvent):void
		{
			ui.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
		}
		protected function onUIOut(event:MouseEvent):void
		{
			ui.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
		}
		
		/**
		 * ui编辑器里面的ui被点击 
		 * @param event
		 * 
		 */		
		protected function onUIClick(event:MouseEvent):void
		{
			
			if(event.target is DisplayObject)
			{
				if(event.target != ui)
				{
					trace(event.target);
					curFocus = event.target as DisplayObject;
					UIRect.editUI = curFocus;
					
					ppt.ui = curFocus;
				}
			}
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
		 * 鼠标在ui编辑部分抬起 
		 * @param event
		 * 
		 */		
		protected function onUIUp(event:MouseEvent):void
		{
			if(curDrag != null)
			{
				var vo:PropertyBaseVo = curDrag.data as PropertyBaseVo;
				var dis:DisplayObject = UICreater.getUIbyName(vo.type)
				ui.addChild(dis);
				dis.x = ui.mouseX;
				dis.y = ui.mouseY;
				for(var i:int = 0; i < vo.deProperty.length; i++)
				{
					dis[vo.deProperty[i]] = vo.deValue[i];
				}
				
				addVec.push(dis);
			}
		}
		/**
		 * 舞台鼠标抬起，将拖拽的对象松掉 
		 * @param event
		 * 
		 */		
		protected function onStopDrag(event:MouseEvent):void
		{
			if(curDrag != null)
			{
				curDrag.stopDrag();
				view.removeElement(curDrag);
				curDrag = null;
			}
		}
		
		protected function onStartDrag(event:WyyEvent):void
		{
			curDrag = new DragObject();
			view.addElement(curDrag);
			curDrag.data = event.data;
			curDrag.x = view.mouseX;//设置到鼠标位置
			curDrag.y = view.mouseY;
			curDrag.startDrag();
		}
		
	}
}