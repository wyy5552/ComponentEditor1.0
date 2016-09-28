package com.gamehero.sxd2.gui.core.interFace
{
	import com.gamehero.sxd2.pro.PRO_Hero;
	import com.gamehero.sxd2.vo.HeroVO;

	/**
	 * 提供伙伴相关数据
	 * PRO_Hero  pro数据
	 * HeroVO    vo数据
	 * */
	public interface IHeroData
	{
		function get heroPro():PRO_Hero;
		
		function get heroVo():HeroVO;
	}
}