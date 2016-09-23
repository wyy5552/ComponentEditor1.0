package src.controls
{
	import containers.SDPopupWin;
	
	import flash.events.MouseEvent;
	
	import mx.containers.Canvas;
	import mx.controls.Button;
	import mx.controls.TextArea;
	
	import src.MainEditor;
	import src.MenuPanel;
	import src.containers.CodePanel;
	import src.events.CodeEvent;
	import src.events.EditorEvents;
	import src.events.KeyEvent;

	/**
	 * 菜单控制器 
	 * @author yurs
	 * 
	 */	
	public class MenuControls
	{
		private var menuPanel:MenuPanel;
		
		private var importCodeBtn:Button;
		private var exportCodeBtn:Button;
		private var helpBtn:Button;
		private var codePanel:CodePanel;
		private var newBuildBtn:Button;
		
		private var winUIArr:Array;
		
		public function MenuControls(_menuPanel:MenuPanel)
		{
			menuPanel = _menuPanel;
			
			importCodeBtn = menuPanel.importCodeBtn;
			exportCodeBtn = menuPanel.exportCodeBtn;
			helpBtn = menuPanel.helpBtn;
			codePanel = menuPanel.codePanel;
			newBuildBtn = menuPanel.newBuild;
			
			EditorEvents.dispathcer.addEventListener(EditorEvents.GET_MAINWIN,function(e:EditorEvents):void{
				winUIArr = e.data});
			EditorEvents.dispathcer.addEventListener(EditorEvents.CREATE_CODE_COMPLETE,function(e:EditorEvents):void{
				codePanel.codeText.text = e.data});
			EditorEvents.dispathcer.addEventListener(KeyEvent.SAVE_CODE,function(e:KeyEvent):void{
				codeBtnClick(e.data)});
			importCodeBtn.addEventListener(MouseEvent.CLICK,function():void{codeBtnClick("import")});
			exportCodeBtn.addEventListener(MouseEvent.CLICK,function():void{codeBtnClick("export")});
			newBuildBtn.addEventListener(MouseEvent.CLICK,newBuild);
		}
		
		/**
		 * 新建
		 * @param e
		 * 
		 */		
		private function newBuild(e:MouseEvent):void
		{
			EditorEvents.dispathcer.dispatchEvent(new EditorEvents(EditorEvents.NEW_BUILD));
		}
		
		/**
		 * 生成代码 
		 * @param e
		 * 
		 */		
		private function codeBtnClick(name:String):void
		{
			MainEditor.isEditState = false;
			EditorEvents.dispathcer.dispatchEvent(new EditorEvents(EditorEvents.EDIT_STATE));
			
			for(var i:Number = 0;i < menuPanel.parent.numChildren;i++){
				if(menuPanel.parent.getChildAt(i) == codePanel){
					codePanel.codeBtn.removeEventListener(MouseEvent.CLICK,codeEnter);
					menuPanel.parent.removeChild(codePanel);
					return;
				}
			}
			
			if(menuPanel.parent)menuPanel.parent.addChild(codePanel);
			codePanel.codeBtn.addEventListener(MouseEvent.CLICK,codeEnter);
			codePanel.x = 100,codePanel.y = 100;
			
			if(name == "import"){
				codePanel.title = "导入代码"
				codePanel.codeText.text = "";
			}else if(name == "export"){
				codePanel.title = "导出代码"
				EditorEvents.dispathcer.dispatchEvent(new CodeEvent(CodeEvent.CREATE_CODE,winUIArr));
			}
		}
		
		/**
		 * 导入代码 
		 * @param e
		 * 
		 */		
		private function codeEnter(e:MouseEvent):void
		{
			if(menuPanel.parent)menuPanel.parent.removeChild(codePanel);
			if(codePanel.title == "导入代码")EditorEvents.dispathcer.dispatchEvent(new CodeEvent(CodeEvent.IMPORT_CODE,codePanel.codeText.text));
		}
	}
}