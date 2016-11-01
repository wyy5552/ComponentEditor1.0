/**Created by the Morn,do not modify.*/
package game.ui.shell {
	import morn.core.components.*;
	public class MainUI extends View {
		protected static var uiXML:XML =
			<View width="1239" height="723">
			  <Image skin="png.comp.bg" x="0" y="0" width="1201" height="727" sizeGrid="4,30,4,4"/>
			</View>;
		public function MainUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}