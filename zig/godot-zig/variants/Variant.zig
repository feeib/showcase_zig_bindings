const std: type = @import("std");

const godot: type = @import("../godot.zig");
const gde: type = godot.gde;
const String: type = godot.String;
const StringName: type = godot.StringName;
const internal: type = godot.internal;

const Variant: type = @This();

const variant_size: u64 = 24;
@"opaque": [variant_size]u8 align(8) = std.mem.zeroes([variant_size]u8),

pub const Type = enum(gde.c.GDExtensionVariantType) {
    nil = 0,
    bool = 1,
    int = 2,
    float = 3,
    string = 4,
    vector2 = 5,
    vector2i = 6,
    rect2 = 7,
    rect2i = 8,
    vector3 = 9,
    vector3i = 10,
    transform2d = 11,
    vector4 = 12,
    vector4i = 13,
    plane = 14,
    quaternion = 15,
    aabb = 16,
    basis = 17,
    transform3d = 18,
    projection = 19,
    color = 20,
    string_name = 21,
    node_path = 22,
    rid = 23,
    object = 24,
    callable = 25,
    signal = 26,
    dictionary = 27,
    array = 28,
    packed_byte_array = 29,
    packed_int32_array = 30,
    packed_int64_array = 31,
    packed_float32_array = 32,
    packed_float64_array = 33,
    packed_string_array = 34,
    packed_vector2_array = 35,
    packed_vector3_array = 36,
    packed_color_array = 37,
    packed_vector4_array = 38,
    variant_max = 39,
};

pub fn nil() Variant {
    var ret: Variant = .{};
    gde.ci.variant_new_nil.?(@ptrCast(&ret));
    return ret;
}

pub fn init(value: anytype) Variant {
    const T: type = @TypeOf(value);
    const variant_type: gde.c.GDExtensionVariantType = internal.toVariantType(T);
    var ret: Variant = .{};

    internal.VariantInternal.raw_bindings.from_type_constructor[variant_type].?(@ptrCast(&ret), if (@typeInfo(T) == .pointer) @ptrCast(value) else @ptrCast(@constCast(&value)));
    return ret;
}

pub fn deinit(self: *Variant) void {
    gde.ci.variant_destroy.?(@ptrCast(self));
    self.* = undefined;
}
