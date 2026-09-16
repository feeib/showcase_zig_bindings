const std = @import("std");

const godot: type = @import("godot.zig");
const gde: type = godot.gde;
const Object: type = godot.Object;
const String: type = godot.String;
const internal: type = godot.internal;
const StringName: type = godot.StringName;
const UtilityFunctions: type = godot.UtilityFunctions;
const Variant: type = godot.Variant;

fn makeCreateInstanceFunc(comptime T: type) fn (?*anyopaque, gde.c.GDExtensionBool) callconv(.c) gde.c.GDExtensionObjectPtr {
    return struct {
        pub fn createInstanceFunc(data: ?*anyopaque, notify_postinitialize: gde.c.GDExtensionBool) callconv(.c) gde.c.GDExtensionObjectPtr {
            _ = data;
            var struct_name: StringName = T.GodotStruct.getStructName();
            var parent_name: StringName = T.GodotStruct.getParentName();

            const new_object: *T = std.heap.c_allocator.create(T) catch @panic("create new object");
            const new_godot_object: gde.c.GDExtensionObjectPtr = gde.ci.classdb_construct_object2.?(&parent_name);

            new_object.* = .{};
            new_object.base = new_godot_object;

            gde.ci.object_set_instance.?(new_godot_object, &struct_name, new_object);
            gde.ci.object_set_instance_binding.?(new_godot_object, gde.library, new_object, &T.GodotStruct.binding_callbacks);

            if (notify_postinitialize != 0) {
                std.log.debug("create: notify_postinitialize", .{});
                Object.notification(new_object, Object.notification_postinitialize, false);
            }

            std.log.debug("create: class {f} with parent {f}", .{ &struct_name, &parent_name });

            return new_godot_object;
        }
    }.createInstanceFunc;
}

pub fn registerClass(class: type) !void {
    const creation_info: gde.c.GDExtensionClassCreationInfo4 = .{
        .is_abstract = 0,
        .is_exposed = 1,
        .is_virtual = 0,
        .is_runtime = 1,
        .icon_path = null,
        .set_func = null,
        .get_func = null,
        .get_property_list_func = null,
        .free_property_list_func = null,
        .property_can_revert_func = null,
        .property_get_revert_func = null,
        .validate_property_func = null,
        .notification_func = class.GodotStruct.notificationBind,
        .to_string_func = null,
        .reference_func = null,
        .unreference_func = null,
        .create_instance_func = makeCreateInstanceFunc(class),
        .free_instance_func = class.GodotStruct.free,
        .recreate_instance_func = null,
        .get_virtual_func = null,
        .get_virtual_call_data_func = null,
        .call_virtual_with_data_func = null,
        .class_userdata = null,
    };

    var struct_name: StringName = class.GodotStruct.getStructName();
    var parent_name: StringName = class.GodotStruct.getParentName();

    gde.ci.classdb_register_extension_class5.?(gde.library, &struct_name, &parent_name, @ptrCast(&creation_info));

    internal.bindMembers(class);

    std.log.debug("registered: class {f} with parent {f}", .{ &struct_name, &parent_name });
}
