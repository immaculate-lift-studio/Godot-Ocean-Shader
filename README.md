# Ocean Shader for Godot 

This is a water surface shader for Godot 4 that I am using in my helicopter project. I wanted to make a simple water shader that blended two textures and had vertex displacement, and could also pixelate the texture for a more old-school look. Features include:

* 2-layer customizable textures (current is a royalty-free placeholder) that can move in different directions and have adjustable blending levels

* Vertex-based wave displacement based on Godot's fastnoiselite

* Control the level of pixelation in each texture
  
* Opacity and edge foam is customizable

Performance: The vertex displacement uses global coordinates, so you can tile multiple smaller meshes so take advantage of camera culling (they will match seamlessly). 

I have tested this in small maps (100×100) as well as large maps (6000×6000) with no issues.

Remember if you scale up the size, you will need to subdivide the mesh AND raise the UV scaling for all textures. 

## License
MIT. I hope this helps somebody in their Godot journey!


If you like what I'm doing and want to support me, please [![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/C0C8YOTVD)
