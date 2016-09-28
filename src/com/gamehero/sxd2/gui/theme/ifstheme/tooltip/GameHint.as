package com.gamehero.sxd2.gui.theme.ifstheme.tooltip {
	
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.arena.ArenaFigureItem;
	import com.gamehero.sxd2.gui.bag.model.ItemSrcTypeDict;
	import com.gamehero.sxd2.gui.bag.model.ItemTypeDict;
	import com.gamehero.sxd2.gui.bag.model.vo.ItemCellData;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.convoy.component.ConvoyPlayerRender;
	import com.gamehero.sxd2.gui.convoy.component.ConvoyRetakeIcon;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.core.components.McActiveObject;
	import com.gamehero.sxd2.gui.core.interFace.ICellData;
	import com.gamehero.sxd2.gui.core.interFace.IHeroData;
	import com.gamehero.sxd2.gui.dailyActivity.DailyActivityWindow;
	import com.gamehero.sxd2.gui.endless.component.RoundRender;
	import com.gamehero.sxd2.gui.equips.EquipWindow;
	import com.gamehero.sxd2.gui.equips.model.EquipModel;
	import com.gamehero.sxd2.gui.expRoom.ExpRoomFigure;
	import com.gamehero.sxd2.gui.formation.fetterZone.FormationFetterBtn;
	import com.gamehero.sxd2.gui.formation.formationZone.FormationBtn;
	import com.gamehero.sxd2.gui.formation.thaumaturgyZone.ThaumaturgyItem;
	import com.gamehero.sxd2.gui.guild.activity.sevenSealDevil.ui.SevenStarBossItem;
	import com.gamehero.sxd2.gui.heroHandbook.ActiveBox;
	import com.gamehero.sxd2.gui.heroHandbook.HeroHandbookLookBtn;
	import com.gamehero.sxd2.gui.heroHandbook.HerohandbookCell;
	import com.gamehero.sxd2.gui.passiveSkill.PassiveSkillCell;
	import com.gamehero.sxd2.gui.player.equip.model.PlayerEquipModel;
	import com.gamehero.sxd2.gui.player.hero.model.HeroModel;
	import com.gamehero.sxd2.gui.preWar.preWarFormation.PreWarForHeroItem;
	import com.gamehero.sxd2.gui.prestige.component.GodIcon;
	import com.gamehero.sxd2.gui.roleSkill.RoleSkillItemCell;
	import com.gamehero.sxd2.gui.roleSkill.SkillItemCell;
	import com.gamehero.sxd2.gui.roleSkill.ui.GodIconButton;
	import com.gamehero.sxd2.gui.seekDevice.view.ui.DeviceItem;
	import com.gamehero.sxd2.gui.sixDestinies.view.SixDestinesFigure;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.WindowHelpButton;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.tree.TaskTreeLabel;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.GameHintSkin;
	import com.gamehero.sxd2.gui.tips.ArenaTips;
	import com.gamehero.sxd2.gui.tips.ConvoyPlayerRenderTips;
	import com.gamehero.sxd2.gui.tips.ConvoyRetakeIconTips;
	import com.gamehero.sxd2.gui.tips.EndlessRoundRenderTips;
	import com.gamehero.sxd2.gui.tips.EquipMasterTip;
	import com.gamehero.sxd2.gui.tips.ExpRoomFigureTips;
	import com.gamehero.sxd2.gui.tips.FormationTips;
	import com.gamehero.sxd2.gui.tips.GeneralTips;
	import com.gamehero.sxd2.gui.tips.GodTip;
	import com.gamehero.sxd2.gui.tips.HeroBaseTips;
	import com.gamehero.sxd2.gui.tips.HeroHandbookTips;
	import com.gamehero.sxd2.gui.tips.HurdleGuideTips;
	import com.gamehero.sxd2.gui.tips.ItemTipsManager;
	import com.gamehero.sxd2.gui.tips.MenuButtonTips;
	import com.gamehero.sxd2.gui.tips.PassiveSkillTips;
	import com.gamehero.sxd2.gui.tips.SeekDeviceTip;
	import com.gamehero.sxd2.gui.tips.SevenStarSealDevilTips;
	import com.gamehero.sxd2.gui.tips.SixDestinesTips;
	import com.gamehero.sxd2.gui.tips.SkillTip;
	import com.gamehero.sxd2.gui.tips.TaskTips;
	import com.gamehero.sxd2.gui.tips.ThaumaturgyTips;
	import com.gamehero.sxd2.gui.tips.TowerExchangeTips;
	import com.gamehero.sxd2.gui.tips.TowerMonsterTips;
	import com.gamehero.sxd2.gui.tips.WindowHelpTips;
	import com.gamehero.sxd2.gui.tower.component.MonsterIconCell;
	import com.gamehero.sxd2.gui.tower.component.TowerExchangeButton;
	import com.gamehero.sxd2.gui.washEquip.component.WashEquipWeaponCell;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.pro.PRO_Instance;
	import com.gamehero.sxd2.util.AssetUtil;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import alternativa.gui.alternativagui;
	import alternativa.gui.base.GUIobject;
	import alternativa.gui.mouse.IHint;
	import alternativa.gui.mouse.MouseManager;
	
	import org.bytearray.display.ScaleBitmap;
	
	use namespace alternativagui;
	
	/**
	 * Game Hint 
	 * @author Trey
	 * @modify-date 2013-8-26
	 */
	public class GameHint extends GUIobject implements IHint {
		
		// EN: content
		private var content:DisplayObject;//左侧tips
		private var content2:DisplayObject;//右侧tips
		
		// RU: внутренний отступ
		// EN: padding
		public static var paddingX:int = 8;
		public static var paddingY:int = 8;
		private var distance:int = 3;
		
		private var _label:Label;
		
		private var _available:Boolean = false;
		
		private var bg:ScaleBitmap;
	
		public function GameHint() {
			super();
			
			_label = new Label();
			_label.leading = 0.5;
			_label.color = GameDictionary.WINDOW_BTN;
		}
		
		
		override public function resize(width:int, height:int):void {
		}
		
		override public function set width(value:Number):void {
		}
		
		override public function set height(value:Number):void {
		}
		
		/**
		 * Tips背景
		 * */
		private function setBGQuantily(value:int = -1):void
		{
			if(this.bg)
			{
				if(this.bg.parent){
					this.bg.parent.removeChild(bg);
				}
				this.bg = null;
			}
			
			this.bg = new ScaleBitmap(GameHintSkin.TIPS_BG);
			this.bg.scale9Grid = GameHintSkin.hintBgScale9Grid;
		}
		
		// EN: set the text for hint
		public function set text(value:String):void 
		{
			// Modify by Trey, 2013-12-17, 为了解决空GameHint显示的问题
			if (content != null && contains(content)) {
				AssetUtil.instance.stopAll(content as DisplayObjectContainer);
				removeChild(content);
				content = null;
			}
			if (content2 != null && contains(content2)) {
				AssetUtil.instance.stopAll(content2 as DisplayObjectContainer);
				removeChild(content2);
				content2 = null;
			}
			_available = true;
			
			if(MouseManager.overed)
				if(MouseManager.overed.parent)		
					if(MouseManager.overed.parent is TaskTreeLabel)
						var taskTreeLabel:TaskTreeLabel = MouseManager.overed.parent as TaskTreeLabel;
					else if(MouseManager.overed.parent is DailyActivityWindow)
						var dailyActivityWindow:DailyActivityWindow = MouseManager.overed.parent as DailyActivityWindow;

			var isBg:Boolean;//标记是否自带背景
			
			var valueList:Array;
			
			if(value)
				valueList =  value.split(GameDictionary.doubleSplitHat);//一些描述类型的tips
			
			if(valueList && valueList.length > 1)
			{
				var tpye:String = valueList[0];
				switch(tpye)
				{
					//日常活动
					case GameHintDict.DAILY_ACTIVITY:
					{
						isBg = true;
						var activityList:Array = valueList[1].split(GameDictionary.splitHat);
						var boxList:Array = activityList[0].split("~");
						var item:PropBaseVo = ItemManager.instance.getPropById(boxList[0]);
						var itemStr:String = ItemTipsManager.getMustPropStr(item.giftTips);
						var titleStr:String = GameDictionary.ORANGE_TAG + Lang.instance.trans("active_degree_tips3");
						var contentStr:String = Lang.instance.trans("active_degree_tips2").replace("{str}",activityList[1]) + "\n" +  itemStr;
						content =  GeneralTips.getTips(titleStr + GameDictionary.splitWave +  contentStr);
						break;
					}
					//menuBtn
					case GameHintDict.MENU_BUTTON:
					{
						content = MenuButtonTips.getTips(value);
						break;
					}
					case GameHintDict.GENERAL_TIPS:
					{
						isBg = true;
						content = GeneralTips.getTips(valueList[1]);
						break;
					}
					case GameHintDict.EQUIP_MASTER:
					{
						content = EquipMasterTip.getTips(valueList[1]);
						break;
					}
				}
				addBg(isBg)
			}
			// 背包格子tips
			else if(MouseManager.overed is ICellData)
			{
				function addLabel():void
				{
					if(" " != value)
					{
						_label.text = value;
						content = _label;
					}
					addBg(isBg);
				}
				
				var cellData:ItemCellData = (MouseManager.overed as ICellData).itemCellData;
				if(cellData == null)//保留格子只显示文本的权利
				{
					addLabel();
				}
				else
				{
					clearBg();
					content = ItemTipsManager.getTips(cellData);
					if(cellData.propVo && cellData.propVo.type == ItemTypeDict.EQUIP && cellData.itemSrcType != ItemSrcTypeDict.EQUIP_WINDOW && cellData.itemSrcType != ItemSrcTypeDict.HERO_EQUIP && cellData.itemSrcType != ItemSrcTypeDict.OTHRE_PLAYER_WINDOW)
					{
						//装备道具,并且不是伙伴身上的,不是装备界面的
						var cellData2:ItemCellData = new ItemCellData;
						if(WindowManager.inst.isWindowOpened(EquipWindow))
						{//如果装备界面打开着
							cellData2.data = HeroModel.instance.getEquip(EquipModel.inst.curSelectedId,cellData.propVo.subType);
							cellData2.itemSrcType = ItemSrcTypeDict.EQUIP_WINDOW;
						}
						else
						{
							cellData2.data = HeroModel.instance.getEquip(HeroModel.instance.curSelectedId,cellData.propVo.subType);
							cellData2.itemSrcType = ItemSrcTypeDict.HERO_EQUIP;
						}
						content2 = ItemTipsManager.getTips(cellData2);
					}
					else if(cellData.propVo && cellData.propVo.type == ItemTypeDict.PLAYER_EQUIP && cellData.itemSrcType == ItemSrcTypeDict.OTHRE_PLAYER_WINDOW)
					{
						//查看其他玩家的器灵信息对比
						var ent:Object = cellData.ent;
						if(ent)
						{
							content2 = ItemTipsManager.getTips(PlayerEquipModel.inst.getSelfEquipCellData(ent.index));
						}
					}
					else if(null == content && (MouseManager.overed is WashEquipWeaponCell))
					{
						addLabel();
					}
				}
			}
			// 其他自定义tips
			else
			{
				if(MouseManager.overed is McActiveObject)//绘制的响应区域
				{
					var hgAo:McActiveObject = MouseManager.overed as McActiveObject;//hg  hurdleGuide
					switch(hgAo.type)
					{
						case McActiveObject.HurdleGuideBossNode:
							content = HurdleGuideTips.getTips(hgAo.data,hgAo.pro);
							break;
						case McActiveObject.HurdleGuideSmallNode:
							if(hgAo.pro == null || (hgAo.pro as PRO_Instance).isFirst)//如果小怪关是还未打过一次
							{
								content = HurdleGuideTips.getTips(hgAo.data,hgAo.pro);
							}
							else
							{
								content = HurdleGuideTips.getSmallNode(hgAo.data);
							}
							break;
						case McActiveObject.HurdleGuideBox:
							content = HurdleGuideTips.getBoxTips(hgAo.data,hgAo.ent);//宝箱奖励数据，宝箱是领取条件
							break;
						default :
							if(" " != value)
							{
								this._label.text = value;
								this.content = _label;
							}
					}
				}
				else if(MouseManager.overed is IHeroData)
				{
					if(MouseManager.overed is PreWarForHeroItem)
					{
						content = HeroBaseTips.getBattleRoleTips(MouseManager.overed as PreWarForHeroItem);
					}
					else
					{
						isBg = true;
						content = HeroBaseTips.getHeroBase(MouseManager.overed as IHeroData);
					}
				}
				else if(MouseManager.overed is FormationBtn)
				{
					content = FormationTips.getFormationTips(MouseManager.overed as FormationBtn);
				} 
				else if(MouseManager.overed is FormationFetterBtn)
				{
					isBg = true;
					content = FormationTips.getFormationFetterTips(MouseManager.overed as FormationFetterBtn);
				}
				else if(MouseManager.overed is SkillItemCell || MouseManager.overed is RoleSkillItemCell)
				{
					var skillItem:SkillItemCell = MouseManager.overed as SkillItemCell;
					if(skillItem.skillData)
						content = SkillTip.getSkillCellTips(skillItem);
					else
					{
						this._label.text = value;
						this.content = _label;
					}
				}
				else if(MouseManager.overed is GodIconButton)
				{
					content = GodTip.getGodTip((MouseManager.overed as GodIconButton).godData);
				}
				else if(MouseManager.overed is GodIcon)
				{
					content = GodTip.getGodTip((MouseManager.overed as GodIcon).godData);
				}
				else if(MouseManager.overed is HerohandbookCell || MouseManager.overed is HeroHandbookLookBtn)
				{
					isBg = true;
					content = HeroHandbookTips.getHeroHandbookTips(MouseManager.overed);
				}
				else if(MouseManager.overed is ActiveBox)
				{
					content = HeroHandbookTips.getBoxTips(MouseManager.overed);
				}
				else if(MouseManager.overed is TowerExchangeButton)
				{
					if((MouseManager.overed as TowerExchangeButton).data){
						content = TowerExchangeTips.getCellTips((MouseManager.overed as TowerExchangeButton).data);
					}
				}
				else if(MouseManager.overed is ThaumaturgyItem)
				{
					content = ThaumaturgyTips.getThaumaTips(MouseManager.overed as ThaumaturgyItem);
				}					
				else if(MouseManager.overed is SevenStarBossItem)
				{
					content = SevenStarSealDevilTips.getSevenStarBossStatus(MouseManager.overed as SevenStarBossItem);
				}
				else if(MouseManager.overed is DeviceItem)
				{
					content = SeekDeviceTip.getTip(MouseManager.overed as DeviceItem);
				}
				else if(MouseManager.overed is MonsterIconCell){
					content = TowerMonsterTips.getCellTips(MouseManager.overed as MonsterIconCell);
				}else if(MouseManager.overed is ConvoyPlayerRender){
					content = ConvoyPlayerRenderTips.getCellTips(MouseManager.overed as ConvoyPlayerRender);
				}else if(MouseManager.overed is ConvoyRetakeIcon){
					content = ConvoyRetakeIconTips.getCellTips(MouseManager.overed as ConvoyRetakeIcon);
				}
				else if(MouseManager.overed is ExpRoomFigure)
				{
					content = ExpRoomFigureTips.expFigureTips(MouseManager.overed as ExpRoomFigure);
				}
				else if(MouseManager.overed is WindowHelpButton)
				{
					content = WindowHelpTips.helpTips(MouseManager.overed as WindowHelpButton);
				}
				else if(MouseManager.overed is SixDestinesFigure)
				{
					isBg = true;
					content = SixDestinesTips.getSixDestinesFigure(MouseManager.overed as SixDestinesFigure);
				}
				else if(MouseManager.overed is ArenaFigureItem)
				{
					content = ArenaTips.getArenaMemberTip(MouseManager.overed as ArenaFigureItem);
				}
				else if(MouseManager.overed is PassiveSkillCell)
				{
					isBg = true;
					content = PassiveSkillTips.getPassiveSkillTips(MouseManager.overed as PassiveSkillCell);
				}
				else if(MouseManager.overed is RoundRender){
					if((MouseManager.overed as RoundRender).round > 0){
						content = EndlessRoundRenderTips.getCellTips(MouseManager.overed as RoundRender);
					}
				}
				// 任务tips
				else if(taskTreeLabel)
				{
					content = TaskTips.getTips(value);	
				}
				else if(" " != value)
				{
					this._label.text = value;
					this._label.leading = 0.7;
					this.content = _label;
				}
				
				//此处默认ActiveObject   Tips
				addBg(isBg);
			}
			
			
			// Modify by Trey, 2013-12-17, 为了解决空GameHint显示的问题
			if(_available == true && content != null) {
				
				content.addEventListener(Event.REMOVED_FROM_STAGE , onRemove);
				// 必须有内容
				if(content.width > 0 && content.height > 0)
				{
					this.addChild(content);
					if(content2)
					{
						this.addChild(content2);
					}
					
					this.redraw();
					
				}
			}
		}
		/**
		 * 添加背景 
		 * 
		 */		
		private function addBg(isBg:Boolean):void
		{
			this.setBGQuantily();
			
			if(content && !isBg)
			{
				var w:int = content.width + GameHint.paddingX * 2;// + GameHintSkin.edge;
				var h:int = content.height + GameHint.paddingY * 2 + GameHintSkin.edge;
				this.bg.setSize(w,h);
				addChildAt(this.bg, 0);
			}
		}
		/**		 * 清掉自带的bg		 */		
		private function clearBg():void
		{
			if(this.bg)
			{
				if(this.bg.parent){
					this.bg.parent.removeChild(bg);
				}
				this.bg = null;
			}
		}
		// RU: изменяем размер фону
		// EN: change background size
		override protected function draw():void {
			
			super.draw();
			
			this.drawChildren();
		}
		// RU: позиционирование и изменение размеров
		// EN: set position and change sizes
		private function redraw():void {
			content.x = paddingX;
			content.y = paddingY;
			
			if(content2)
			{
				content2.x = content.x + content.width + paddingX*2 + distance;
				content2.y = content.y;
				_width = content.width + distance + content2.width + paddingX * 2;
				_height = Math.max(content.height, content2.height) + paddingY * 2;
			}else{
				_width = content.width + paddingX * 2;
				_height = content.height + paddingY * 2;
			}
			
			draw();
		}
		
		private  function onRemove(e:Event):void
		{
			content.removeEventListener(Event.REMOVED_FROM_STAGE , onRemove);
		}
		
		public function get available():Boolean
		{
			return _available;
		}
		
	}
}



