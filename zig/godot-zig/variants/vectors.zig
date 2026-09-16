pub fn Vector2(comptime T: type) type {
    return extern struct {
        x: T,
        y: T,

        pub fn init(x: T, y: T) Vector2(T) {
            return .{ .x = x, .y = y };
        }

        pub fn add(self: *const Vector2(T), other: Vector2(T)) Vector2(T) {
            return .init(self.x + other.x, self.y + other.y);
        }

        pub fn mul(self: *const Vector2(T), other: Vector2(T)) Vector2(T) {
            return .init(self.x * other.x, self.y * other.y);
        }

        pub fn addScalar(self: *const Vector2(T), other: T) Vector2(T) {
            return .init(self.x + other, self.y + other);
        }

        pub fn mulScalar(self: *const Vector2(T), other: T) Vector2(T) {
            return .init(self.x * other, self.y * other);
        }

        pub fn addAssign(self: *Vector2(T), other: Vector2(T)) void {
            self.x += other.x;
            self.y += other.y;
        }

        pub fn mulAssign(self: *Vector2(T), other: Vector2(T)) void {
            self.x *= other.x;
            self.y *= other.y;
        }
    };
}
