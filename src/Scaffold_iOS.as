package
{
    import flash.desktop.NativeApplication;
    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.filesystem.File;
    import flash.geom.Rectangle;
    import flash.system.Capabilities;
    
    import starling.core.Starling;
    import starling.events.Event;
    import starling.textures.Texture;
    import starling.utils.AssetManager;
    import starling.utils.formatString;
    
    import utils.SoundPlayer;
    
    [SWF(frameRate="30", backgroundColor="#000")]
    public class Scaffold_iOS extends Sprite
    {
        private var mStarling:Starling;
		
		[Embed(source="/background.png")]/* background */
		public static const LoadingBgd:Class;
		        
        public function Scaffold_iOS()
        {
            // set general properties
            
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            
            Starling.multitouchEnabled = true;  // useful on mobile devices
            Starling.handleLostContext = false; // not necessary on iOS. Saves a lot of memory!
            
            // Create a suitable viewport for the screen size.
            // 
            // On the iPhone, the viewPort will fill the complete screen; on the iPad, there
            // will be black bars at the left and right, because it has a different aspect ratio.
            // Since the game is scaled up a little, it won't be as perfectly sharp as on the 
            // iPhone. Alernatively, you can exchange this code with the one used in the Starling
            // demo: it does not scale the viewPort, but adds bars on all sides.

           /* var screenWidth:int  = stage.fullScreenWidth;
            var screenHeight:int = stage.fullScreenHeight;
            var viewPort:Rectangle = new Rectangle();
            
            if (screenHeight / screenWidth < Constants.ASPECT_RATIO)
            {
                viewPort.height = screenHeight;
                viewPort.width  = int(viewPort.height / Constants.ASPECT_RATIO);
                viewPort.x = int((screenWidth - viewPort.width) / 2);
            }
            else
            {
                viewPort.width = screenWidth; 
                viewPort.height = int(viewPort.width * Constants.ASPECT_RATIO);
                viewPort.y = int((screenHeight - viewPort.height) / 2);
            }*/
			
			var isPortrait:Boolean = Constants.STAGE_WIDTH < Constants.STAGE_HEIGHT;
			var screenWidth:int  = Math.max(stage.fullScreenWidth, stage.fullScreenHeight);
			var screenHeight:int = Math.min(stage.fullScreenWidth, stage.fullScreenHeight);
			var viewPort:Rectangle = new Rectangle();
			
			if (screenHeight / screenWidth < Constants.ASPECT_RATIO)
			{
				viewPort.height = screenHeight;
				viewPort.width  = int(viewPort.height / Constants.ASPECT_RATIO);
				viewPort.x = int((screenWidth - viewPort.width) / 2);
			}
			else
			{
				viewPort.width = screenWidth;
				viewPort.height = int(viewPort.width * Constants.ASPECT_RATIO);
				viewPort.y = int((screenHeight - viewPort.height) / 2);
			}
			
			
			
			//Load assets 
			var assets:AssetManager = new AssetManager();		
			var appDir:File = File.applicationDirectory;
			assets.verbose = Capabilities.isDebugger;
			
			assets.enqueue(
				appDir.resolvePath("sounds"),
				/*appDir.resolvePath(formatString("fonts/{0}x")),*/
				appDir.resolvePath(formatString("textures/x1"))
			);
            
            // While Stage3D is initializing, the screen will be blank. To avoid any flickering, 
            // we display a startup image for now, but will remove it when Starling is ready to go.
            //
            // (Note that we *cannot* embed the "Default*.png" images, because then they won't
            //  be copied into the package any longer once they are embedded.)
			
			var backgroundClass:Class = LoadingBgd;
			var background:Bitmap = new backgroundClass();			
			//addChild(background);
            
            var startupImage:Sprite = createStartupImage(viewPort, screenWidth > 320);
            addChild(startupImage);
            
            // Set up Starling
            
            mStarling = new Starling(Root, stage, viewPort);
            
           /* mStarling.addEventListener(starling.events.Event.ROOT_CREATED, function(e:Event):void 
            {
                // Starling is ready! We remove the startup image and start the game.
                removeChild(startupImage);
                mStarling.start();
            });*/
			
			mStarling.addEventListener(starling.events.Event.ROOT_CREATED, 
				function(event:Object, app:Root):void
				{
					mStarling.removeEventListener(starling.events.Event.ROOT_CREATED, arguments.callee);
					removeChild(startupImage);
					startupImage = null;
					
					var bgTexture:Texture = Texture.fromEmbeddedAsset(
						backgroundClass, false, false);
															
					app.start(bgTexture, assets, Constants.STAGE_WIDTH, Constants.STAGE_HEIGHT);
					mStarling.start();
				});
            
            // When the game becomes inactive, we pause Starling; otherwise, the enter frame event
            // would report a very long 'passedTime' when the app is reactivated. 
            
            /*NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, 
                function (e:Event):void { mStarling.start(); });
            
            NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, 
                function (e:Event):void { mStarling.stop(); });*/
			
			NativeApplication.nativeApplication.addEventListener(
				flash.events.Event.ACTIVATE, activateStarling);
			
			NativeApplication.nativeApplication.addEventListener(
				flash.events.Event.DEACTIVATE, deactivateStarling);
        }
		
		
		protected function deactivateStarling(event:flash.events.Event):void
		{
			SoundPlayer.stopAllSounds();
			mStarling.stop(true); 
		}
		
		protected function activateStarling(event:*):void
		{
			mStarling.start();
			SoundPlayer.resumeSounds();
		}
		
        
        private function createStartupImage(viewPort:Rectangle, isHD:Boolean):Sprite
        {
            var sprite:Sprite = new Sprite();
            
            var background:Bitmap = isHD ?
                new EmbededAssets.LoadingBgd() : new EmbededAssets.LoadingBgd();
            
            /*var loadingIndicator:Bitmap = isHD ?
                new AssetEmbeds_2x.Loading() : new AssetEmbeds_1x.Loading();*/
            
            background.smoothing = true;
            sprite.addChild(background);
            
            /*loadingIndicator.smoothing = true;
            loadingIndicator.x = (background.width - loadingIndicator.width) / 2;
            loadingIndicator.y =  background.height * 0.75;
            sprite.addChild(loadingIndicator);*/
            
            sprite.x = viewPort.x;
            sprite.y = viewPort.y;
            sprite.width  = viewPort.width;
            sprite.height = viewPort.height;
            
            return sprite;
        }
    }
}