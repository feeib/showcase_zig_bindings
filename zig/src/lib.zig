pub const std = @import("std");

const godot: type = @import("godot");
const gde: type = godot.gde;
const internal: type = godot.internal;
const UtilityFunctions = godot.UtilityFunctions;
const String = godot.String;
const Variant = godot.Variant;
const ClassDB: type = godot.ClassDB;

const TestNodeABCD = @import("TestNodeABCD.zig");
const TestResourceABCD = @import("TestResourceABCD.zig");

pub const std_options = std.Options{
    .logFn = godotLog,
};

pub fn godotLog(
    comptime level: std.log.Level,
    comptime scope: @TypeOf(.enum_litaral),
    comptime format: []const u8,
    args: anytype,
) void {
    _ = scope;

    if (level != .debug) return;

    const buf: []u8 = std.fmt.allocPrintSentinel(std.heap.c_allocator, format, args, 0) catch @panic("alloc print sentinel");
    defer std.heap.c_allocator.free(buf);

    var str: String = .initWithUtf8(buf);
    defer str.deinit();

    var vrt: Variant = .init(&str);
    defer vrt.deinit();

    UtilityFunctions.print(.{vrt});
}

pub fn onInitialize(
    self: ?*anyopaque,
    level: c_uint,
) callconv(.c) void {
    _ = self;
    if (level != gde.c.GDEXTENSION_INITIALIZATION_SCENE) return;

    internal.StringInternal.initializeBingings();
    internal.StringNameInternal.initializeBindings();
    internal.CallableInternal.initializeBindings();
    internal.VariantInternal.initializeBindings();
    internal.ObjectInternal.initializeBindings();
    internal.InputInternal.initializeBindings();
    internal.NodeInternal.initializeBindings();
    internal.Node2DInternal.initializeBindings();
    internal.RefCountedInternal.initializeBindings();

    ClassDB.registerClass(TestNodeABCD) catch @panic("register class");
    ClassDB.registerClass(TestResourceABCD) catch @panic("register class");
}

pub fn onDeinitialize(
    self: ?*anyopaque,
    level: c_uint,
) callconv(.c) void {
    _ = self;
    _ = level;
}

export fn libraryInit(
    p_proc_address: gde.c.GDExtensionInterfaceGetProcAddress,
    p_library: gde.c.GDExtensionClassLibraryPtr,
    r_initialization: *gde.c.GDExtensionInitialization,
) callconv(.c) gde.c.GDExtensionBool {
    gde.get_proc_address = p_proc_address;
    gde.library = p_library;

    gde.ci = gde.Interfaces.init() catch {
        return 0;
    };

    r_initialization.initialize = onInitialize;
    r_initialization.deinitialize = onDeinitialize;
    r_initialization.minimum_initialization_level = gde.c.GDEXTENSION_INITIALIZATION_SCENE;
    r_initialization.userdata = null; // userdata goes to "self" in onDeint and onInit

    return 1;
}
