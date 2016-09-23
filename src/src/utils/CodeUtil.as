package src.utils
{
	import containers.SDPopupWin;
	
	import controls.SDLabel;
	import controls.SDLabelButton;
	
	import core.SDSprite;
	
	import flash.display.Sprite;
	import flash.utils.getQualifiedClassName;
	
	import interfaces.IButton;
	import interfaces.ILabel;
	
	import spark.utils.LabelUtil;

	/**
	 * 单个组件转换 
	 * @author yurs
	 * 
	 */	
	public class CodeUtil
	{
		public static var XML:Number = 1;
		public static var CODE:Number = 2;
		
		private static var currentType:Number = 1;
		
		public function CodeUtil()
		{
			
		}
		
		/**
		 * 获取组件属性信息 
		 * @param ui 组件 
		 * @param type 导出类型
		 * @return 
		 * 
		 */		
		public static function getUIPropertyCode(ui:Sprite,type:Number = 1):String
		{
			currentType = type;
			
			var str:String = "";
			
			if(currentType == 1)str += "<"+getQualifiedClassName(ui).split("::")[1];
			
			var propertyStr:String = "name,x,y,width,height,enabled";
			
			if(ui is ILabel){
				if(ui is SDLabel){
					propertyStr += LabelProprityUtil.findNotSame(ui,"text,fontSize,fontFamily,isBold,color,editable");
				}else{
					propertyStr += LabelProprityUtil.findNotSame(ui,"text,fontSize,fontFamily,isBold,color,editable,textPadding");
				}
			}
			if(ui is SDLabelButton){
				propertyStr += ButtonProprityUtil.findNotSame(ui,"label,fontSize,fontFamily,isBold,color,labelPlacement,textPadding");
			}	
			if(ui is SDPopupWin){
				propertyStr += ",titleText"
			}	
			
			str += getPropertyStr(ui,propertyStr);
			
			if(currentType == 1)str += ">"
			
			return str;
		}
		
		/**
		 * 获取单个属性
		 * @param ui
		 * @param property
		 * @return 
		 * 
		 */		
		private static function getPropertyStr(ui:Sprite,property:String):String
		{
			var propertyArr:Array = property.split(",");
			var propertyStr:String = "";
			var length:Number = propertyArr.length;
			for(var i:Number = 0;i < length;i++){
				switch(currentType)
				{
					case 1:
						propertyStr += " "+propertyArr[i]+'="'+ui[propertyArr[i]]+'"';
						break;
					case 2:
						
						break;
				}
			}
			return propertyStr;
		}
		
		/**
		 * 获取XML结尾 
		 * @param ui
		 * @return 
		 * 
		 */		
		public static function getXMLEnd(ui:Sprite):String
		{
			return "</"+getQualifiedClassName(ui).split("::")[1]+">";
		}
	}
}