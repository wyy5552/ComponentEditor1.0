package src.controls
{
	import containers.SDBasicsPane;
	import containers.SDPopupWin;
	
	import controls.SDLabelButton;
	
	import core.SDSprite;
	
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	
	import interfaces.ILabel;
	
	import mx.core.UIComponent;
	
	import src.events.CodeEvent;
	import src.events.ComponentEvent;
	import src.events.EditorEvents;
	import src.managers.UIFactory;
	import src.utils.CodeUtil;

	/**
	 * 导出成XML 
	 * @author yurs
	 * 
	 */	
	public class XMLControls
	{
		/**
		 * 当前界面的代码 
		 */		
		private var codeStr:String;
		
		/**
		 * 导入的代码 
		 */		
		private var importCodeStr:String;
		
		private var mainWin:Sprite;
		private var componentArr:Array;
		
		private var tempPanelArr:Array = [];
		private var tempPanel:SDSprite;
		
		public function XMLControls()
		{
			EditorEvents.dispathcer.addEventListener(CodeEvent.CREATE_CODE,createCode)
			EditorEvents.dispathcer.addEventListener(CodeEvent.IMPORT_CODE,importCode)
			EditorEvents.dispathcer.addEventListener(EditorEvents.GET_MAINWIN,getMainWin);
		}
		
		/**
		 * 获取主舞台 
		 * @param e
		 * 
		 */		
		private function getMainWin(e:EditorEvents):void
		{
			componentArr = e.data;
			mainWin = componentArr[0]["ui"];
		}
		
		/**
		 * 获取编码 
		 * @param e
		 * 
		 */		
		public function createCode(e:CodeEvent):void
		{
			codeStr = "";
			componentArr = e.data;
			mainWin = componentArr[0]["ui"];
			
			codeStr += "<win>\n";
			for(var i:Number = 0;i < componentArr.length;i++){
				if(i == 0){
					codeStr += "	"+getSingleUI(mainWin)+"\n";
					analyticUI(componentArr[i]["ui"]);
					codeStr += "	"+CodeUtil.getXMLEnd(mainWin)+"\n";
				}else{
					codeStr += "<"+componentArr[i].name+">\n"
					codeStr += getSingleUI(componentArr[i]["ui"])+"\n";
					analyticUI(componentArr[i]["ui"]);
					codeStr += CodeUtil.getXMLEnd(componentArr[i]["ui"])+"\n";
					codeStr += "</"+componentArr[i].name+">\n"
				}
			}
			codeStr += "</win>";
			
			EditorEvents.dispathcer.dispatchEvent(new EditorEvents(EditorEvents.CREATE_CODE_COMPLETE,codeStr));
		}
		
		/**
		 * 分析主容器编码
		 * @param win
		 * 
		 */		
		private function analyticUI(win:Sprite):void
		{
			var ui:SDSprite;
			var _emptyInt:int = 0;
			var i:Number = 0;
				
			for(i = 0;i < win.numChildren;i++){
				ui = win.getChildAt(i) as SDSprite;
				
				var tempUI:Sprite = ui;
				var length:Number = 0;
				var emptyStr:String = "";
				
				/**如果父级不是主容器开头的格数*/
				while(length < 999){
					if(tempUI.name == "win" || tempUI.parent.name == "customWin"){
						break;
					}
					tempUI = tempUI.parent as Sprite;
					if(!tempUI)break;
					length++
				}
				/**开头空格*/
				for(var j:Number = 0;j < length;j++){
					emptyStr += "	";
				}
				
				/**如果是容器则对子集继续操作*/
				if(ui is SDPopupWin || ui is SDBasicsPane){
					codeStr += emptyStr+getSingleUI(ui)+"\n";
					analyticUI(ui);
					codeStr += emptyStr+CodeUtil.getXMLEnd(ui)+"\n";
				}else{
					codeStr += emptyStr+getSingleUI(ui);
					codeStr += CodeUtil.getXMLEnd(ui)+"\n";
				}
			}
			if(win.name == "win"){
				ui = SDPopupWin(win).bottomPane;
				codeStr += "	  "+getSingleUI(ui)+"\n";
				for(i = 0;i < ui.numChildren;i++){
					codeStr += "	 		"+getSingleUI(ui.getChildAt(i) as Sprite);
					codeStr += CodeUtil.getXMLEnd(ui.getChildAt(i) as Sprite)+"\n";
				}
				codeStr += "	  "+CodeUtil.getXMLEnd(ui)+"\n";
			}
		}
		
		/**
		 * 获取单独组件编码
		 * @param ui
		 * @return 
		 * 
		 */		
		private function getSingleUI(ui:Sprite):String
		{
			return CodeUtil.getUIPropertyCode(ui,CodeUtil.XML);
		}
		
		/**
		 * 导入代码 
		 * @param e
		 * 
		 */		
		private function importCode(e:CodeEvent):void
		{
			importCodeStr = e.data;
			EditorEvents.dispathcer.dispatchEvent(new ComponentEvent(ComponentEvent.REMOVE_ALLCUSTOMUI));
			var codeXML:XML = new XML(importCodeStr)
			for(var i:Number = 0;i < codeXML.children().length();i++){
				tempPanel = null;
				if(i != 0){
					var customLayer:Sprite = new Sprite();
					customLayer.name = codeXML.children()[i].name().localName;
					customLayer.y = 40;
					var obj:Object = UIFactory.createUI(UIFactory.BasicsPane);
					var ui:Sprite = obj.ui;
					ui.name = obj.name;
					ui.x = codeXML.children()[i].children()[0].@x
					ui.y = codeXML.children()[i].children()[0].@y
					ui.width = codeXML.children()[i].children()[0].@width
					ui.height = codeXML.children()[i].children()[0].@height;
					customLayer.addChild(ui);
					customLayer.visible = false;
					EditorEvents.dispathcer.dispatchEvent(new ComponentEvent(ComponentEvent.IMPORT_CREATE_CUSTOMBTN,customLayer.name));
					EditorEvents.dispathcer.dispatchEvent(new ComponentEvent(ComponentEvent.IMPORT_CREATE_CUSTOMUI,[customLayer,ui]));
					mainWin = ui;
					
					analyticCode(codeXML.children()[i].children()[0].toString());
				}else{
					analyticCode(codeXML.children()[i].toString());
				}
			}
		}
		
		/**
		 * 解析代码XML 
		 * @param str
		 * 
		 */		
		private function analyticCode(str:String):void
		{
			var codeXML:XML = new XML(str)
			var obj:Object;	
			
			if(codeXML.@name == "win"){
				(mainWin as SDPopupWin).titleText = codeXML.@titleText;
				(mainWin as SDPopupWin).x = codeXML.@x;
				(mainWin as SDPopupWin).y = codeXML.@y;
				(mainWin as SDPopupWin).width = codeXML.@width;
				(mainWin as SDPopupWin).height = codeXML.@height;
			}
			
			for(var i:Number = 0;i < codeXML.children().length();i++){
				obj = new Object();	
				/**如果是底部按钮容器则跳过创建直接开始创建底部按钮*/
				if(codeXML.children()[i].@name == "bottomPane"){
					analyticCode(codeXML.children()[i].toString());
					continue;
				}
				
				obj.ui = UIFactory.createUI(codeXML.children()[i].name().localName).ui;
				obj.name = codeXML.children()[i].@name;
				
				/**如果父容器为底部按钮容器*/
				if(codeXML.@name == "bottomPane"){
					obj.parent = (mainWin as SDPopupWin).bottomPane;
				}else{
					obj.parent = (tempPanel)?tempPanel:mainWin;
				}
				
				obj.x = codeXML.children()[i].@x
				obj.y = codeXML.children()[i].@y
				obj.width = codeXML.children()[i].@width
				obj.height = codeXML.children()[i].@height;
				
				if(codeXML.children()[i].@name != undefined)obj.name 					 	= codeXML.children()[i].@name
				if(codeXML.children()[i].@label != undefined)obj.label 				 		= codeXML.children()[i].@label
				if(codeXML.children()[i].@labelPlacement != undefined)obj.labelPlacement	= codeXML.children()[i].@labelPlacement
				if(codeXML.children()[i].@fontSize != undefined)obj.fontSize	 		 	= codeXML.children()[i].@fontSize
				if(codeXML.children()[i].@fontFamily != undefined)obj.fontFamily 		 	= codeXML.children()[i].@fontFamily
				if(codeXML.children()[i].@color != undefined)obj.color 				 		= codeXML.children()[i].@color
				if(codeXML.children()[i].@isBold != undefined)obj.isBold 				 	= codeXML.children()[i].@isBold
				if(codeXML.children()[i].@textPadding != undefined)obj.textPadding  	 	= codeXML.children()[i].@textPadding
				if(codeXML.children()[i].@text != undefined)obj.text 					 	= codeXML.children()[i].@text
				if(codeXML.children()[i].@editable != undefined)obj.editable 			 	= codeXML.children()[i].@editable
				
				EditorEvents.dispathcer.dispatchEvent(new ComponentEvent(ComponentEvent.IMPORT_CREATEUI,obj));
				
				if(codeXML.children()[i].name().localName == UIFactory.BasicsPane){
					tempPanelArr.push(obj.ui);
					tempPanel = tempPanelArr[tempPanelArr.length-1];
					analyticCode(codeXML.children()[i].toString());
				}
				if(i+1==codeXML.children()[i].length() || codeXML.children()[i].length()==0)tempPanelArr.pop();
				if(tempPanelArr.length == 0)tempPanel = null;
			}
		}
	}
}