
import os
import struct
import math
import mathutils

import bpy
import bpy_extras.image_utils
import bpy_extras.node_shader_utils

import collections

def read_kind(file):
    return file.read(4).decode()

def read_uint(file):
    return struct.unpack('<I', file.read(4))[0]

def read_sint(file):
    return struct.unpack('<i', file.read(4))[0]

def read_ushort(file):
    return struct.unpack('<H', file.read(2))[0]

def read_float(file):
    return struct.unpack('<f', file.read(4))[0]

def read_string(file):
    return file.read( read_ushort(file) ).decode()

def read_vec(file, components):
    res = mathutils.Vector()
    
    for i in range(components):
        res[i] = read_float(file)
        
    return res

def iter_chunks(file, limit):    
    while(file.tell() < limit):
        kind = read_kind(file)
        size = read_uint(file)
        
        last = file.tell() + size
    
        yield (kind, last)
    
        file.seek(last)


class ParsingContext():
    def __init__(self):
        self.scale = 0.005  # Sr model files are HUGE in blender units..

        self.folder   = None        
        self.objects = []
        self.parents = []

        self.mesh = None
        self.obj  = None

def parse_material(file, limit, ctx):
    
    # TODO: These properties are actually unsupported, first DIFF applies to whole object
    numFaces    = read_uint(file)
    vertexStart = read_uint(file)
    vertexEnd   = read_uint(file) + vertexStart
    
    diffuse = None
    
    for (kind, limit) in iter_chunks(file, limit):    
        if kind == 'DIFF':
            diffuse = read_string(file)
            
            # All textures are supposed to be .png files
            diffuse = diffuse.replace('.tga', '.png')
            
        # Other settings are not supported
        pass

    # Sanity check
    if not diffuse:
        return

    # Assign material to mesh vertices
    uid = diffuse

    # Reuse existing material if exists, create in worst case
    material = bpy.data.materials.get(uid)
    
    if not material:
        material = bpy.data.materials.new(uid)

        wrapper = bpy_extras.node_shader_utils.PrincipledBSDFWrapper(material, is_readonly=False)  

        wrapper.base_color = (1, 1, 1)
        wrapper.use_nodes  = True

        # Load/create the diffuse texture for this material
        wrapper.base_color_texture.image = bpy_extras.image_utils.load_image(diffuse, ctx.folder, place_holder=True)
    
    # Associate material with the current object
    materialID = len(ctx.mesh.materials)

    ctx.mesh.materials.append(material)

    # Apply material selectively to the selected polygons
    for poly in ctx.mesh.polygons:
        for vertexID in poly.vertices:
            
            if vertexStart <= vertexID and vertexID <= vertexEnd:
                poly.material_index = materialID

def parse_object(file, limit, ctx):
    name     = read_string(file)
    parentID = read_sint(file)
    
    # Allocate associated blender structures
    ctx.mesh = bpy.data.meshes.new(name)
    ctx.obj  = bpy.data.objects.new(name, ctx.mesh)
    
    # Add to parsing context
    ctx.objects.append(ctx.obj)
    ctx.parents.append(parentID)

    # Parse transformation, location
    ctx.obj.matrix_local = (
        (read_float(file), read_float(file), read_float(file), 0),
        (read_float(file), read_float(file), read_float(file), 0),
        (read_float(file), read_float(file), read_float(file), 0),
        (0,                0,                0,                1)
    )
    ctx.obj.location = read_vec(file, 3) * ctx.scale
    
    # Parse various object attributes
    vertex_pos  = None
    vertex_norm = None
    vertex_uv   = None

    for (kind, limit) in iter_chunks(file, limit):
        
        if kind == 'VERT':
            vertexNum    = read_uint(file)
            vertexFormat = read_uint(file)

            if vertexNum > 0xFFFF:
                raise IOError('Too many vertices')
    
            if vertexFormat != 0: 
                raise IOError('Unsupported vertex format') # TODO: Support format 1
    
            vertex_pos  = []
            vertex_norm = []
            vertex_uv   = []
    
            for idx in range(vertexNum):
                vertex_pos.append( read_vec(file, 3) * ctx.scale )
                vertex_norm.append( read_vec(file, 3) )
                
                # Whacky coordinate systems..
                vertex_uv.append((
                    0 + read_float(file), 
                    1 - read_float(file)
                ))
                
        if kind == 'FACE':
            faceNum = read_uint(file)
            
            faces = []
            
            for idx in range(faceNum):
                faces.append((
                    read_ushort(file),
                    read_ushort(file),
                    read_ushort(file)          
                ))
                
            # Fill mesh data with geometry (vertices, faces)
            ctx.mesh.from_pydata(vertex_pos, [], faces)
            ctx.mesh.update()
            
            # Create UV mapping
            uv_layer = ctx.mesh.uv_layers.new()

            for idx, loop in enumerate(ctx.mesh.loops):
                uv_layer.data[idx].uv = vertex_uv[loop.vertex_index]
        
        if kind == 'MTLS':
            materialNum = read_uint(file)
            
            for (kind, limit) in iter_chunks(file, limit):
                if kind != 'MATE':
                    continue
                
                parse_material(file, limit, ctx)
            
        pass
    
    # End of MESH chunks
    return

def parse_4d_model(filepath, file):
    
    if file.read(8) != b'\x53\x72\x1A\x1B\x0D\x0A\x87\x0A':
        raise IOError('Not a Stormregion file')

    # Setup parsing context
    ctx = ParsingContext()
    ctx.folder = os.path.dirname(filepath)

    # Create root object representing the model
    root = bpy.data.objects.new('4d_model', None)
    
    root.empty_display_type = 'CIRCLE'
    root.empty_display_size = 1

    # Rotate root object to compensate some the wacky coordinate system
    root.rotation_euler = (math.radians(90), 0, 0)

    # Add to parsing context, everything will be parented to this
    ctx.objects.append(root)
    ctx.parents.append(None)

    # ONE section should follow immediately
    for (kind, limit) in iter_chunks(file, 128):
        if kind != 'SCEN':
            raise IOError('Not a SCEN file')
    
        if file.read(4) != b'v100':
            raise IOError('Unsupported SCEN version')
            
        for (kind, limit) in iter_chunks(file, limit):
            if kind != 'MESH':
                raise IOError('Unsupported scene entry')
            
            parse_object(file, limit, ctx)
    
    # Restore parent hierarchy between the objects
    for idx, obj in enumerate(ctx.objects):
        bpy.context.scene.collection.objects.link(obj)

        parentID = ctx.parents[idx]
        
        if parentID:        
            obj.parent      = ctx.objects[parentID +1]
            obj.parent_type = 'OBJECT'
        
    return {'FINISHED'}



from bpy_extras.io_utils import ImportHelper
from bpy.props import StringProperty, BoolProperty, EnumProperty
from bpy.types import Operator

class Import4DModel(Operator, ImportHelper):
    """Import Stormregion 4D model files"""
    
    bl_idname = "import_4d.model" 
    bl_label  = "Import 4D Model"

    # ImportHelper mixin class uses this
    filename_ext = ".4d"

    filter_glob: StringProperty(default="*.4d", options={'HIDDEN'}, maxlen=255)

    def execute(self, context):
        with open(self.filepath, 'rb') as file:
            return parse_4d_model(self.filepath, file)


def menu_func_import(self, context):
    self.layout.operator(Import4DModel.bl_idname, text="Import Stormregion 4D Model (.4d)")

def register():
    bpy.utils.register_class(Import4DModel)
    bpy.types.TOPBAR_MT_file_import.append(menu_func_import)

def unregister():
    bpy.utils.unregister_class(Import4DModel)
    bpy.types.TOPBAR_MT_file_import.remove(menu_func_import)

if __name__ == "__main__":
    register()

    # Trigger import action immediately
    # bpy.ops.import_4d.model('INVOKE_DEFAULT')
