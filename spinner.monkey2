Namespace spinner

#Import "<std>"
#Import "<mojo>"
#Import "<mojo3d>"
#Import "accelerometer"
#Import "models/"

Using std..
Using mojo..
Using mojo3d..
Using accelerometer..

Class MyWindow Extends Window
	
	Field _accel:Accelerometer
	
	Field _scene:Scene
	Field _camera:Camera
	Field _light:Light
	
	Field _spinner:Model
	Field _spinner2:Model
	Field _nativeWidth:Int
	Field _nativeHeight:Int
	Field _virtualResolution:Vec2i
	
	Method New()
		Super.New( "Spinner")
		Layout = "letterbox"
		
		Print "Resolution during Window.New(): " + Width + ", " + Height
		_nativeWidth = Width
		_nativeHeight = Height
		_virtualResolution = New Vec2i((_nativeWidth * 480) / _nativeHeight, 480)
		
		_accel = New Accelerometer()
		
		_scene=New Scene
		
		_light=New Light
		_light.Rotate( 45, 135, 0 )
		_light.CastsShadow = False
		
		'create spinner
		_spinner = Model.Load( "asset::spinner.gltf" )
		'Local xaxis := Model.CreateCone(0.04, 4, Axis.X, 4, New PbrMaterial(Color.Red))
		'xaxis.SetPosition(2, 0, 0)
		'Local yaxis := Model.CreateCone(0.04, 4, Axis.Y, 4, New PbrMaterial(Color.Green))
		'yaxis.SetPosition(0, 2, 0)
		'Local zaxis := Model.CreateCone(0.04, 4, Axis.Z, 4, New PbrMaterial(Color.Blue))
		'zaxis.SetPosition(0, 0, 2)

		'create camera
		_camera=New Camera( )
		_camera.View = Self
		_camera.Near=.1
		_camera.Far=1000
		_camera.FOV = 45
		_camera.SetPosition( 0, 0, 5)
		_camera.PointAt(_spinner)
		
	End
	
	
	Method OnRender( canvas:Canvas ) Override
		RequestRender()
		_spinner.RotateY(10)
		_accel.OnUpdate()
		
		Local g := New Vec3f(0, 0, 0)
		If _accel.Supported Then
			g.x = _accel.GX
			g.y = _accel.GY
			g.z = _accel.GZ
			g *= 9.8
		Else
			Local rZ:Float = ((2.0 * Pi * Mouse.X) / Width) - Pi
			Local rX:Float = ((2.0 * Pi * Mouse.Y) / Height) - Pi
			g.x = -Sin(rZ)
			g.y = Cos(rZ) + Cos(rX)
			g.z = -Sin(rX)
			g = g.Normalize() * 9.8
		Endif
		Local up := New Vec3f(-g.x, g.y, 0)
		Local gxy := Sqrt(g.x * g.x + g.y * g.y)
	  _camera.SetPosition(0, g.z/2, gxy/2)
		_camera.PointAt( _spinner, up) 
		_scene.Update()
		_camera.Render( canvas )
		canvas.DrawText( "Width="+Width+", Height="+Height+", FPS="+App.FPS + "    Aspect=" + _camera.Aspect,0,0 )
		canvas.DrawText( "GX:" + Cast<Int>(10*g.x) + ", GY:" + Cast<Int>(10*g.y) + ", GZ:" + Cast<Int>(10*g.z), 0, 20 )
	
	End
	
	Method OnMeasure:Vec2i() Override
		Return _virtualResolution
	End Method
End

Function Main()
	New AppInstance
	New MyWindow
	App.Run()
End
