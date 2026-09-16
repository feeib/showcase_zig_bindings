const godot: type = @import("godot");
const gde: type = godot.gde;
const mixins: type = godot.mixins;
const Resource: type = godot.Resource;
const internal: type = godot.internal;

base: gde.c.GDExtensionObjectPtr = null,

x: f64 = 0,

pub fn setX(self: *TestResourceABCD, value: f64) void {
    self.x = value;
}

pub fn getX(self: *TestResourceABCD) f64 {
    return self.x;
}

const TestResourceABCD: type = @This();
pub const GodotStruct: type = mixins.GodotStructMixin(TestResourceABCD, Resource);
pub const GodotExport = .{
    .methods = .{
        .{ .func = setX, .args = .{.{ .name = "value", .type = f64 }} },
        .{ .func = getX, .args = .{} },
    },
    .properties = .{
        .{ .name = "x", .getter = getX, .setter = setX, .hint = internal.PropertyHint.none, .hints = "", .usage = internal.PropertyUsageFlags.default },
    },
};
