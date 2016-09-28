package com.gamehero.sxd2.gui.core.util
{
	import com.gamehero.sxd2.manager.DialogManager;
	
	import bowser.utils.time.TimeTick;

	/**
	 * 处理时间
	 * @author weiyanyu
	 * 创建时间：2016-6-30 上午10:39:07
	 * 
	 */
	public class TimeUtil
	{
		public function TimeUtil()
		{
		}
		
		/**
		 * 道具是否到期 
		 * @param value 秒s
		 * @return 
		 * 
		 */		
		public static function isTimeOut(value:uint):Boolean//道具是否到期
		{
			return value == 0 ? false : value <= TimeTick.inst.getCurrentTime2(); 
		}
		
		/**
		 * 道具是否到期 ,并且弹出道具过期提示
		 * @param value 秒s
		 * @return 
		 * 
		 */		
		public static function isTimeOutWithWarn(value:uint):Boolean//道具是否到期
		{
			var bool:Boolean = isTimeOut(value);
			if(bool)
				DialogManager.inst.showWarning("道具已过期");
			return bool;
		}
	}
}