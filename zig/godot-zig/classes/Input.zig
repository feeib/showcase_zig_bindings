const godot: type = @import("../godot.zig");
const gde: type = godot.gde;
const StringName: type = godot.StringName;
const misc: type = godot.misc;
const mixins: type = godot.mixins;
const Object: type = godot.Object;
const internal: type = godot.internal;
const Vector2f: type = godot.Vector2f;

const Input: type = @This();
pub const GodotStruct: type = mixins.GodotBindingStructMixin(Input, Object);

base: gde.c.GDExtensionObjectPtr,
var instance: ?*Input = null;

pub fn getSingleton() *Input {
    if (instance == null) {
        @branchHint(.unlikely);
        var struct_name: StringName = .initWithLatin(misc.typeName(Input), false);
        defer struct_name.deinit();
        const singleton: gde.c.GDExtensionObjectPtr = gde.ci.global_get_singleton.?(&struct_name);
        instance = @ptrCast(@alignCast(gde.ci.object_get_instance_binding.?(singleton, gde.library, &Input.GodotStruct.binding_callbacks)));
        if (instance == null) {
            @branchHint(.likely);
            // class db register engine singleton
            // ClassDB::_register_engine_singleton(Input::get_class_static(), singleton);
        }
    }
    return instance orelse @panic("input singleton is null");
}

pub fn isAnythingPressed(
    self: *Input,
) bool {
    return internal.ptrCallNativeMethodBindRetAnytype(i8, internal.InputInternal.raw_bindings.is_anything_pressed, self.base.?, .{}) != 0;
}

pub fn getVector(
    self: *Input,
    negative_x: *StringName,
    positive_x: *StringName,
    negative_y: *StringName,
    positive_y: *StringName,
    deadzone: f64,
) Vector2f {
    var deadzone_encoded: f64 = deadzone;
    return internal.ptrCallNativeMethodBindRetAnytype(Vector2f, internal.InputInternal.raw_bindings.get_vector, self.base.?, .{ negative_x, positive_x, negative_y, positive_y, &deadzone_encoded });
}
