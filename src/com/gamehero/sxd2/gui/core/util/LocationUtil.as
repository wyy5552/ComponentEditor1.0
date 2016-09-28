package com.gamehero.sxd2.gui.core.util
{
	import flash.display.DisplayObject;
	import flash.geom.Point;

	/**
	 * 组件位置的方法
	 * @author weiyanyu
	 * 创建时间：2015-12-12 下午4:01:27
	 * 
	 */
	public class LocationUtil
	{
		public function LocationUtil()
		{
		}
		/**
		 * 将small的坐标转换为相对big的坐标 
		 * @param big
		 * @param small
		 * @return 
		 * 
		 */		
		public static function localToLocal(big:DisplayObject,small:DisplayObject,loc:Point):Point
		{
			var p:Point;
			//将本地的转换为全局的
			var pt:Point = small.localToGlobal(loc);
			//将全局的转为局部的
			p = big.globalToLocal(pt);
			return p;
		}
		/**
		 * 让curSp的横坐标相对于 父容器的centerX点对齐
		 * @param curSp
		 * @param relySp
		 * 
		 */		
		public static function autoCenterX(curSp:DisplayObject,centerX:int):void
		{
			curSp.x = centerX - (curSp.width >> 1);
		}
		
		/**
		 * 让curSp的横坐标相对于 父容器的centerY点对齐
		 * @param curSp
		 * @param relySp
		 * 
		 */		
		public static function autoCenterY(curSp:DisplayObject,centerY:int):void
		{
			curSp.y = centerY - (curSp.height >> 1);
		}
	}
}