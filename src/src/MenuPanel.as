package src
{
	import mx.containers.Canvas;
	import mx.containers.HBox;
	import mx.controls.Button;
	import mx.controls.TextArea;
	
	import src.containers.CodePanel;
	import src.controls.MenuControls;

	public class MenuPanel extends HBox
	{
		public var importCodeBtn:Button;
		public var exportCodeBtn:Button;
		public var helpBtn:Button;
		public var newBuild:Button;
		
		public var codePanel:CodePanel;
		/**
		 * 菜单控制器 
		 */		
		private var menuControls:MenuControls;
		
		public function MenuPanel()
		{
			this.setStyle("fontSize",12);
			
			importCodeBtn = new Button();
			importCodeBtn.label = "导入代码";
			importCodeBtn.name = "import";
			addChild(importCodeBtn);
			
			exportCodeBtn = new Button();
			exportCodeBtn.label = "导出代码";
			exportCodeBtn.name = "export";
			addChild(exportCodeBtn);
			
			codePanel = new CodePanel();
			
			helpBtn = new Button();
			helpBtn.label = "帮助";
			addChild(helpBtn);
			
			newBuild = new Button();
			newBuild.label = "新建";
			addChild(newBuild);
			
			menuControls = new MenuControls(this);
		}
	}
}