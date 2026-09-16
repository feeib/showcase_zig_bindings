const std: type = @import("std");

const godot: type = @import("godot");
const CanvasItem: type = godot.CanvasItem;
const Node: type = godot.Node;
const Node2D: type = godot.Node2D;
const Object: type = godot.Object;
const Sprite2D: type = godot.Sprite2D;
const gde: type = godot.gde;
const internal: type = godot.internal;
const mixins: type = godot.mixins;
const StringName: type = godot.StringName;
const Callable: type = godot.Callable;
const Input: type = godot.Input;
const Vector2f: type = godot.Vector2f;
const RefCounted: type = godot.RefCounted;
const Ref = godot.Ref;

const TestResourceABCD: type = @import("TestResourceABCD.zig");

base: gde.c.GDExtensionObjectPtr = null,

x: f64 = 0,
y: f64 = 0,
xy: Vector2f = .init(0, 0),
speed: f64 = 0,

test_resource_abcd: Ref(TestResourceABCD) = .{},

signal_name: StringName = .{},
callable_on_x_equal_zero: Callable = .{},
func_name: StringName = .{},
negative_x_name: StringName = .{},
positive_x_name: StringName = .{},
negative_y_name: StringName = .{},
positive_y_name: StringName = .{},

pub fn notification(self: *TestNodeABCD, what: i32) void {
    switch (what) {
        Object.notification_postinitialize => {
            self.func_name = .initWithLatin("onXEqualZero", false);
            self.callable_on_x_equal_zero = .initWithObject(self.base.?, &self.func_name);
            self.signal_name = .initWithLatin("on_x_equal_zero", false);
            self.negative_x_name = .initWithLatin("left_move", false);
            self.positive_x_name = .initWithLatin("right_move", false);
            self.negative_y_name = .initWithLatin("up_move", false);
            self.positive_y_name = .initWithLatin("down_move", false);
        },
        Node.notification_ready => {
            Node.setProcess(self, true);
            Node.setPhysicsProcess(self, true);

            Object.connect(self, &self.signal_name, &self.callable_on_x_equal_zero, 0) catch @panic("connect signal");
        },
        Node.notification_process => {
            const vec: Vector2f = Input.getSingleton().getVector(&self.negative_x_name, &self.positive_x_name, &self.negative_y_name, &self.positive_y_name, -1);
            const delta: f64 = Node.getProcessDeltaTime(self);
            self.xy.addAssign(vec.mulScalar(@floatCast(self.speed * delta)));
            Node2D.setPosition(self, self.xy);
        },
        Object.notification_predelete => {
            std.log.debug("predetele", .{});
            self.callable_on_x_equal_zero.deinit();
            self.func_name.deinit();
            self.signal_name.deinit();
            self.negative_x_name.deinit();
            self.positive_x_name.deinit();
            self.negative_y_name.deinit();
            self.positive_y_name.deinit();
        },
        else => {},
    }
}

pub fn getXy(self: *const TestNodeABCD) Vector2f {
    return self.xy;
}

pub fn setXy(self: *TestNodeABCD, value: Vector2f) void {
    self.xy = value;
}

pub fn setX(self: *TestNodeABCD, value: f64) void {
    self.x = value;
}

pub fn getX(self: *const TestNodeABCD) f64 {
    return self.x;
}

pub fn setY(self: *TestNodeABCD, value: f64) void {
    self.y = value;
}

pub fn getY(self: *const TestNodeABCD) f64 {
    return self.y;
}

pub fn getSpeed(self: *const TestNodeABCD) f64 {
    return self.speed;
}

pub fn setSpeed(self: *TestNodeABCD, value: f64) void {
    self.speed = value;
}

pub fn getTestResourceABCD(self: *TestNodeABCD) gde.c.GDExtensionObjectPtr {
    return self.test_resource_abcd.ptr().?.base;
}

pub fn setTestResourceABCD(self: *TestNodeABCD, value: gde.c.GDExtensionObjectPtr) void {
    self.test_resource_abcd = @ptrCast(@alignCast(gde.ci.object_get_instance_binding.?(value, gde.library, &TestResourceABCD.GodotStruct.binding_callbacks)));
    _ = RefCounted.reference(self.test_resource_abcd.?);
}

pub fn onXEqualZero(_: *const TestNodeABCD, number: i64) void {
    std.log.debug("onXEqualZero: {d}", .{number});
}

const TestNodeABCD = @This();

pub const GodotStruct: type = mixins.GodotStructMixin(TestNodeABCD, Sprite2D);
pub const GodotExport = .{
    .methods = .{
        .{ .func = getXy, .args = .{} },
        .{ .func = setXy, .args = .{.{ .name = "value", .type = Vector2f }} },
        .{ .func = getSpeed, .args = .{} },
        .{ .func = setSpeed, .args = .{.{ .name = "value", .type = f64 }} },
        .{ .func = getX, .args = .{} },
        .{ .func = setX, .args = .{.{ .name = "value", .type = f64 }} },
        .{ .func = getY, .args = .{} },
        .{ .func = setY, .args = .{.{ .name = "value", .type = f64 }} },
        .{ .func = onXEqualZero, .args = .{.{ .name = "number", .type = i64 }} },
        .{ .func = getTestResourceABCD, .args = .{} },
        .{ .func = setTestResourceABCD, .args = .{.{ .name = "value", .type = gde.c.GDExtensionObjectPtr }} },
    },
    .properties = .{
        .{ .name = "xy", .getter = getXy, .setter = setXy, .hint = internal.PropertyHint.none, .hints = "", .usage = internal.PropertyUsageFlags.default },
        .{ .name = "x", .getter = getX, .setter = setX, .hint = internal.PropertyHint.range, .hints = "0,100,0.1,suffix:u", .usage = internal.PropertyUsageFlags.default },
        .{ .name = "y", .getter = getY, .setter = setY, .hint = internal.PropertyHint.none, .hints = "", .usage = internal.PropertyUsageFlags.default },
        .{ .name = "speed", .getter = getSpeed, .setter = setSpeed, .hint = internal.PropertyHint.none, .hints = "", .usage = internal.PropertyUsageFlags.default },
        .{ .name = "test_resource_abcd", .getter = getTestResourceABCD, .setter = setTestResourceABCD, .hint = internal.PropertyHint.resource_type, .hints = "TestResourceABCD", .usage = internal.PropertyUsageFlags.default },
    },
    .signals = .{
        .{ .name = "on_x_equal_zero", .args = .{.{ .name = "number", .type = i64 }} },
    },
};
