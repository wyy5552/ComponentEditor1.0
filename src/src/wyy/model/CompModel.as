package src.wyy.model
{
	import com.gamehero.sxd2.gui.core.button.YY_SkinSetBtn;
	import com.gamehero.sxd2.gui.core.label.ActiveLabel;
	import com.gamehero.sxd2.gui.core.util.SpAddUtil;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	import src.wyy.vo.KeyValueVo;
	import src.wyy.vo.PropertyBaseVo;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2016-9-27 下午6:25:13
	 */
	public class CompModel
	{
		private static var _instance: CompModel;
		public static function get inst(): CompModel
		{
			if(_instance == null)
				_instance = new  CompModel();
			return _instance;
		}
		
		[Embed(source="/assets/component.xml",mimeType = "application/octet-stream")]
		public var xmlClass:Class;
		
		/**
		 * 组件数组 ,只是用来初始化组件列表用
		 */		
		public var compArr:Array = new Array();
		/**
		 * key 元件类型  value 属性组 
		 */		
		public var dict:Dictionary = new Dictionary();
		
		public function CompModel()
		{
			if(_instance != null)
				throw "CompModel.as" + "is a SingleTon Class!!!";
			
			var xml:XML = XML(new xmlClass());
			var vo:PropertyBaseVo;
			var i:int;
			for each(var node:XML in xml.comp)
			{
				vo = new PropertyBaseVo();
				vo.fromXML(node);
				dict[vo.type] = vo;
				compArr.push(vo);
			}
		}
		
		/**
		 *  
		 * @param value
		 * @return 
		 * 
		 */		
		public static function getUIbyName(value:String):DisplayObject
		{
			var dis:Sprite;
			var property:PropertyBaseVo;
			switch(value)
			{
				case CompDict.YY_SkinSetBtn:
					dis = new YY_SkinSetBtn;	
					property = inst.dict[CompDict.YY_SkinSetBtn];
					break;
				case CompDict.YY_Label:
					dis = new ActiveLabel;
					property = inst.dict[CompDict.YY_Label];
					break;
				default:
					dis = new Sprite;
					property = inst.dict[CompDict.YY_Label];
			}
			dis.mouseEnabled = true;
			dis.mouseChildren = false;
			return setGraphics(dis,property);
		}
		
		public static function setGraphics(sp:Sprite,property:PropertyBaseVo):Sprite
		{
			sp.graphics.clear();
			sp.graphics.beginFill(0x00ff00,.2);
			sp.graphics.drawRect(0,0,int(property.getProperty("width").value),int(property.getProperty("height").value));
			sp.graphics.endFill();
			return sp;
		}
		
		/**
		 * 设置组件显示的属性 
		 * @param dis
		 * @param vo
		 * 
		 */		
		public static function setProperty(dis:DisplayObject,vo:PropertyBaseVo):void
		{
			var kv:KeyValueVo;
			for(var i:int = 0; i < vo.deProperty.length; i++)
			{
				kv = vo.deProperty[i];
				setSingleProperty(dis,kv);
			}
		}
		
		public static function setSingleProperty(dis:DisplayObject,kv:KeyValueVo):void
		{
			switch(kv.type)
			{
				case KeyValueVo.int_type:
				{
					dis[kv.key] = int(kv.value);
					break;
				}
				case KeyValueVo.bd_type:
					var url:Array = kv.value.split("~");
					var bd:BitmapData = SpAddUtil.getBD(ResourceModel.inst.getDomain(url[0]),url[1]);
					dis[kv.key] = bd;
					break;
				default:
				{
					dis[kv.key] = String(kv.value);
					break;
				}
			}
		}
		
		public static function getProperty(kv:KeyValueVo):String
		{
			var str:String = kv.key;
			switch(kv.type)
			{
				case KeyValueVo.int_type:
				{
					str = kv.key + " = " + kv.value;
					break;
				}
				case KeyValueVo.bd_type:
					var arr:Array = kv.value.split("~");
					str = kv.key + " = " + "SpAddUtil.getBD('"+ arr[0] + "','" + arr[1] + "')";
					break;
				default:
				{
					str = kv.key + " = " + "\"" + kv.value + "\"";
					break;
				}
			}
			return str;
		}
		
		
	}
}