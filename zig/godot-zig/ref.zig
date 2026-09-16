const godot: type = @import("godot.zig");
const RefCounted: type = godot.RefCounted;
const memory: type = godot.memory;

pub fn Ref(comptime T: type) type {
    return struct {
        instance: ?*T = null,

        pub fn ptr(self: *Ref(T)) ?*T {
            if (self.instance) |instance| {
                return instance;
            }

            return null;
        }

        pub fn reference(self: *Ref(T), other: *T) void {
            if (self.instance.? == other) {
                return;
            }

            if (self.instance) {
                self.unreference();
            }

            RefCounted.reference(other);
            self.instance = other;
        }

        pub fn unreference(self: *Ref(T)) void {
            if (self.instance and RefCounted.unreference(self.instance)) {
                memory.memdelete(self.instance);
            }
            self.instance = null;
        }
    };
}

// pub const ToNative: type = struct {
//     pub fn pack() void {}
//     pub fn unpack() Ref()
// };
