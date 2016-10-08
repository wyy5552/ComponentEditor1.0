package com.gamehero.sxd2.gui.core.util
{
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.system.ApplicationDomain;

	/**
	 * 为了节省代码量<br>
	 * <li>  添加sp
	 * <li>  移出sp
	 * @author weiyanyu
	 * 创建时间：2016-4-8 下午3:13:52
	 * 
	 */
	public class SpAddUtil
	{
		public function SpAddUtil()
		{
		}
		/**
		 *  
		 * @param parent 父容器
		 * @param child 子容器
		 * @param px 坐标x
		 * @param py 坐标y
		 * 
		 */		
		public static function add(parent:DisplayObjectContainer,child:DisplayObject,px:int = 0, py:int = 0):void
		{
			parent.addChild(child);
			child.x = px;
			child.y = py;
		}
		/**
		 * 回收显示对象 
		 * @param value
		 * 
		 */		
		public static function gc(value:DisplayObject):void
		{
			if(value)
			{
				if(value.parent)
				{
					value.parent.removeChild(value);
				}
				value = null;
			}
		}
		/**
		 * 获取按钮 
		 * @param domain
		 * @param value 资源名称前缀
		 * @return 
		 * 
		 */		
		public static function getBtn(domain:ApplicationDomain,value:String):Button
		{
			var up:BitmapData = getBD(domain,value + "_up");
			var down:BitmapData = getBD(domain,value + "_up");
			var over:BitmapData = getBD(domain,value + "_over");
			if(down == null)
			{
				return new Button(up,up,over);
			}
			else if(up == null)
			{
				return new Button(up,down,up)
			}
			else
			{
				return new Button(up,down,over);
			}
		}
		
		/**
		 * 获取某类
		 * */
		public static function getClass(domain:ApplicationDomain , className:String):Class
		{	
			var cls:Class;
			try
			{
				cls = domain.getDefinition(className) as Class;
			}
			catch(e:Error){}
			
			return cls;
		}
		
		
		/**
		 * 获取对应BitmapData 
		 */
		public static function getBD(domain:ApplicationDomain , className:String):BitmapData
		{	
			var cls:Class = getClass(domain, className);
			if(cls)
			{
				return new cls() as BitmapData;
			}
			return null;
		}
		
		
		/**
		 * 获取某类的对象
		 * */
		public static function getRes(domain:ApplicationDomain , className:String):Object
		{	
			var cls:Class = getClass(domain, className);
			if(cls)
			{
				return new cls();
			}
			return null;
		}
		
		
	}
}