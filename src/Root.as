package
{
    import flash.system.System;
    
    import mx.resources.IResourceManager;
    import mx.resources.ResourceManager;
    
    import components.background.DefaultBackground;
    
    import events.NavigationEvent;
    
    import feathers.themes.ExtendedMetalWorksMobileTheme;
    
    import screens.DragDigitsScreen;
    
    import starling.core.Starling;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.textures.Texture;
    import starling.utils.AssetManager;
    
    import utils.ProgressBar;
    import utils.Settings;

    /** The Root class is the topmost display object in your game. It loads all the assets
     *  and displays a progress bar while this is happening. Later, it is responsible for
     *  switching between game and menu. For this, it listens to "START_GAME" and "GAME_OVER"
     *  events fired by the Menu and Game classes. Keep this class rather lightweight: it 
     *  controls the high level behaviour of your game. */
    public class Root extends Sprite
    {
        private static var sAssets:AssetManager;
		private static var _defaultBackground:DefaultBackground;		
		private static var _stageWidth:int;
		private static var _stageHeight:int;		
        private var mActiveScene:Sprite;
		
		private static var _defaultLanguage:String = Constants.ENG;
		
		private static var _resourceManager:IResourceManager = ResourceManager.getInstance();
		
		
		//private static var _resourceBundle:ResourceBundle;
        
        public function Root()
        {
            addEventListener(NavigationEvent.START_GAME, onStartGame);
            addEventListener(NavigationEvent.RETURN_TO_MENU,  onReturnToMenuEventHandler);
            
            // not more to do here -- Startup will call "start" immediately.
        }
		
				
        public function start(background:Texture, assets:AssetManager, width:int, height:int):void
        {
            // the asset manager is saved as a static variable; this allows us to easily access
            // all the assets from everywhere by simply calling "Root.assets"
			
			resourceManager = ResourceManager.getInstance();
			//resourceBundle = new ResourceBundle();
			
			if(!Settings.languageSet) {
				
				trace("Language set >>> " + Settings.languageSet);
				//prompt language settings 
			}
			
			defaultLanguage = Settings.language;
			trace(defaultLanguage);
			
			new ExtendedMetalWorksMobileTheme(this, false);
			
			/*if(defaultLanguage == Constants.ENG) {
				
				Settings.updateLanguage(Constants.PL);
			}else
			{
				Settings.updateLanguage(Constants.ENG);
			}*/
            
			sAssets = assets;
            stageWidth = width;
			stageHeight = height;
			
            // The background is passed into this method for two reasons:
            // 
            // 1) we need it right away, otherwise we have an empty frame
            // 2) the Startup class can decide on the right image, depending on the device.
            
            addChild(new Image(background));
            
            // The AssetManager contains all the raw asset data, but has not created the textures
            // yet. This takes some time (the assets might be loaded from disk or even via the
            // network), during which we display a progress indicator. 
            
            var progressBar:ProgressBar = new ProgressBar(175, 20);
            progressBar.x = (background.width  - progressBar.width)  / 2;
            progressBar.y = (background.height - progressBar.height) / 2;
            progressBar.y = background.height * 0.85;
            addChild(progressBar);
            
            assets.loadQueue(function onProgress(ratio:Number):void
            {
                progressBar.ratio = ratio;
                
                // a progress bar should always show the 100% for a while,
                // so we show the main menu only after a short delay. 
                
                if (ratio == 1)
                    Starling.juggler.delayCall(function():void
                    {
                        progressBar.removeFromParent(true);
						defaultBackground = new DefaultBackground();
                        showScene(Menu);
                        
                        // now would be a good time for a clean-up 
                        System.pauseForGCIfCollectionImminent(0);
                        System.gc();
                    }, 0.15);
            });
        }
        
        private function onGameOver(event:Event, score:int):void
        {
            trace("Game Over! Score: " + score);
            showScene(Menu);
        }
        
        private function onStartGame(event:Event, gameMode:String):void
        {
            trace("Game starts! Mode: " + gameMode);
            showScene(DragDigitsScreen);
        }
		
		private function onReturnToMenuEventHandler(event:Event, gameMode:String):void
		{
			// now would be a good time for a clean-up 
			System.pauseForGCIfCollectionImminent(0);
			showScene(Menu);
		}
        
        private function showScene(screen:Class):void
        {
            if (mActiveScene) mActiveScene.removeFromParent(true);
            mActiveScene = new screen();
            addChild(mActiveScene);
        }
        
        public static function get assets():AssetManager { return sAssets; }

		
	
		public static function get defaultBackground():DefaultBackground
		{
			return _defaultBackground;
		}

		public static function set defaultBackground(value:DefaultBackground):void
		{
			_defaultBackground = value;
		}

		public static function get stageWidth():int
		{
			return _stageWidth;
		}

		public static function set stageWidth(value:int):void
		{
			_stageWidth = value;
		}

		public static function get stageHeight():int
		{
			return _stageHeight;
		}

		public static function set stageHeight(value:int):void
		{
			_stageHeight = value;
		}

		public static function get defaultLanguage():String
		{
			return _defaultLanguage;
		}

		public static function set defaultLanguage(value:String):void
		{
			_defaultLanguage = value;
		}

		/**
		 * Responsibilty Localization
		 * 
		 */
		public static function get resourceManager():IResourceManager
		{
			return _resourceManager;
		}

		/**
		 * @private
		 */
		public static function set resourceManager(value:IResourceManager):void
		{
			_resourceManager = value;
		}

		/*[ResourceBundle("localisation")]
		public static function get resourceBundle():ResourceBundle
		{
			return _resourceBundle;
		}

		public static function set resourceBundle(value:ResourceBundle):void
		{
			_resourceBundle = value;
		}
*/

    }
}