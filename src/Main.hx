package;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
import openfl.events.TouchEvent;
import com.babylonhx.Scene;
import com.babylonhx.Engine;
import com.babylonhx.mesh.Mesh;
import flixel.FlxGame;

class Main extends Sprite
{
	private var _engine:Engine;
	private var _scene:Scene;

	public function new()
	{
		super();
		stage.addChild(this);

		_engine = new Engine(stage, true);
		_scene = new Scene(_engine);

		_engine.width = stage.stageWidth;
		_engine.height = stage.stageHeight;
		
		stage.addEventListener(Event.RESIZE, resize);
		stage.addEventListener(Event.ENTER_FRAME, update);

		var ground:Mesh = Mesh.CreateGround("ground1", 0.1, 0.1, 1, _scene, false);
		ground.enableEdgesRendering();

#if desktop
		stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
#elseif mobile
		stage.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchStart);
		stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
		stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
#end

		var flixel:FlxGame = new FlxGame(1280, 720, MainState, 1, 60, 60, true);
		addChild(flixel);

		new BasicScene(_scene);
		stage.addChild(new openfl.display.FPS(10, 10, 0xffffff));
	}

	private function resize(e:Event):Void
	{
		_engine.width = stage.stageWidth;
		_engine.height = stage.stageHeight;
	}

	private function onKeyDown(e:KeyboardEvent):Void
	{
		for(f in Engine.keyDown) f(e.charCode);
	}	

	private function onKeyUp(e:KeyboardEvent):Void
	{
		for(f in Engine.keyUp) f(e.charCode);
	}	

	private function onMouseDown(e:MouseEvent):Void
	{
		for(f in Engine.mouseDown) f(e.localX, e.localY, 0);
	}	

	private function onMouseMove(e:MouseEvent):Void
	{
		for(f in Engine.mouseMove) f(e.localX, e.localY);
	}	

	private function onMouseUp(e:MouseEvent):Void
	{
		for(f in Engine.mouseUp) f(e.localX, e.localY, 0);
	}

	private function onMouseWheel(e:MouseEvent):Void
	{
		for (f in Engine.mouseWheel) f(e.delta);
	}

	private function onTouchStart(e:TouchEvent):Void
	{
		for(f in Engine.touchDown) f(e.localX, e.localY, 0);
	}

	private function onTouchEnd(e:TouchEvent):Void
	{
		for(f in Engine.touchUp) f(e.localX, e.localY, 0);
	}	

	private function onTouchMove(e:TouchEvent):Void
	{
		for(f in Engine.touchMove) f(e.localX, e.localY);
	}

	private function update(e):Void
	{
		_engine._renderLoop();
	}
}
