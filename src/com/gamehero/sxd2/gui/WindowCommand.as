package com.gamehero.sxd2.gui
{
    import com.gamehero.sxd2.data.GameData;
    import com.gamehero.sxd2.data.WorldBossData;
    import com.gamehero.sxd2.event.WindowEvent;
    import com.gamehero.sxd2.gui.HeroExtend.HeroExtendAlertWindow;
    import com.gamehero.sxd2.gui.HeroReslove.HeroResloveAlertWindow;
    import com.gamehero.sxd2.gui.HurdleReport.HurdleReportWindow;
    import com.gamehero.sxd2.gui.SevenDay.SevenDayActivityWindow;
    import com.gamehero.sxd2.gui.answer.AnswerAwardWindow;
    import com.gamehero.sxd2.gui.answer.AnswerWindow;
    import com.gamehero.sxd2.gui.antiAddiction.AntiAddictionWindow;
    import com.gamehero.sxd2.gui.arena.ArenaRankWindow;
    import com.gamehero.sxd2.gui.arena.ArenaRewardWindow;
    import com.gamehero.sxd2.gui.arena.ArenaView;
    import com.gamehero.sxd2.gui.bag.BagWindow;
    import com.gamehero.sxd2.gui.blackMarket.BlackMarketWindow;
    import com.gamehero.sxd2.gui.blackMarket.trade.view.log.TradeLogWindow;
    import com.gamehero.sxd2.gui.blackMarket.trade.view.priceChange.TradeChangePriceWindow;
    import com.gamehero.sxd2.gui.blackMarket.trade.view.puton.TradePutOnWindow;
    import com.gamehero.sxd2.gui.buyback.BuybackWindow;
    import com.gamehero.sxd2.gui.changeLog.ChangeLogWindow;
    import com.gamehero.sxd2.gui.chat.ChatHistoryWindow;
    import com.gamehero.sxd2.gui.chat.ChatWindow;
    import com.gamehero.sxd2.gui.convoy.ConvoyMessengerWindow;
    import com.gamehero.sxd2.gui.convoy.ConvoyResultWindow;
    import com.gamehero.sxd2.gui.convoy.ConvoySeaonWindow;
    import com.gamehero.sxd2.gui.core.WindowManager;
    import com.gamehero.sxd2.gui.core.WindowPostion;
    import com.gamehero.sxd2.gui.dailyActivity.DailyActivityWindow;
    import com.gamehero.sxd2.gui.endless.EndlessWindow;
    import com.gamehero.sxd2.gui.equips.EquipWindow;
    import com.gamehero.sxd2.gui.equips.inlayGold.InlayGoldWindow;
    import com.gamehero.sxd2.gui.expRoom.expRoomWindow.ExpRoomWindow;
    import com.gamehero.sxd2.gui.fate.FateWindow;
    import com.gamehero.sxd2.gui.fateCell.FateCellWindow;
    import com.gamehero.sxd2.gui.fateCell.oneKey.FateCellOneKeyWindow;
    import com.gamehero.sxd2.gui.firstCharge.FirstChargeWindow;
    import com.gamehero.sxd2.gui.firstCharge.firstChargeReward.FirstChargeHeroWindow;
    import com.gamehero.sxd2.gui.flower.view.FlowerRankWindow;
    import com.gamehero.sxd2.gui.flower.view.FlowerSendWindow;
    import com.gamehero.sxd2.gui.flower.view.MyFlowerWindow;
    import com.gamehero.sxd2.gui.formation.FormationWindow;
    import com.gamehero.sxd2.gui.friend.AddFriendWindow;
    import com.gamehero.sxd2.gui.friend.AudienceTipBoxWindow;
    import com.gamehero.sxd2.gui.friend.FriendWindow;
    import com.gamehero.sxd2.gui.friend.HeadPortraitWindow;
    import com.gamehero.sxd2.gui.friend.MyAudienceWindow;
    import com.gamehero.sxd2.gui.giftStore.GiftStoreWindow;
    import com.gamehero.sxd2.gui.guild.activity.godFete.view.GodFeteWindow;
    import com.gamehero.sxd2.gui.guild.activity.guildShop.view.GuildShopWindow;
    import com.gamehero.sxd2.gui.guild.activity.guildShop.view.MyDemandWindow;
    import com.gamehero.sxd2.gui.guild.activity.sevenSealDevil.view.SevenStarDevilWindow;
    import com.gamehero.sxd2.gui.guild.activity.sevenSealDevil.view.SevenStarRewardWindow;
    import com.gamehero.sxd2.gui.guild.view.CreateGuildWindow;
    import com.gamehero.sxd2.gui.guild.view.GuildDetailWindow;
    import com.gamehero.sxd2.gui.guild.view.GuildSettingWindow;
    import com.gamehero.sxd2.gui.guild.view.GuildWindow;
    import com.gamehero.sxd2.gui.guild.view.MyGuildWindow;
    import com.gamehero.sxd2.gui.guildVS.GuildVSReportWindow;
    import com.gamehero.sxd2.gui.guildVS.GuildVSWatchWindow;
    import com.gamehero.sxd2.gui.heroAdvance.HeroAdvanceWindow;
    import com.gamehero.sxd2.gui.heroGift.HeroGiftWindow;
    import com.gamehero.sxd2.gui.heroGift.heroEat.HeroBatchEatWindow;
    import com.gamehero.sxd2.gui.heroGift.heroEat.HeroEatWindow;
    import com.gamehero.sxd2.gui.heroHandbook.HeroHandbookWindow;
    import com.gamehero.sxd2.gui.hotActivity.view.HotActivityWindow;
    import com.gamehero.sxd2.gui.huntFate.HuntFateWindow;
    import com.gamehero.sxd2.gui.hurdleClear.HurdleClearOutWindow;
    import com.gamehero.sxd2.gui.hurdleGuide.HurdleBoxWindow;
    import com.gamehero.sxd2.gui.hurdleGuide.HurdleGuideWindow;
    import com.gamehero.sxd2.gui.levelGift.LevelGiftWindow;
    import com.gamehero.sxd2.gui.mail.MailWindow;
    import com.gamehero.sxd2.gui.main.MainUI;
    import com.gamehero.sxd2.gui.main.RenameWindow;
    import com.gamehero.sxd2.gui.mammon.MammonPoolWindow;
    import com.gamehero.sxd2.gui.mammon.MammonWindow;
    import com.gamehero.sxd2.gui.microClient.MicroClientWindow;
    import com.gamehero.sxd2.gui.npc.NpcWindow;
    import com.gamehero.sxd2.gui.player.playerView.PlayerDetailWindow;
    import com.gamehero.sxd2.gui.player.playerView.PlayerWindow;
    import com.gamehero.sxd2.gui.player.playerView.playerEdit.PlayerEditWindow;
    import com.gamehero.sxd2.gui.passiveSkill.PassiveSkillWindow;
    import com.gamehero.sxd2.gui.player.changeAvatar.ChangeAvatarWindow;
    import com.gamehero.sxd2.gui.player.equip.PlayerEquipDetailWindow;
    import com.gamehero.sxd2.gui.player.equip.PlayerEquipWindow;
    import com.gamehero.sxd2.gui.player.hero.HeroDetailWindow;
    import com.gamehero.sxd2.gui.player.hero.HeroWindow;
    import com.gamehero.sxd2.gui.playerPhotoCut.PlayerCutPhotoWindow;
    import com.gamehero.sxd2.gui.powerCompare.PowerCompareWindow;
    import com.gamehero.sxd2.gui.preWar.PreWarWindow;
    import com.gamehero.sxd2.gui.prestige.PrestigeWindow;
    import com.gamehero.sxd2.gui.redBag.view.ChatGrabRedBagWindow;
    import com.gamehero.sxd2.gui.redBag.view.ChatSendRedBagWindow;
    import com.gamehero.sxd2.gui.redBag.view.GuildRedBagWindow;
    import com.gamehero.sxd2.gui.redBag.view.RedBagLogWindow;
    import com.gamehero.sxd2.gui.redBag.view.RedBagResultWindow;
    import com.gamehero.sxd2.gui.redBag.view.SendRedBagWindow;
    import com.gamehero.sxd2.gui.roleSkill.RoleSkillView;
    import com.gamehero.sxd2.gui.seekDevice.view.InviteFriendWindow;
    import com.gamehero.sxd2.gui.seekDevice.view.SeekDeviceWindow;
    import com.gamehero.sxd2.gui.sixDestinies.view.SixDestinesWindow;
    import com.gamehero.sxd2.gui.skyLadder.view.SkyLadderDailyWindow;
    import com.gamehero.sxd2.gui.skyLadder.view.SkyLadderRankWindow;
    import com.gamehero.sxd2.gui.skyLadder.view.SkyLadderSeasonWindow;
    import com.gamehero.sxd2.gui.skyLadder.view.SkyLadderWindow;
    import com.gamehero.sxd2.gui.stock.StockDealWindow;
    import com.gamehero.sxd2.gui.stock.StockStoreWindow;
    import com.gamehero.sxd2.gui.stock.StockWindow;
    import com.gamehero.sxd2.gui.suplly.SupllyNoticeWindow;
    import com.gamehero.sxd2.gui.systemSettings.SystemSettingsWindow;
    import com.gamehero.sxd2.gui.takeCards.TakeCardsWindow;
    import com.gamehero.sxd2.gui.tower.TowerBuffWindow;
    import com.gamehero.sxd2.gui.tower.TowerResetWindow;
    import com.gamehero.sxd2.gui.tower.TowerScoreWindow;
    import com.gamehero.sxd2.gui.tower.TowerWindow;
    import com.gamehero.sxd2.gui.vip.VipWindow;
    import com.gamehero.sxd2.gui.vipCard.VipCardDetailWindow;
    import com.gamehero.sxd2.gui.vipCard.VipCardWindow;
    import com.gamehero.sxd2.gui.washEquip.WashEquipWindow;
    import com.gamehero.sxd2.gui.washEquip.view.washEquipBatchWindow.WashEquipBatchWindow;
    import com.gamehero.sxd2.gui.washEquip.view.washEquipExchaWindow.WashEquipExchangeWindow;
    import com.gamehero.sxd2.gui.washEquip.view.washEquipStrenWindow.WashEquipStrenWindow;
    import com.gamehero.sxd2.gui.welfare.WelfareWindow;
    import com.gamehero.sxd2.gui.worldBossUI.WorldBossHintWindow;
    import com.gamehero.sxd2.gui.worldBossUI.WorldBossWindow;
    import com.gamehero.sxd2.guide.gui.ProduceGuideWindow;
    import com.gamehero.sxd2.local.Lang;
    import com.gamehero.sxd2.manager.DialogManager;
    import com.gamehero.sxd2.manager.GuideManager;
    import com.gamehero.sxd2.proxy.GameProxy;
    import com.gamehero.sxd2.world.model.MapModel;
    import com.gamehero.sxd2.world.model.MapTypeDict;
    
    import flash.events.IEventDispatcher;
    
    import robotlegs.bender.bundles.mvcs.Command;
	
	
	/**
	 * 弹出窗口command
	 * @author xuwenyi
	 * @create 2013-08-15
	 **/
	public class WindowCommand extends Command
	{
		[Inject]
		public var windowEvent:WindowEvent;
		[Inject]
		public var eventDispatch:IEventDispatcher;
		[Inject]
		public var sxd2main:SXD2Main;
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function WindowCommand()
		{
			super();
		}
		
		
		override public function execute():void 
		{
			var type:String = windowEvent.type;
			var windowName:String = windowEvent.windowName;
			var windowParam:Object = windowEvent.data;
			var isAutoClose:Boolean = windowEvent.isAutoClose;
			
			// 打开窗口指令
			if(type == WindowEvent.OPEN_WINDOW)
			{
				switch(windowName)
				{
					//练功房
					case WindowEvent.EXP_ROOM_WINDOW:
					//护送
					case WindowEvent.CONVOY_WINDOW:
					//领地攻防战
					case WindowEvent.GUILD_VS_WINDOW:
						sxd2main.showFullScreenView(windowEvent.windowName,windowParam);
						break;
					//主角技能
					case WindowEvent.ROLESKILL_VIEW:
						WindowManager.inst.openWindow(RoleSkillView,WindowPostion.CENTER,false,false,isAutoClose,windowParam);
						break;
					
					//打开伙伴面板
					case WindowEvent.HERO_WINDOW:
						WindowManager.inst.openWindow(HeroWindow, WindowPostion.CENTER_LEFT, false, true, isAutoClose, windowParam,[BagWindow,HeroDetailWindow,HeroAdvanceWindow]);
						break;
					
					//伙伴详细信息面板
					case WindowEvent.HERO_DETAIL_WINDOW:
						WindowManager.inst.openWindow(HeroDetailWindow, WindowPostion.CENTER, false, true, isAutoClose, windowParam,[BagWindow,HeroWindow,HeroAdvanceWindow,PlayerWindow]);
						break;
					
					//图鉴
					case WindowEvent.HERO_HANDBOOK_WINDOW:
						WindowManager.inst.openWindow(HeroHandbookWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					
					//图鉴分解窗口
					case WindowEvent.HERO_RESLOVE_ALERT_WINDOW:
						WindowManager.inst.openWindow(HeroResloveAlertWindow, WindowPostion.CENTER_ONLY, true, false, isAutoClose, windowParam,[HeroHandbookWindow]);
						break;
					
					//伙伴传承窗口
					case WindowEvent.HERO_EXTEND_ALERT_WINDOW:
						WindowManager.inst.openWindow(HeroExtendAlertWindow, WindowPostion.CENTER_ONLY, true, false, isAutoClose, windowParam,[HeroHandbookWindow]);
						break;
					
					//伙伴突破
					case WindowEvent.HERO_ADVANCE_WINDOW:
						WindowManager.inst.openWindow(HeroAdvanceWindow, WindowPostion.CENTER_RIGHT, false, true, isAutoClose, windowParam,[HeroWindow,HeroDetailWindow]);
						break;
					
					//布阵面板
					case WindowEvent.FORMATION_WINDOW:
						WindowManager.inst.openWindow(FormationWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					
					//背包
					case WindowEvent.BAG_WINDOW:
						WindowManager.inst.openWindow(BagWindow, WindowPostion.CENTER_RIGHT, false, true, isAutoClose, windowParam,[BuybackWindow,HeroDetailWindow,HeroWindow]);
						break;
					
					//剧情副本导航
					case WindowEvent.HURDLE_GUIDE_WINDOW:
						WindowManager.inst.openWindow(HurdleGuideWindow, WindowPostion.CENTER, false, false, isAutoClose, windowParam,[HurdleClearOutWindow,HurdleBoxWindow]);
						break;
					
					//任务面板
					case WindowEvent.TASK_WINDOW:
						WindowManager.inst.openWindow(NpcWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					//副本扫荡
					case WindowEvent.HURDLE_CLEAROUT_WINDOW:
						WindowManager.inst.openWindow(HurdleClearOutWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam,[HurdleGuideWindow]);
						break;
					//宝箱
					case WindowEvent.HURDLE_BOX_WINDOW:
						WindowManager.inst.openWindow(HurdleBoxWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam,[HurdleGuideWindow]);
						break;
					//副本攻略
					case WindowEvent.HURDLE_REPORT_WINDOW:
						WindowManager.inst.openWindow(HurdleReportWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					//装备面板
					case WindowEvent.EQUIP_WINDOW:
						WindowManager.inst.openWindow(EquipWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					//镀金
					case WindowEvent.INLAYGOLD_WINDOW:
						WindowManager.inst.openWindow(InlayGoldWindow, WindowPostion.CENTER_ONLY, true, false, isAutoClose, windowParam,[EquipWindow]);
						break;
					//回购店
					case WindowEvent.BUYBACK_WINDOW:
						WindowManager.inst.openWindow(BuybackWindow, WindowPostion.CENTER_RIGHT, false, false, isAutoClose, windowParam,[BagWindow]);
						break;
					//黑市
					case WindowEvent.BLACKMARKET_WINDOW:
						WindowManager.inst.openWindow(BlackMarketWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					//交易记录
					case WindowEvent.TRADE_LOG_WINDOW:
						WindowManager.inst.openWindow(TradeLogWindow, WindowPostion.CENTER_ONLY, true, false, isAutoClose, windowParam,[BlackMarketWindow]);
						break;
					//上架
					case WindowEvent.TRADE_PUTON_WINDOW:
						WindowManager.inst.openWindow(TradePutOnWindow, WindowPostion.CENTER_ONLY, true, false, isAutoClose, windowParam,[BlackMarketWindow]);
						break;
					//改价
					case WindowEvent.TRADE_CHANGEPRICE_WINDOW:
						WindowManager.inst.openWindow(TradeChangePriceWindow, WindowPostion.CENTER_ONLY, true, false, isAutoClose, windowParam,[BlackMarketWindow]);
						break;
					//邮件
					case WindowEvent.MAIL_WINDOW:
						WindowManager.inst.openWindow(MailWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					//抽卡
					case WindowEvent.TAKE_CARDS_WINDOW:
						WindowManager.inst.openWindow(TakeCardsWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					//命途
					case WindowEvent.FATE_WINDOW:
						if(!WindowManager.inst.isWindowOpened(FateWindow))
							WindowManager.inst.openWindow(FateWindow, WindowPostion.CENTER_ONLY, true, false, isAutoClose, windowParam);	
						break;
					//道具产出
					case WindowEvent.PRODUCE_GUIDE_WINDOW:
						WindowManager.inst.openWindow(ProduceGuideWindow, WindowPostion.CENTER_ONLY, true, true, isAutoClose, windowParam);
						break;
					//私聊窗口
					case WindowEvent.CHAT_WINDOW:
						if(GameData.inst.getOpenFuncByName(WindowEvent.CHAT_WINDOW))
							WindowManager.inst.openWindow(ChatWindow, WindowPostion.CENTER, false, true, isAutoClose, windowParam ,[MyGuildWindow,FriendWindow]);
						break;
					//私聊聊天记录
					case WindowEvent.CHATHISTORY_WINDOW:
						if(GameData.inst.getOpenFuncByName(WindowEvent.CHAT_WINDOW))
							WindowManager.inst.openWindow(ChatHistoryWindow, WindowPostion.CENTER_RIGHT, false, true, isAutoClose, windowParam);
						break;
					//好友列表
					case WindowEvent.FRIEND_WINDOW:
						if(GameData.inst.getOpenFuncByName(WindowEvent.FRIEND_WINDOW))
							WindowManager.inst.openWindow(FriendWindow, WindowPostion.CENTER_LEFT, false, true, isAutoClose, windowParam ,[MyAudienceWindow,HeadPortraitWindow,AudienceTipBoxWindow]);
						break;
					//听众窗口
					case WindowEvent.MY_AUDIENCE_WINDOW:
						if(GameData.inst.getOpenFuncByName(WindowEvent.FRIEND_WINDOW))
							WindowManager.inst.openWindow(MyAudienceWindow, WindowPostion.CENTER_RIGHT, false, true, isAutoClose, windowParam,[FriendWindow,AudienceTipBoxWindow,AddFriendWindow]);
						break;
					//关注提示
					case WindowEvent.AUDIENCE_TIPBOX_WINDOW:
						if(GameData.inst.getOpenFuncByName(WindowEvent.FRIEND_WINDOW))
							WindowManager.inst.openWindow(AudienceTipBoxWindow, WindowPostion.CENTER_ONLY, true, true, isAutoClose, windowParam);
						break;
					//头像
					case WindowEvent.HEAD_PORTSIT_WINDOW:
						if(GameData.inst.getOpenFuncByName(WindowEvent.FRIEND_WINDOW))
							WindowManager.inst.openWindow(HeadPortraitWindow, WindowPostion.CENTER_LEFT, false, true, isAutoClose, windowParam,[AudienceTipBoxWindow,AddFriendWindow,FriendWindow]);
						break;
					//声望
					case WindowEvent.PRESTIGE_WINDOW:
						WindowManager.inst.openWindow(PrestigeWindow, WindowPostion.CENTER_LEFT, false, false, isAutoClose, windowParam);
						break;
					//添加好友	
					case WindowEvent.ADD_FRIEND:
						if(GameData.inst.getOpenFuncByName(WindowEvent.FRIEND_WINDOW))
							WindowManager.inst.openWindow(AddFriendWindow, WindowPostion.CENTER_ONLY, false, true, isAutoClose, windowParam);
						break;
					//招财
					case WindowEvent.MAMMON_WINDOW:
						WindowManager.inst.openWindow(MammonWindow, WindowPostion.CENTER_LEFT, false, false, isAutoClose, windowParam);
						break;
					//更新日志
					case WindowEvent.CHANGELOG_WINDOW:
						WindowManager.inst.openWindow(ChangeLogWindow, WindowPostion.CENTER, false, false, isAutoClose, windowParam);
						break;
					//招财抽奖
					case WindowEvent.MAMMON_POOL_WINDOW:
						WindowManager.inst.openWindow(MammonPoolWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					//器灵
					case WindowEvent.PLAYER_EQUIP_WINDOW:
						WindowManager.inst.openWindow(PlayerEquipWindow, WindowPostion.CENTER_RIGHT, false, false, isAutoClose, windowParam);
						break;
					//器灵详情
					case WindowEvent.PLAYER_EQUIP_DETAIL_WINDOW:
						WindowManager.inst.openWindow(PlayerEquipDetailWindow, WindowPostion.CENTER_LEFT, false, true, isAutoClose, windowParam);
						break;
					//帮派
					case WindowEvent.Guild_WINDOW:
					//我的帮派
					case WindowEvent.MY_GUILD_WINDOW:
						//世界boss不进入帮会
						if(MapModel.inst.mapVo.type == MapTypeDict.BOSS_MAP)
						{
							DialogManager.inst.showPrompt(Lang.instance.trans("guild_tips_14"));
						}
						else
						{
							if(GameData.inst.playerInfo.guildId  > 0)
							{
								WindowManager.inst.openWindow(MyGuildWindow, WindowPostion.CENTER, false, true, isAutoClose, windowParam,[GuildSettingWindow,GuildDetailWindow]);
							}
							else
							{
								WindowManager.inst.openWindow(GuildWindow, WindowPostion.CENTER_RIGHT, false, true, isAutoClose, windowParam,[CreateGuildWindow,GuildDetailWindow]);
							}
						}
						break;
					//查看帮派
					case WindowEvent.Guild_DETAIL_WINDOW:
						WindowManager.inst.openWindow(GuildDetailWindow, WindowPostion.CENTER_RIGHT, false, true, isAutoClose, windowParam,[GuildWindow,CreateGuildWindow,MyGuildWindow]);
						break;
					//创建帮派
					case WindowEvent.CREATE_GUILD_WINDOW:
						WindowManager.inst.openWindow(CreateGuildWindow, WindowPostion.CENTER_ONLY, false,true, isAutoClose, windowParam,[GuildWindow,GuildDetailWindow]);
						break;
					//帮派设置
					case WindowEvent.GUILD_SETTING_WINDOW:
						WindowManager.inst.openWindow(GuildSettingWindow, WindowPostion.CENTER_ONLY, false, true, isAutoClose, windowParam,[MyGuildWindow]);
						break
					//探灵
					case WindowEvent.SEEK_DEVICE_WINDOW:
						WindowManager.inst.openWindow(SeekDeviceWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					//探灵邀请
					case WindowEvent.SEEK_DEVICE_INVITE:
						WindowManager.inst.openWindow(InviteFriendWindow, WindowPostion.CENTER, false, false, isAutoClose, windowParam);
						break;
					//系统设置
					case WindowEvent.SYSTEM_SETTINGS_WINDOW:
						WindowManager.inst.openWindow(SystemSettingsWindow, WindowPostion.CENTER, false, false, isAutoClose, windowParam);
						break;
					//世界Boss
					case WindowEvent.WORLD_BOSS_WINDOW:
						if(WorldBossData.inst.worldBossCountStatus && (WorldBossData.inst.worldBossCountStatus.status == WorldBossData.inst.WORLD_BOSS_READY || WorldBossData.inst.worldBossCountStatus.status == WorldBossData.inst.WORLD_BOSS_START))
						{
							SXD2Main.inst.enterWorldBoss(1);
						}
						else
							WindowManager.inst.openWindow(WorldBossWindow, WindowPostion.CENTER, false, false, isAutoClose, windowParam);
						break;
					//世界Boss
					case WindowEvent.WROLDBOSS_HINT_WINDOW:
							WindowManager.inst.openWindow(WorldBossHintWindow, WindowPostion.CENTER, false, false, false, windowParam);
						break;
					//七星封魔
					case WindowEvent.SEVEN_STAR_DEVIL_WINDOW:
						if(GameData.inst.playerInfo.guildId  > 0)
							WindowManager.inst.openWindow(SevenStarDevilWindow, WindowPostion.CENTER, false, false, isAutoClose, windowParam ,[SevenStarRewardWindow]);
						break;
					//七星封魔碑文奖励
					case WindowEvent.SEVEN_STAR_REWARD_WINDOW:
						WindowManager.inst.openWindow(SevenStarRewardWindow, WindowPostion.CENTER, false, false, isAutoClose, windowParam ,[SevenStarDevilWindow]);
						break;
					//福利大厅
					case WindowEvent.WELFARE_WINDOW:
						WindowManager.inst.openWindow(WelfareWindow, WindowPostion.CENTER, false, false, isAutoClose, windowParam ,[SevenStarDevilWindow]);
						break;
					//日常活动
					case WindowEvent.DAILYACTIVITY_WINDOW:
						WindowManager.inst.openWindow(DailyActivityWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					//猎命
					case WindowEvent.HUNTFATE_WINDOW:
						WindowManager.inst.openWindow(HuntFateWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					//命格
					case WindowEvent.FATECELL_WINDOW:
						WindowManager.inst.openWindow(FateCellWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					//命格
					case WindowEvent.FATECELL_ONEKEY_WINDOW:
						WindowManager.inst.openWindow(FateCellOneKeyWindow, WindowPostion.CENTER_ONLY, true, false, isAutoClose, windowParam,[FateCellWindow]);
						break;
					//祭神
					case WindowEvent.GOD_FETE_WINDOW:
						WindowManager.inst.openWindow(GodFeteWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					//爬塔
					case WindowEvent.TOWER_WINDOW:
						WindowManager.inst.openWindow(TowerWindow, WindowPostion.CENTER_RIGHT, false, false, isAutoClose, windowParam);
						break;
					//爬塔buff
					case WindowEvent.TOWER_BUFF_WINDOW:
						WindowManager.inst.openWindow(TowerBuffWindow, WindowPostion.CENTER_ONLY, true, true, isAutoClose, windowParam);
						break;
					//爬塔重置
					case WindowEvent.TOWER_RESET_WINDOW:
						WindowManager.inst.openWindow(TowerResetWindow, WindowPostion.CENTER_ONLY, true, true, isAutoClose, windowParam);
						break;
					//爬塔积分商店
					case WindowEvent.TOWER_SCORE_WINDOW:
						WindowManager.inst.openWindow(TowerScoreWindow, WindowPostion.CENTER_ONLY, false, true, isAutoClose, windowParam);
						break;
					//查看其他玩家信息
					case WindowEvent.PLAYER_WINDOW:
						if(WindowManager.inst.isWindowOpenedByWindowName(windowName))
						{
							var playerView:PlayerWindow = WindowManager.inst.getOpenWindow(windowName) as PlayerWindow;
							playerView.sendMsg(int(windowParam.id),int(windowParam.type),int(windowParam.severType),int(windowParam.from));
						}
						else
						{
							WindowManager.inst.openWindow(PlayerWindow, WindowPostion.CENTER_SPECLAIL_LEFT, false, true, isAutoClose, windowParam);
						}
						break;
					//战力对比
					case WindowEvent.POWER_COMPARE_WINDOW:
						WindowManager.inst.openWindow(PowerCompareWindow, WindowPostion.CENTER_ONLY, false,true, isAutoClose, windowParam);
						break;
					//其他玩家详细信息
					case WindowEvent.OTHER_PLAYER_DETAIL_WINDOW:
						WindowManager.inst.openWindow(PlayerDetailWindow, WindowPostion.CENTER_SPECLAIL_RIGHT, false, true, isAutoClose, windowParam);
						break;
					//练功房
					case WindowEvent.EXP_WINDOW:
						WindowManager.inst.openWindow(ExpRoomWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					//VIP
					case WindowEvent.VIP_WINDOW:
						WindowManager.inst.openWindow(VipWindow, WindowPostion.CENTER_RIGHT, false, false, isAutoClose, windowParam);
						break;
					//VIP card
					case WindowEvent.VIP_CARD_WINDOW:
						WindowManager.inst.openWindow(VipCardWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					//VIP card detail
					case WindowEvent.VIP_CARD_DETAIL_WINDOW:
						WindowManager.inst.openWindow(VipCardDetailWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam,[VipCardWindow]);
						break;
					//主角换装
					case WindowEvent.CHANGE_AVATAR_WINDOW:
						WindowManager.inst.openWindow(ChangeAvatarWindow, WindowPostion.CENTER_RIGHT, false, false, isAutoClose, windowParam);
						break;
					//帮会商店
					case WindowEvent.GUILD_SHOP_WINDOW:
						WindowManager.inst.openWindow(GuildShopWindow, WindowPostion.CENTER_RIGHT, false, false, isAutoClose, windowParam,[MyDemandWindow]);
						break;
					//帮会商店我的需求
					case WindowEvent.MY_DEMAND_WINDOW:
						WindowManager.inst.openWindow(MyDemandWindow, WindowPostion.CENTER_ONLY,true, false, isAutoClose, windowParam,[GuildShopWindow]);
						break;
					//护送成就
					case WindowEvent.CONVOY_SEAON_WINDOW:
						WindowManager.inst.openWindow(ConvoySeaonWindow, WindowPostion.CENTER_ONLY,true, true, isAutoClose, windowParam);
						break;
					//获取使者
					case WindowEvent.CONVOY_MESSENGER_WINDOW:
						WindowManager.inst.openWindow(ConvoyMessengerWindow, WindowPostion.CENTER_ONLY,false, false, isAutoClose, windowParam);
						break;
					//护送结果
					case WindowEvent.CONVOY_RESULT_WINDOW:
						WindowManager.inst.openWindow(ConvoyResultWindow, WindowPostion.CENTER_ONLY,false, false, isAutoClose, windowParam);
						break;
					//防沉迷
					case WindowEvent.ANTIADDICTION_WINDOW:
						//防沉迷打开结束所有引导
						GuideManager.instance.completeAllGuides();
						
						WindowManager.inst.openWindow(AntiAddictionWindow, WindowPostion.BOTTOM_CENTER,true);
						break;
					//洗练/封灵
					case WindowEvent.WASHEQUIP_WINDOW:
						WindowManager.inst.openWindow(WashEquipWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					//洗练/封灵  洗练属性
					case WindowEvent.WASHEQUIP_STREN_WINDOW:
						if(WindowManager.inst.isWindowOpenedByWindowName(windowName))
						{
							var washView:WashEquipStrenWindow = WindowManager.inst.getOpenWindow(windowName) as WashEquipStrenWindow;
							washView.upDataEquip(windowParam);
						}
						else
						{
							WindowManager.inst.openWindow(WashEquipStrenWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam,[WashEquipWindow]);
						}
						break;
					//洗练/封灵  洗练属性 批量洗练
					case WindowEvent.WASHEQUIP_BATCH_WINDOW:
						WindowManager.inst.openWindow(WashEquipBatchWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam,[WashEquipWindow,WashEquipStrenWindow]);
						break;
					//洗练/封灵  灵件兑换
					case WindowEvent.WASHEQUIP_EXCHANGE_WINDOW:
						WindowManager.inst.openWindow(WashEquipExchangeWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam,[WashEquipWindow,WashEquipStrenWindow]);
						break;
					//战前布阵
					case WindowEvent.PRE_WAR_WINDOW:
						WindowManager.inst.openWindow(PreWarWindow, WindowPostion.CENTER_ONLY, false, true, isAutoClose, windowParam);
						break;
					//六道轮回
					case WindowEvent.SIX_DESTINES_WINDOW:
						WindowManager.inst.openWindow(SixDestinesWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					//竞技场
					case WindowEvent.ARENA_WINDOW:
						WindowManager.inst.openWindow(ArenaView, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam,[ArenaRankWindow]);
						break;
					//竞技场排行榜
					case WindowEvent.ARENA_RANK_WINDOW:
						WindowManager.inst.openWindow(ArenaRankWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam,[ArenaView]);
						break;
					//竞技场奖励
					case WindowEvent.ARENA_REWARD_WINDOW:
						WindowManager.inst.openWindow(ArenaRewardWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam,[ArenaView]);
						break;
					//酒足饭饱BUFF
					case WindowEvent.SUPLLY_NOTICE_WINDOW:
						WindowManager.inst.openWindow(SupllyNoticeWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					//开服7天活动
					case WindowEvent.SEVEN_DAY_ACTIVITY_WINDOW:
						WindowManager.inst.openWindow(SevenDayActivityWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					//鲜花赠送
					case WindowEvent.FLOWER_SEND_WINDOW:
						if(GameData.inst.getOpenFuncByName(WindowEvent.FLOWER_SEND_WINDOW))//是否开放
						{
							if(WindowManager.inst.isWindowOpened(FlowerSendWindow))
							{
								MainUI.inst.updateWindow(WindowEvent.FLOWER_SEND_WINDOW,windowParam);
							}
							else
							{
								WindowManager.inst.openWindow(FlowerSendWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
							}
						}
						break;
					//我的鲜花
					case WindowEvent.MY_FLOWER_WINDOW:
						if(GameData.inst.getOpenFuncByName(WindowEvent.FLOWER_SEND_WINDOW))
							WindowManager.inst.openWindow(MyFlowerWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					//鲜花榜
					case WindowEvent.FLOWER_RANK_WINDOW:
						if(GameData.inst.getOpenFuncByName(WindowEvent.FLOWER_SEND_WINDOW))
							WindowManager.inst.openWindow(FlowerRankWindow, WindowPostion.CENTER, false, false, isAutoClose, windowParam,[MyFlowerWindow,FlowerSendWindow]);
						break;
					//领地攻防战查看界面
					case WindowEvent.GUILD_VS_WATCH_WINDOW:
						WindowManager.inst.openWindow(GuildVSWatchWindow, WindowPostion.CENTER_ONLY,false, false, isAutoClose, windowParam);
						break;
					//领地攻防战查看战报
					case WindowEvent.GUILD_VS_REPORT_WINDOW:
						WindowManager.inst.openWindow(GuildVSReportWindow, WindowPostion.CENTER_ONLY,false, false, isAutoClose, windowParam);
						break;
					//比武场
					case WindowEvent.SKY_LADDER_WINDOW:
						WindowManager.inst.openWindow(SkyLadderWindow, WindowPostion.CENTER_ONLY,false, false, isAutoClose, windowParam,[SkyLadderRankWindow,SkyLadderDailyWindow,SkyLadderSeasonWindow]);
						break;
					//比武场排名
					case WindowEvent.SKY_LADDER_RANK_WINDOW:
						WindowManager.inst.openWindow(SkyLadderRankWindow, WindowPostion.CENTER_ONLY,false, false, isAutoClose, windowParam,[SkyLadderWindow]);
						break;
					//比武场赛季奖励
					case WindowEvent.SKY_LADDER_SEASON_WINDOW:
						WindowManager.inst.openWindow(SkyLadderSeasonWindow, WindowPostion.CENTER_ONLY,false, false, isAutoClose, windowParam,[SkyLadderWindow]);
						break;
					//比武场每日奖励
					case WindowEvent.SKY_LADDER_DAILY_WINDOW:
						WindowManager.inst.openWindow(SkyLadderDailyWindow, WindowPostion.CENTER_ONLY,false, false, isAutoClose, windowParam,[SkyLadderWindow]);
						break;
					//微端奖励
					case WindowEvent.MICRO_CLIENT_WINDOW:
						WindowManager.inst.openWindow(MicroClientWindow, WindowPostion.CENTER_ONLY,false, false, isAutoClose, windowParam);
						break;
					//改名
					case WindowEvent.RENAME_WINDOW:
						WindowManager.inst.openWindow(RenameWindow, WindowPostion.CENTER_ONLY,false, true, isAutoClose);
						break;
					//首充
					case WindowEvent.FIRST_CHARGE_WINDOW:
						WindowManager.inst.openWindow(FirstChargeWindow, WindowPostion.CENTER_ONLY,false, true, isAutoClose);
						break;
					//首充选择奖励
					case WindowEvent.FIRST_CHARGE_HERO_WINDOW:
						WindowManager.inst.openWindow(FirstChargeHeroWindow, WindowPostion.CENTER_ONLY,false, true, isAutoClose,windowParam,[FirstChargeWindow]);
						break;
					//在线奖励
					case WindowEvent.ONLINE_REWARD_WINDOW:
						GameProxy.inst.onlineRewardReceive();
						break;
					//帮会红包
					case WindowEvent.GUILD_REDBAG_WINDOW:
						WindowManager.inst.openWindow(GuildRedBagWindow, WindowPostion.CENTER_ONLY,false, true, isAutoClose,windowParam,[RedBagLogWindow,SendRedBagWindow,RedBagResultWindow]);
						break;
					//发红包
					case WindowEvent.SEND_REDBAG_WINDOW:
						WindowManager.inst.openWindow(SendRedBagWindow, WindowPostion.CENTER_ONLY,false, true, isAutoClose,windowParam,[GuildRedBagWindow]);
						break;
					//抢红包
					case WindowEvent.GRAB_REDBAG_WINDOW:
						WindowManager.inst.openWindow(RedBagResultWindow, WindowPostion.CENTER_ONLY,false, true, isAutoClose,windowParam,[GuildRedBagWindow]);
						break;
					//聊天发红包
					case WindowEvent.CHAT_SEND_REDBAG_WINDOW:
						WindowManager.inst.openWindow(ChatSendRedBagWindow, WindowPostion.CENTER_ONLY,false, true, isAutoClose,windowParam,[]);
						break;
					//聊天抢红包
					case WindowEvent.CHAT_GRAB_REDBAG_WINDOW:
						WindowManager.inst.openWindow(ChatGrabRedBagWindow, WindowPostion.CENTER_ONLY,false, true, isAutoClose,windowParam,[]);
						break;
					//红包记录
					case WindowEvent.REDBAG_LOG_WINDOW:
						WindowManager.inst.openWindow(RedBagLogWindow, WindowPostion.CENTER_ONLY,false, true, isAutoClose,windowParam,[GuildRedBagWindow]);
						break;
					//股票积分商城
					case WindowEvent.STOCK_STORE_WINDOW:
						WindowManager.inst.openWindow(StockStoreWindow, WindowPostion.CENTER_ONLY,false, false, isAutoClose);
						break;
					//股票积分商城
					case WindowEvent.STOCK_WINDOW:
						WindowManager.inst.openWindow(StockWindow, WindowPostion.CENTER_ONLY,false, false, isAutoClose);
						break;
					//股票买卖
					case WindowEvent.STOCK_DEAL_WINDOW:
						WindowManager.inst.openWindow(StockDealWindow, WindowPostion.CENTER_ONLY,true, false, isAutoClose,windowParam);
						break;
					//神通
					case WindowEvent.PASSIVE_SKILL_WINDOW:
						WindowManager.inst.openWindow(PassiveSkillWindow, WindowPostion.CENTER_ONLY,false, false, isAutoClose,windowParam);
						break;
					//无尽试炼
					case WindowEvent.ENDLESS_WINDOW:
						WindowManager.inst.openWindow(EndlessWindow, WindowPostion.CENTER_ONLY,false, false, isAutoClose,windowParam);
						break;
					//等级礼包
					case WindowEvent.LEVEL_GIFT_WINDOW:
						WindowManager.inst.openWindow(LevelGiftWindow, WindowPostion.CENTER_ONLY,false, false, isAutoClose,windowParam);
						break;
					//礼品铺
					case WindowEvent.GIFT_STORE_WINDOW:
						WindowManager.inst.openWindow(GiftStoreWindow, WindowPostion.CENTER_ONLY,false, false, isAutoClose,windowParam);
						break;
					//伙伴礼物
					case WindowEvent.HERO_GIFT_WINDOW:
						WindowManager.inst.openWindow(HeroGiftWindow, WindowPostion.CENTER_RIGHT,false, false, isAutoClose,windowParam,[HeroWindow]);
						break;
					//赠送伙伴礼物
					case WindowEvent.HERO_EAT_WINDOW:
						WindowManager.inst.openWindow(HeroEatWindow, WindowPostion.CENTER_ONLY,true, false, isAutoClose,windowParam,[HeroWindow,HeroGiftWindow]);
						break;
					//批量赠送伙伴礼物
					case WindowEvent.HERO_BATCH_EAT_WINDOW:
						WindowManager.inst.openWindow(HeroBatchEatWindow, WindowPostion.CENTER_ONLY,true, false, isAutoClose,windowParam,[HeroWindow,HeroGiftWindow]);
						break;
					//热门活动
					case WindowEvent.HOT_ACTIVITY_WINDOW:
						WindowManager.inst.openWindow(HotActivityWindow, WindowPostion.CENTER_ONLY,false, false, isAutoClose,windowParam,[]);
						break;
					//答题活动
					case WindowEvent.ANSWER_WINDOW:
						WindowManager.inst.openWindow(AnswerWindow, WindowPostion.CENTER_ONLY,false, true, isAutoClose,windowParam);
						break;
					//答题奖励
					case WindowEvent.ANSWER_AWARD_WINDOW:
						WindowManager.inst.openWindow(AnswerAwardWindow, WindowPostion.CENTER_ONLY,false, true, isAutoClose,windowParam);
						break;
					
					//编辑个人资料
					case WindowEvent.PLAYER_EDIT_WINDOW:
						WindowManager.inst.openWindow(PlayerEditWindow, WindowPostion.CENTER_ONLY,false, true, isAutoClose,windowParam);
						break;
					//图像裁切
					case WindowEvent.PLAYER_CUT_PHOTO_WINDOW:
						WindowManager.inst.openWindow(PlayerCutPhotoWindow, WindowPostion.CENTER_SPECLAIL_RIGHT,false, true, isAutoClose,windowParam);
						break;
				}
			}
			// 关闭全屏玩法指令
			else if(type == WindowEvent.HIDE_FULLSCREEN_VIEW)
			{
				sxd2main.hideFullScreenView();
			}
		}
	}
}