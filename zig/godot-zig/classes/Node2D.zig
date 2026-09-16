const godot: type = @import("../godot.zig");
const gde: type = godot.gde;
const internal: type = godot.internal;
const Vector2f: type = godot.Vector2f;

const Node2D: type = @This();

pub fn setPosition(
    instance: anytype,
    position: Vector2f,
) void {
    internal.ptrCallNativeMethodBindNoRetAnytype(internal.Node2DInternal.raw_bindings.set_position, instance.base.?, .{&position});
}
