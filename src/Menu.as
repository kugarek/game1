package
{
    import flash.system.System;
    import flash.utils.setTimeout;
    
    import events.NavigationEvent;
    
    import feathers.controls.Button;
    import feathers.controls.Header;
    import feathers.controls.Label;
    import feathers.controls.ScrollContainer;
    import feathers.controls.ToggleSwitch;
    import feathers.layout.HorizontalLayout;
    import feathers.layout.VerticalLayout;
    import feathers.themes.ExtendedMetalWorksMobileTheme;
    
    import starling.display.DisplayObject;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    
    import utils.Animations;
    import utils.Settings;
    
    /** The Menu shows the logo of the game and a start button that will, once triggered, 
     *  start the actual game. In a real game, it will probably contain several buttons and
     *  link to several screens (e.g. a settings screen or the credits). If your menu contains
     *  a lot of logic, you could use the "Feathers" library to make your life easier. */
    public class Menu extends Sprite
    {       			
		//Main screen
		private var digitsBtn:Button;		
		private var settingsBtn:Button;	
				
		//Settings tab
		private var settingsContainer:ScrollContainer;
		private var settingsBackBtn:Button;
		private var languageLabel:Label;
		private var languageToggleBtn:ToggleSwitch;
		
       
		/**
		 * Initialize 
		 */
		public function Menu()
        {
            this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }
        
		
		/**
		 * On added to stage create children and assign the event listeners
		 */
        private function onAddedToStage(e:Event):void
        {            		
			this.addChild(Root.defaultBackground);
			
			
			digitsBtn = new Button();
			digitsBtn.nameList.add(ExtendedMetalWorksMobileTheme.ALTERNATE_NAME_DIGITS_BUTTON);
			digitsBtn.addEventListener(Event.TRIGGERED, onStartGameBtnTriggered);
			this.addChild(digitsBtn);
									
			settingsBtn = new Button();			
			settingsBtn.nameList.add(ExtendedMetalWorksMobileTheme.ALTERNATE_NAME_SETTINGS_BUTTON);
			this.addChild(settingsBtn);
			settingsBtn.validate();
			settingsBtn.x = Root.stageWidth - settingsBtn.defaultSkin.width - 50;
			settingsBtn.y = settingsBtn.y + 50;
			settingsBtn.addEventListener(Event.TRIGGERED, onSettingsButtonTriggered);
			
			
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			Animations.moveUpEndDown(digitsBtn);	
        }
		
			
			
        private function onStartGameBtnTriggered(event:Event):void
        {
            dispatchEventWith(NavigationEvent.START_GAME, true, "start_game");
        }
		
		
		
		/**
		 * Handles the settings button click
		 */
		private function onSettingsButtonTriggered(event:Event):void
		{
			trace("Settings button triggered >>>");	
			digitsBtn.removeEventListener(Event.TRIGGERED, onStartGameBtnTriggered);
			Animations.removeTweenForTarget(digitsBtn);
			Animations.fadeOut(digitsBtn);		
			Animations.fadeOut(settingsBtn);
			settingsBtn.removeEventListener(Event.TRIGGERED, onSettingsButtonTriggered);
			createSettingsTab();
			setTimeout( function():void {Animations.fadeIn(settingsContainer)}, 1);
			
		}
		
		
		/**
		 * Creates the settings tab and it's contents 
		 */
		private function createSettingsTab():void
		{
			if(!settingsContainer) {
									
				var containerLayout:VerticalLayout = new VerticalLayout();
				containerLayout.gap = 50;
				containerLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
				containerLayout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
				containerLayout.padding = 50;
				
				/*var layout:HorizontalLayout = new HorizontalLayout();
				containerLayout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
				containerLayout.gap = 50;*/
				
				settingsContainer = new ScrollContainer();
				settingsContainer.horizontalScrollPolicy = "off";
				settingsContainer.verticalScrollPolicy = "off";
				settingsContainer.backgroundSkin = new Image( Root.assets.getTexture("blueBgd_1x1") );				
				settingsContainer.layout = containerLayout;				
				settingsContainer.alpha = 0;
				
				settingsBackBtn = new Button();
				settingsBackBtn.nameList.add(Button.ALTERNATE_NAME_BACK_BUTTON);
				settingsBackBtn.label = "Back to menu";
				settingsBackBtn.addEventListener(Event.TRIGGERED, onSettingsBackButtonClick);
				
				var header:Header = new Header();
				header.title = "Settings / Ustawienia";
				header.leftItems = new <DisplayObject>[ settingsBackBtn ];
				
				
				languageLabel = new Label();
				languageLabel.text = Root.resourceManager.getString(Constants.BUNDLE_NAME, "language");
				languageToggleBtn = new ToggleSwitch();
				languageToggleBtn.onText = "English";
				languageToggleBtn.offText = "Polish";
				languageToggleBtn.x = languageLabel.x + languageLabel.width + 20;
				languageToggleBtn.isSelected = isToggleSelected();
				
				languageToggleBtn.addEventListener(Event.CHANGE, toggleLanguageClickHandler);
				
				this.addChild(settingsContainer);
				settingsContainer.addChild(header);						
				settingsContainer.addChild(languageLabel);
				settingsContainer.addChild(languageToggleBtn);
				//settingsContainer.addChild(settingsBackBtn);
				
				settingsContainer.validate();
				settingsContainer.x = (Root.stageWidth - settingsContainer.width) /2;
				settingsContainer.y = (Root.stageHeight- settingsContainer.height) /4;
			}
		}
		
		
		/**
		 * Returns true if the language is set to English and false if the language is set to Polish 
		 */
		private function isToggleSelected():Boolean {
			
			if(Settings.language == Constants.ENG) {
				
				return true;
			}else
			{
				return false;
			}
			
		}
		
		
		/**
		 * Sets the language when the toggle button changes 
		 */
		private function toggleLanguageClickHandler(event:Event):void
		{
			var toggle:ToggleSwitch = ToggleSwitch( event.currentTarget );
			trace( "toggle.isSelected changed:", toggle.isSelected );
			
			if(toggle.isSelected) {
				
				Settings.updateLanguage(Constants.ENG);
			}else
			{
				Settings.updateLanguage(Constants.PL);
			}
		}		
	
		
		
		/**
		 * Event handler for the back setting button click
		 */
		private function onSettingsBackButtonClick(event:Event):void
		{
			Animations.fadeOut(settingsContainer);
			Animations.fadeIn(settingsBtn);
			settingsBtn.addEventListener(Event.TRIGGERED, onSettingsButtonTriggered);
			setTimeout( function():void {Animations.fadeIn(digitsBtn)}, 1);
			digitsBtn.y = (Root.stageHeight- digitsBtn.defaultSkin.height) /4;
			Animations.moveUpEndDown(digitsBtn);
			destroySettingsTab();
			digitsBtn.addEventListener(Event.TRIGGERED, onStartGameBtnTriggered);
			//this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		
		
		/**
		 * Destroys the settingsContainer and its contents 
		 */
		private function destroySettingsTab():void
		{
			if(settingsContainer) {
				
				settingsBackBtn.removeEventListener(Event.TRIGGERED, onSettingsBackButtonClick);				
				settingsContainer.removeChild(settingsBackBtn);
				settingsBackBtn = null;				
				
				settingsContainer.removeChild( languageLabel );
				languageLabel = null; 
				
				settingsContainer.removeChild( languageToggleBtn );
				languageToggleBtn.removeEventListener(Event.CHANGE, toggleLanguageClickHandler);
				languageToggleBtn = null; 
				
				settingsContainer.backgroundSkin = null;
				this.removeChild(settingsContainer);
				settingsContainer.dispose();
				settingsContainer = null;
				
				// now would be a good time for a clean-up 
				System.pauseForGCIfCollectionImminent(0);
			}
		}
		
		
		/*private function onEnterFrame(event:Event):void
		{
			Animations.moveUpEndDown(digitsBtn);			
		}*/
				
				
		
		/**
		 * Removed from stage handler
		 */
		private function onRemovedFromStage(event:Event):void
		{
			trace("Menu removed from stage >>>> ")
			Animations.removeTweenForTarget(digitsBtn);
			this.removeEventListeners();
			this.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		//	this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			digitsBtn.removeEventListener(Event.TRIGGERED, onStartGameBtnTriggered);
			settingsBtn.removeEventListener(Event.TRIGGERED, onSettingsButtonTriggered);
			this.removeChild( digitsBtn );
			this.removeChild( settingsBtn );
			digitsBtn.defaultSkin = null;
			digitsBtn = null;
			settingsBtn = null;
			this.removeChild( Root.defaultBackground );
			dispose();
		}
    }
}