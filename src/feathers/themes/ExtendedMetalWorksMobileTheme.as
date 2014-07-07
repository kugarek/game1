package feathers.themes
{
	import feathers.controls.Button;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	
	public class ExtendedMetalWorksMobileTheme extends MetalWorksMobileTheme
	{
		public static const ALTERNATE_NAME_DIGITS_BUTTON:String = "digits-button";
		public static const ALTERNATE_NAME_SETTINGS_BUTTON:String = "settings-button";
		
		public function ExtendedMetalWorksMobileTheme(container:DisplayObjectContainer=null, scaleToDPI:Boolean=true)
		{
			super(container, scaleToDPI);
		}
		
		override protected function initialize():void
		{
			super.initialize();
			this.setInitializerForClass( Button, setDigitsButtonSkin, ALTERNATE_NAME_DIGITS_BUTTON );
			this.setInitializerForClass( Button, setSettingsButtonSkin, ALTERNATE_NAME_SETTINGS_BUTTON );
		}
		
		
		private function setDigitsButtonSkin(button:Button):void
		{
			button.defaultSkin = new Image(EmbededAssets.getTexture("DigitsBtnUpSkin" + Root.defaultLanguage));
			button.downSkin = new Image(EmbededAssets.getTexture("DigitsBtnDownSkin" + Root.defaultLanguage));
			button.x = (Root.stageWidth - button.defaultSkin.width) /2;
			button.y = (Root.stageHeight- button.defaultSkin.height) /4;
		}
		
	
		private function setSettingsButtonSkin(button:Button):void
		{
			button.defaultSkin = new Image(Root.assets.getTexture("settingsBtnUpSkin"));
			button.downSkin = new Image(Root.assets.getTexture("settingsBtnDownSkin"));
			
		}
	}
}