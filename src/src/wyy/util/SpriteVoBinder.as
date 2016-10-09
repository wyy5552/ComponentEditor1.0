package src.wyy.util
{
	import com.gamehero.sxd2.gui.core.util.SpAddUtil;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	
	import src.wyy.model.ResourceModel;
	import src.wyy.vo.KeyValueVo;
	import src.wyy.vo.PropertyBaseVo;
	
	/**
	 * 组件与vo绑定<br>
	 * 方便两者统一管理
	 * @author weiyanyu
	 * 创建时间：2016-10-9 下午8:18:32
	 */
	public class SpriteVoBinder
	{
		
		public var dis:DisplayObject;
		
		public var vo:PropertyBaseVo;
		
		public function SpriteVoBinder(sp:DisplayObject,vo:PropertyBaseVo)
		{
			this.dis = sp;
			this.vo = vo;
			setProperty(vo);
		}
		
		/**
		 * 设置组件显示的属性 
		 * @param dis
		 * @param vo
		 * 
		 */		
		private function setProperty(vo:PropertyBaseVo):void
		{
			var kv:KeyValueVo;
			for(var i:int = 0; i < vo.deProperty.length; i++)
			{
				kv = vo.deProperty[i];
				setSingleProperty(kv.key,kv.value);
			}
		}
		
		public function setSingleProperty(key:String,value:String):void
		{
			var kv:KeyValueVo = vo.getProperty(key);
			kv.value = value;
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
		
	}
}