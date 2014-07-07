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
    import starling.utils.RectangleUtil;
    import starling.utils.ScaleMode;
    import starling.utils.formatString;
    
    import utils.SoundPlayer;
    
    [SWF(frameRate="60", backgroundColor="#000")]
    public class Scaffold_Mobile extends Sprite
    {
		
		[Embed(source="/background.png")]/* background */
		public static const LoadingBgd:Class;
		
		private var stats:Stats;
		private var _starling:Starling;
		private var _targetStageWidth:int;
		private var _targetStageHeight:int;
		
		private var language:String;
		
		public function Scaffold_Mobile() 
		{
			stats = new Stats();
			this.addChild(stats);
						
							
			//Setup the stage
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
						
						
			var iOS:Boolean = Capabilities.manufacturer.indexOf("iOS") != -1;
			
			//Setup starling
			Starling.multitouchEnabled = true;
			Starling.handleLostContext = true;
			Starling.handleLostContext = !iOS;  // not necessary on iOS. Saves a lot of memory!
			
			//Set target dimensions
			targetStageWidth = 2048;
			targetStageHeight = 1536;
			
			//Get the stage dimensions
			var stageWidth:int = stage.stageWidth;
			var stageHeight:int = stage.stageHeight;
			
			var assets:AssetManager = new AssetManager();		
			var appDir:File = File.applicationDirectory;
			assets.verbose = Capabilities.isDebugger;
						
			assets.enqueue(
				appDir.resolvePath("sounds"),
				/*appDir.resolvePath(formatString("fonts/{0}x")),*/
				appDir.resolvePath(formatString("textures/x1"))
			);
			
			var backgroundClass:Class = LoadingBgd;
			var background:Bitmap = new backgroundClass();			
			addChild(background);
			
			//Check if mobile and set screen dimensions
			if ((Capabilities.version.substr(0, 3) == "IOS") || (Capabilities.version.substr(0, 3) == "AND"))
			{
				stageWidth = stage.fullScreenWidth;
				stageHeight = stage.fullScreenHeight;
			}
			
			//Check if we're an iPad, if so, set minimum stage dimensions
			if (stageWidth == 1024 || stageWidth == 768)
			{
				targetStageWidth = 2048;
				targetStageHeight = 1536;
			}
			
			//Set viewport
			var viewport:Rectangle = RectangleUtil.fit(new Rectangle(0, 0, targetStageWidth, targetStageHeight), 
				new Rectangle(0, 0, stageWidth, stageHeight), 
				ScaleMode.SHOW_ALL);
			
			//Create instance
			_starling = new Starling(Root, stage, viewport);
			_starling.antiAliasing = 1;
			_starling.simulateMultitouch = false;
			_starling.stage.stageWidth  = targetStageWidth;
			_starling.stage.stageHeight = targetStageHeight;
			
			//Debug, can turn off
			_starling.showStats = false;
			
			
			_starling.addEventListener(starling.events.Event.ROOT_CREATED, 
				function(event:Object, app:Root):void
				{
					_starling.removeEventListener(starling.events.Event.ROOT_CREATED, arguments.callee);
					removeChild(background);
					background = null;
					
					var bgTexture:Texture = Texture.fromEmbeddedAsset(
						backgroundClass, false, false);
					
					app.start(bgTexture, assets, targetStageWidth, targetStageHeight);
					_starling.start();
				});
			
						
			//Listen for application activate
			NativeApplication.nativeApplication.addEventListener(
				flash.events.Event.ACTIVATE, activateStarling);
			
			NativeApplication.nativeApplication.addEventListener(
				flash.events.Event.DEACTIVATE, deactivateStarling);
		}
		
		protected function deactivateStarling(event:flash.events.Event):void
		{
			SoundPlayer.stopAllSounds();
			_starling.stop(true); 
		}
		
		protected function activateStarling(event:*):void
		{
			_starling.start();
			SoundPlayer.resumeSounds();
		}
		
		public function get targetStageWidth():int
		{
			return _targetStageWidth;
		}

		public function set targetStageWidth(value:int):void
		{
			_targetStageWidth = value;
		}

		public function get targetStageHeight():int
		{
			return _targetStageHeight;
		}

		public function set targetStageHeight(value:int):void
		{
			_targetStageHeight = value;
		}


    }
}