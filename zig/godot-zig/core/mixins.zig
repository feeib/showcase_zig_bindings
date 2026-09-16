const std: type = @import("std");

const godot: type = @import("../godot.zig");
const gde: type = godot.gde;
const StringName: type = godot.StringName;
const Object: type = godot.Object;
const misc: type = godot.misc;

pub fn GodotStructMixin(T: type, B: type) type {
    return struct {
        pub var binding_callbacks: gde.c.GDExtensionInstanceBindingCallbacks = .{
            .create_callback = createCallback,
            .free_callback = freeCallback,
            .reference_callback = referenceCallback,
        };

        pub fn getStructName() StringName {
            return .initWithLatin(misc.typeName(T), true);
        }

        pub fn getParentName() StringName {
            return .initWithLatin(misc.typeName(B), true);
        }

        pub fn free(
            data: ?*anyopaque,
            ptr: gde.c.GDExtensionClassInstancePtr,
        ) callconv(.c) void {
            const instance: *T = @ptrCast(@alignCast(ptr.?));
            std.log.debug("free: class {f}", .{T.GodotStruct.getStructName()});
            std.log.debug("ptr: {any} instance: {} data: {any}", .{ ptr.?, instance, data });
            std.heap.c_allocator.destroy(instance);
        }

        pub fn notificationBind(
            instance: gde.c.GDExtensionClassInstancePtr,
            what: i32,
            _: gde.c.GDExtensionBool, //reversed
        ) callconv(.c) void {
            if (@hasDecl(T, "notification")) {
                const self: *T = @ptrCast(@alignCast(instance.?));
                self.notification(what);
            }
        }

        pub fn createCallback(_: ?*anyopaque, _: ?*anyopaque) callconv(.c) ?*anyopaque {
            return null;
        }

        pub fn freeCallback(_: ?*anyopaque, _: ?*anyopaque, _: ?*anyopaque) callconv(.c) void {}

        pub fn referenceCallback(_: ?*anyopaque, _: ?*anyopaque, _: gde.c.GDExtensionBool) callconv(.c) gde.c.GDExtensionBool {
            return @intFromBool(false);
        }
    };
}

pub fn GodotBindingStructMixin(T: type, B: type) type {
    return struct {
        pub var binding_callbacks: gde.c.GDExtensionInstanceBindingCallbacks = .{
            .create_callback = createCallback,
            .free_callback = freeCallback,
            .reference_callback = referenceCallback,
        };

        pub fn getStructName() StringName {
            return .initWithLatin(misc.typeName(T), true);
        }

        pub fn getParentName() StringName {
            return .initWithLatin(misc.typeName(B), true);
        }

        pub fn free(
            _: ?*anyopaque,
            _: gde.c.GDExtensionClassInstancePtr,
        ) callconv(.c) void {}

        pub fn notificationBind(
            _: gde.c.GDExtensionClassInstancePtr,
            _: i32,
            _: gde.c.GDExtensionBool,
        ) callconv(.c) void {}

        pub fn createCallback(_: ?*anyopaque, instance: ?*anyopaque) callconv(.c) ?*anyopaque {
            const new_object: *T = std.heap.c_allocator.create(T) catch @panic("create new object");
            new_object.base = instance;
            return new_object;
        }

        pub fn freeCallback(_: ?*anyopaque, ptr: ?*anyopaque, _: ?*anyopaque) callconv(.c) void {
            const instance: *T = @ptrCast(@alignCast(ptr.?));
            std.log.debug("free: class {f}", .{T.GodotStruct.getStructName()});
            std.heap.c_allocator.destroy(instance);
        }

        pub fn referenceCallback(_: ?*anyopaque, _: ?*anyopaque, _: gde.c.GDExtensionBool) callconv(.c) gde.c.GDExtensionBool {
            return @intFromBool(true);
        }
    };
}
