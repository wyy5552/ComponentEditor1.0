package com.gamehero.sxd2.gui.core.frame
{
	import com.gamehero.sxd2.services.GameService;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2016-2-14 下午2:39:45
	 * 
	 */
	public class GameMedia extends Mediator
	{
		protected var service:GameService;
		
		public function GameMedia()
		{
			super();
			service = GameService.instance;
		}
	}
}