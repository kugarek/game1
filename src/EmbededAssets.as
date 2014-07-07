package
{
	import flash.display.Bitmap;
	import flash.media.Sound;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;

	public class EmbededAssets
	{
		
		private static var instance : EmbededAssets;
		
		[Embed(source="../assets/textures/x1/background.png")]/* background with clouds etc.*/
		public static const Scene1BGD:Class;
		
		[Embed(source="../assets/textures/x1/sky@2x.png")]/* just sky background.*/
		public static const Sky:Class;
		
		[Embed(source="../assets/textures/x1/ground@2x.png")]/* just sky background.*/
		public static const Ground:Class;
		
		
		[Embed(source="../assets/textures/x1/digits_buttonDown@2xEng.png")]/* Digits btn down skin Eng*/
		public static const DigitsBtnDownSkinEng:Class;
		
		[Embed(source="../assets/textures/x1/digits_buttonDown@2xPl.png")]/* Digits btn down skin Pl*/
		public static const DigitsBtnDownSkinPl:Class;
		
		[Embed(source="../assets/textures/x1/digits_buttonUp@2xEng.png")]/* Digits btn Up skin Eng*/
		public static const DigitsBtnUpSkinEng:Class;
		
		[Embed(source="../assets/textures/x1/digits_buttonUp@2xPl.png")]/* Digits btn Up skin Pl*/
		public static const DigitsBtnUpSkinPl:Class;
		
		
		private static var gameTextures:Dictionary = new Dictionary();
		
		public static function getTexture(name:String):Texture
		{
			if (gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new EmbededAssets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			
			return gameTextures[name];
		}
		
		
		public function EmbededAssets( enforcer:AssetsEnforcer )
		{
			if (enforcer == null)
			{
				throw new Error( "Only one Assets instance should be instantiated" );
			}
		}
		
		
		// Returns the Single Instance
		public static function getInstance() : EmbededAssets
		{
			if (instance == null)
			{
				instance = new EmbededAssets ( new AssetsEnforcer );
			}
			return instance;
		}
		
		
		
		//------------------------------------------------------------------------
		//	SOUNDS
		
		private static var sSounds:Dictionary = new Dictionary();
		
		
		[Embed(source="../assets/sounds/bgm/203099__lemoncreme__groove-music.mp3")]/* main bacground music */
		public static const BgmGrooveSound:Class;
		
		[Embed(source="../assets/sounds/sfx/32260__sagetyrtle__smallcrowd.mp3")]/* crowd cheering */
		public static const SmallCrowdCheerSFX:Class;
		
		[Embed(source="../assets/sounds/sfx/193676__griffy100__gatedenied.mp3")]/* crowd cheering */
		public static const FailSFX:Class;
		
		
		//------------------
		// English sounds
				
		[Embed(source="../assets/sounds/voice/67738__corsica-s__0.mp3")]/* 0 ENG */
		public static const ZeroEng:Class;
		
		[Embed(source="../assets/sounds/voice/67739__corsica-s__1.mp3")]/* 1 ENG */
		public static const OneEng:Class;
		
		[Embed(source="../assets/sounds/voice/67750__corsica-s__2.mp3")]/* 2 ENG */
		public static const TwoEng:Class;
		
		[Embed(source="../assets/sounds/voice/67752__corsica-s__3.mp3")]/* 3 ENG */
		public static const ThreeEng:Class;
		
		[Embed(source="../assets/sounds/voice/67753__corsica-s__4.mp3")]/* 4 ENG */
		public static const FourEng:Class;
		
		[Embed(source="../assets/sounds/voice/67754__corsica-s__5.mp3")]/* 5 ENG */
		public static const FiveEng:Class;
		
		[Embed(source="../assets/sounds/voice/67755__corsica-s__6.mp3")]/* 6 ENG */
		public static const SixEng:Class;
		
		[Embed(source="../assets/sounds/voice/67756__corsica-s__7.mp3")]/* 7 ENG */
		public static const SevenEng:Class;
		
		[Embed(source="../assets/sounds/voice/67757__corsica-s__8.mp3")]/* 8 ENG */
		public static const EightEng:Class;
		
		[Embed(source="../assets/sounds/voice/67758__corsica-s__9.mp3")]/* 9 ENG */
		public static const NineEng:Class;
		
		//------------------
		// Polish sounds
		
		[Embed(source="../assets/sounds/voice/67738__corsica-s__0.mp3")]/* 0 Pl */
		public static const ZeroPl:Class;
		
		[Embed(source="../assets/sounds/voice/67739__corsica-s__1.mp3")]/* 1 Pl */
		public static const OnePl:Class;
		
		[Embed(source="../assets/sounds/voice/67750__corsica-s__2.mp3")]/* 2 Pl */
		public static const TwoPl:Class;
		
		[Embed(source="../assets/sounds/voice/67752__corsica-s__3.mp3")]/* 3 Pl */
		public static const ThreePl:Class;
		
		[Embed(source="../assets/sounds/voice/67753__corsica-s__4.mp3")]/* 4 Pl */
		public static const FourPl:Class;
		
		[Embed(source="../assets/sounds/voice/67754__corsica-s__5.mp3")]/* 5 Pl */
		public static const FivePl:Class;
		
		[Embed(source="../assets/sounds/voice/67755__corsica-s__6.mp3")]/* 6 Pl */
		public static const SixPl:Class;
		
		[Embed(source="../assets/sounds/voice/67756__corsica-s__7.mp3")]/* 7 Pl */
		public static const SevenPl:Class;
		
		[Embed(source="../assets/sounds/voice/67757__corsica-s__8.mp3")]/* 8 Pl */
		public static const EightPl:Class;
		
		[Embed(source="../assets/sounds/voice/67758__corsica-s__9.mp3")]/* 9 Pl */
		public static const NinePl:Class;
		
		public static function prepareSounds():void
		{
			sSounds["BgmGrooveSound"] = new BgmGrooveSound();   
			sSounds["SmallCrowdCheerSFX"] = new SmallCrowdCheerSFX();   
			sSounds["FailSFX"] = new FailSFX();   
			sSounds["ZeroEng"] = new ZeroEng();  
			sSounds["OneEng"] = new OneEng(); 
			sSounds["TwoEng"] = new TwoEng(); 
			sSounds["ThreeEng"] = new ThreeEng(); 
			sSounds["FourEng"] = new FourEng(); 
			sSounds["FiveEng"] = new FiveEng(); 
			sSounds["SixEng"] = new SixEng(); 
			sSounds["SevenEng"] = new SevenEng(); 
			sSounds["EightEng"] = new EightEng(); 
			sSounds["NineEng"] = new NineEng(); 
			
			sSounds["ZeroPl"] = new ZeroPl();  
			sSounds["OnePl"] = new OnePl(); 
			sSounds["TwoPl"] = new TwoPl(); 
			sSounds["ThreePl"] = new ThreePl(); 
			sSounds["FourPl"] = new FourPl(); 
			sSounds["FivePl"] = new FivePl(); 
			sSounds["SixPl"] = new SixPl(); 
			sSounds["SevenPl"] = new SevenPl(); 
			sSounds["EightPl"] = new EightPl(); 
			sSounds["NinePl"] = new NinePl();
		}
		
		public static function getSound(name:String):Sound
		{
			var sound:Sound = sSounds[name] as Sound;
			if (sound) return sound;
			else throw new ArgumentError("Sound not found: " + name);
		}
		
	}
}

class AssetsEnforcer {}

