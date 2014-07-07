package 
{
    import feathers.controls.ScreenNavigator;
    import feathers.controls.ScreenNavigatorItem;
    import feathers.motion.transitions.ScreenFadeTransitionManager;
    
    import screens.DragDigitsScreen;
    import screens.HomeScreen;
    import screens.Screens;
    
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;

    /** The Game class represents the actual game. In this scaffold, it just displays a 
     *  Starling that moves around fast. When the user touches the Starling, the game ends. */ 
    public class Game extends Sprite
    {
        public static const GAME_OVER:String = "gameOver";
        
        private var mBird:Image;
        
      
		private var screenNavigator:ScreenNavigator;
		private var screenTransitionsManager:ScreenFadeTransitionManager;
		private var screenManager:ScreenManager;		
		private var screenWelcome:HomeScreen;
		private var dragDigitsScreen:DragDigitsScreen;
		
		public function Game()
		{
			//super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onStageReady);
		}
		
		private function onStageReady(even:Event):void
		{
			trace("starling framwork initialize");
			setupScreens();				
		}
		
		private function setupScreens():void
		{
			screenManager = new ScreenManager(Screens.HOME_SCREEN);
			
			screenNavigator = new ScreenNavigator();
			screenNavigator.addScreen(Screens.HOME_SCREEN, new ScreenNavigatorItem(HomeScreen));
			screenNavigator.addScreen(Screens.DRAG_DIGITS_SCREEN, new ScreenNavigatorItem(DragDigitsScreen));
			screenTransitionsManager = new ScreenFadeTransitionManager(screenNavigator);
			screenNavigator.showScreen(Screens.HOME_SCREEN);			
			screenWelcome = new HomeScreen();
			this.addChild(screenNavigator);
			//screenWelcome.initialize();
		}
    }
}