const godot: type = @import("../godot.zig");
const gde: type = godot.gde;
const mixins: type = godot.mixins;
const Object: type = godot.Object;
const StringName: type = godot.StringName;
const internal: type = godot.internal;

const RefCounted: type = @This();
const GodotStruct: type = mixins.GodotBindingStructMixin(RefCounted, Object);

base: gde.c.GDExtensionObjectPtr,

pub fn initRef(instance: anytype) bool {
    return internal.ptrCallNativeMethodBindRetAnytype(bool, internal.RefCountedInternal.raw_bindings.init_ref, instance.base.?, .{});
}

pub fn reference(instance: anytype) bool {
    return internal.ptrCallNativeMethodBindRetAnytype(bool, internal.RefCountedInternal.raw_bindings.reference, instance.base.?, .{});
}

pub fn unreference(instance: anytype) bool {
    return internal.ptrCallNativeMethodBindRetAnytype(bool, internal.RefCountedInternal.raw_bindings.unreference, instance.base.?, .{});
}

pub fn getReferenceCount(instance: anytype) i32 {
    return internal.ptrCallNativeMethodBindRetAnytype(i32, internal.RefCountedInternal.raw_bindings.get_reference_count, instance.base.?, .{});
}
