/**Created by the Morn,do not modify.*/
package game.ui.shell {
	import morn.core.components.*;import moreui.view.*;
	public class TestBaseUI extends BaseWindow {
		protected static var uiXML:XML =
			<BaseWindow width="600" height="400"/>;
		public function TestBaseUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}