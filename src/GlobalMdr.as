package 
{
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	
	import src.wyy.event.WyyEvent;
	import src.wyy.model.CompModel;
	import src.wyy.model.ResourceModel;
	import src.wyy.util.BinderManager;
	import src.wyy.util.CodeParse;
	import src.wyy.view.ComponentView;
	import src.wyy.view.PropertyView;
	import src.wyy.view.UIAddPopWin;
	import src.wyy.view.UIRect;
	import src.wyy.view.UIView;
	import src.wyy.vo.DragObject;
	import src.wyy.vo.PropertyBaseVo;
	import src.wyy.vo.SpriteVoBinder;
	
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
		
		private var curAddUIPop:UIAddPopWin = new UIAddPopWin();
		
		
		public function GlobalMdr(myui:MyUI)
		{
			super();
			
			this.view = myui;
			
			this.cmp = myui.cmp;
			this.ui = myui.ui;
			this.ppt = myui.ppt;
			this.ui.propertyView = ppt;
			this.ui.init();
			
			myui.addEventListener(Event.ADDED,onAdded);
		}
		
		protected function onAdded(event:Event):void
		{
			// TODO Auto-generated method stub
			cmp.addEventListener(WyyEvent.DRAG_COMPONENT,onStartDrag);
			view.stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			//鼠标抬起
			ui.addEventListener(MouseEvent.MOUSE_UP,onUIUp);
			
			view.saveBtn.addEventListener(MouseEvent.CLICK,onSaveCode);
			view.openBtn.addEventListener(MouseEvent.CLICK,onOpenCode);
			view.addSource.addEventListener(MouseEvent.CLICK,onAddSource);
			
		}
		private var _loadFile:File;
		protected function onAddSource(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			ResourceModel.inst.addSource();
		}
		
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
			ui.clear();
			_loadFile.removeEventListener(Event.COMPLETE, loadFileCompleteHandler);
			var addVec:Vector.<DisplayObject> = CodeParse.inst.analyse(String(_loadFile.data));
			for(var i:int = 0; i < addVec.length; i++)
			{
				ui.addItem(addVec[i],null);
			}
		}	

		/**
		 * 生成代码 
		 * @param event
		 * 
		 */		
		protected function onSaveCode(event:MouseEvent):void
		{
			CodeParse.inst.sava();
		}
		
		/**
		 * 鼠标在ui编辑部分抬起 <br>
		 * 添加ui
		 * @param event
		 * 
		 */		
		protected function onUIUp(event:MouseEvent):void
		{
			if(curDrag != null)
			{
				var vo:PropertyBaseVo = curDrag.data as PropertyBaseVo;
				
				curAddUIPop.data = vo;
				PopUpManager.addPopUp(curAddUIPop,FlexGlobals.topLevelApplication as DisplayObjectContainer);
				PopUpManager.centerPopUp(curAddUIPop);
				curAddUIPop.addEventListener(Event.REMOVED_FROM_STAGE,onClosePop);
				//先把组件添加到舞台，然后强制设置名字
				var dis:DisplayObject = CompModel.getUIbyName(vo.type);
				BinderManager.inst.bind(dis,vo);
				var binder:SpriteVoBinder = BinderManager.inst.getBinder(dis);
				BinderManager.setGraphics(dis as Sprite);
				binder.setSingleProperty("x",ui.mouseX.toString());
				binder.setSingleProperty("y",ui.mouseY.toString());
				ui.addItem(dis,vo);
				function onClosePop(event:Event):void
				{
					curAddUIPop.removeEventListener(Event.REMOVED_FROM_STAGE,onClosePop);
				}
			}
		}
		
		/**
		 * 舞台鼠标抬起<br>
		 * 鼠标抬起动作要统一处理，而不是单独处理某一个组件的鼠标抬起动作
		 * @param event
		 * 
		 */		
		protected function onMouseUp(event:MouseEvent):void
		{
			UIRect.inst.onMouseUp();
			ui.onItemUp();
			
			if(curDrag != null)
			{
				curDrag.stopDrag();
				view.removeElement(curDrag);
				curDrag = null;
			}
		}
		/**
		 * 拖动组件列表里面的组件
		 * @param event
		 * 
		 */		
		protected function onStartDrag(event:WyyEvent):void
		{
			curDrag = new DragObject();
			view.addElement(curDrag);
			curDrag.data = event.data;
			curDrag.x = view.mouseX;//设置到鼠标位置
			curDrag.y = view.mouseY;
			var vo:PropertyBaseVo = event.data as PropertyBaseVo;
			curDrag.setSize(int(vo.getProperty("width").value), int(vo.getProperty("height").value));
			curDrag.startDrag();
		}
		
	}
}